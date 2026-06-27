import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:myapp/services/call_service.dart';

class CallScreen extends StatefulWidget {
  final String callerId;
  final String calleeId;
  final String? callId;

  const CallScreen({
    super.key,
    required this.callerId,
    required this.calleeId,
    this.callId,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  final _callService = CallService();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  String? _callId;
  final List<RTCIceCandidate> _pendingIceCandidates = [];
  bool _isCaller = false;
  bool _isMicMuted = false;
  bool _isVideoMuted = false;
  bool _isFrontCamera = true;
  bool _isCallConnected = false;
  bool _isInitializing = true;
  bool _hasAnswered = false;
  Duration _elapsed = Duration.zero;
  String? _errorMessage;

  // Abonnements aux flux, à annuler lors du dispose
  StreamSubscription? _answerSubscription;
  StreamSubscription? _iceCandidatesSubscription;
  Timer? _callTimer;

  @override
  void initState() {
    super.initState();
    _startCall();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _localStream?.dispose();
    _peerConnection?.dispose();
    _answerSubscription?.cancel();
    _iceCandidatesSubscription?.cancel();
    _callTimer?.cancel();
    super.dispose();
  }

  Future<void> _startCall() async {
    try {
      await _localRenderer.initialize();
      await _remoteRenderer.initialize();

      _isCaller = widget.callerId == _callService.getCurrentUserId();

      if (_isCaller) {
        final isCalleeOnline = await _callService.isUserOnline(widget.calleeId);
        if (!isCalleeOnline) {
          throw StateError('callee-offline');
        }
      }

      await _initializePeerConnection(_isCaller);

      if (_isCaller) {
        await _createCall();
      } else {
        await _joinCall();
      }

      if (mounted) {
        setState(() => _isInitializing = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _errorMessage = e.toString().contains('callee-offline')
              ? 'Cet utilisateur est hors ligne pour le moment.'
              : 'Impossible d’accéder à la caméra ou au micro. Vérifiez les permissions de l’application.';
        });
      }
    }
  }

  Future<void> _initializePeerConnection(bool isCaller) async {
    _isCaller = isCaller;
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };
    _peerConnection = await createPeerConnection(configuration, {});

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {
        'facingMode': 'user',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
      },
    });
    _localRenderer.srcObject = _localStream;
    if (mounted) setState(() {});
    for (final track in _localStream?.getTracks() ?? <MediaStreamTrack>[]) {
      _peerConnection?.addTrack(track, _localStream!);
    }

    _peerConnection?.onConnectionState = (state) {
      if (!mounted) return;
      setState(() {
        _isCallConnected =
            state == RTCPeerConnectionState.RTCPeerConnectionStateConnected;
      });
    };

    _peerConnection?.onIceCandidate = (candidate) {
      if (_callId != null) {
        _callService.addIceCandidate(_callId!, candidate, _isCaller);
      } else {
        _pendingIceCandidates.add(candidate);
      }
    };

    _peerConnection?.onTrack = (event) {
      if (event.streams.isNotEmpty && event.track.kind == 'video') {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };
  }

  Future<void> _createCall() async {
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    final callId = await _callService.createCall(
      offer,
      widget.callerId,
      widget.calleeId,
    );
    setState(() {
      _callId = callId;
    });

    await _flushPendingIceCandidates();

    _answerSubscription = _callService.getAnswerStream(callId).listen((answer) {
      _peerConnection?.setRemoteDescription(answer);
      _markCallAnswered();
    });

    _iceCandidatesSubscription = _callService
        .getIceCandidatesStream(callId, true)
        .listen((candidate) {
          _peerConnection?.addCandidate(candidate);
        });
  }

  Future<void> _joinCall() async {
    final callId =
        widget.callId ?? await _callService.getCallId(widget.calleeId);
    if (callId != null) {
      setState(() {
        _callId = callId;
      });
      await _flushPendingIceCandidates();

      final offer = await _callService.getOffer(callId);
      if (offer != null) {
        await _peerConnection!.setRemoteDescription(offer);

        final answer = await _peerConnection!.createAnswer();
        await _peerConnection!.setLocalDescription(answer);

        await _callService.joinCall(callId, answer);
        _markCallAnswered();

        _iceCandidatesSubscription = _callService
            .getIceCandidatesStream(callId, false)
            .listen((candidate) {
              _peerConnection?.addCandidate(candidate);
            });
      }
    }
  }

  void _toggleMic() {
    setState(() {
      _isMicMuted = !_isMicMuted;
    });
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = !_isMicMuted;
    });
  }

  void _toggleVideo() {
    setState(() {
      _isVideoMuted = !_isVideoMuted;
    });
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = !_isVideoMuted;
    });
  }

  void _switchCamera() async {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks().first;
      await Helper.switchCamera(videoTrack);
      setState(() {
        _isFrontCamera = !_isFrontCamera;
      });
    }
  }

  Future<void> _flushPendingIceCandidates() async {
    if (_callId == null || _pendingIceCandidates.isEmpty) return;

    for (final candidate in List<RTCIceCandidate>.from(_pendingIceCandidates)) {
      await _callService.addIceCandidate(_callId!, candidate, _isCaller);
    }
    _pendingIceCandidates.clear();
  }

  void _markCallAnswered() {
    if (_hasAnswered) return;

    setState(() {
      _hasAnswered = true;
      _isCallConnected = true;
      _elapsed = Duration.zero;
    });

    _callTimer?.cancel();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  Future<void> _endCall() async {
    _callTimer?.cancel();
    _localStream?.dispose();
    _peerConnection?.close();
    if (_callId != null) {
      if (_hasAnswered) {
        await _callService.endCall(_callId!);
      } else if (_isCaller) {
        await _callService.cancelCall(_callId!);
      } else {
        await _callService.declineCall(_callId!);
      }
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  String _formatElapsed() {
    final minutes = _elapsed.inMinutes.toString().padLeft(2, '0');
    final seconds = (_elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Vidéo distante en plein écran
            Positioned.fill(
              child: RTCVideoView(
                _remoteRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
            ),

            // Vidéo locale en petit
            Positioned(
              top: 20,
              right: 20,
              width: 120,
              height: 160,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: RTCVideoView(
                    _localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ),

            if (_isInitializing || _errorMessage != null)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.72),
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: _errorMessage == null
                        ? const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 16),
                              Text(
                                'Préparation caméra et micro...',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.no_photography_outlined,
                                color: Colors.white,
                                size: 56,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              FilledButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Retour'),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

            // Indicateur de statut
            Positioned(
              top: 40,
              left: 20,
              right: 150,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _isCallConnected
                      ? 'Appel en cours • ${_formatElapsed()}'
                      : 'Connexion en cours...',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Contrôles d'appel
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: _isMicMuted ? Icons.mic_off : Icons.mic,
                      label: _isMicMuted ? 'Activer' : 'Couper',
                      color: _isMicMuted ? Colors.red : Colors.white,
                      onPressed: _toggleMic,
                    ),
                    _buildControlButton(
                      icon: _isVideoMuted ? Icons.videocam_off : Icons.videocam,
                      label: _isVideoMuted ? 'Activer' : 'Couper',
                      color: _isVideoMuted ? Colors.red : Colors.white,
                      onPressed: _toggleVideo,
                    ),
                    _buildControlButton(
                      icon: Icons.flip_camera_ios,
                      label: 'Caméra',
                      color: Colors.white,
                      onPressed: _switchCamera,
                    ),
                    _buildControlButton(
                      icon: Icons.call_end,
                      label: 'Raccrocher',
                      color: Colors.red,
                      onPressed: () => _endCall(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: color.withValues(alpha: 0.2),
            foregroundColor: color,
            elevation: 0,
          ),
          child: Icon(icon, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

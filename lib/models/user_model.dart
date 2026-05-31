class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? level;

  UserModel({required this.uid, this.displayName, this.email, this.level});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      displayName: map['displayName'],
      email: map['email'],
      level: map['level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'level': level,
    };
  }
}

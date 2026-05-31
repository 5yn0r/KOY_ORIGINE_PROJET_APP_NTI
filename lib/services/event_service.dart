import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/event_model.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Créer un événement par défaut s'il n'existe pas
  Future<void> initializeDefaultEvents() async {
    try {
      final eventsRef = _firestore.collection('cultural_events');
      final snapshot = await eventsRef.get();
      
      if (snapshot.docs.isEmpty) {
        // Créer un événement par défaut
        await eventsRef.add({
          'title': 'Pâques, la Fête de Pâquinou',
          'description': 'La fête du pâquinou est une célébration traditionnelle baoulé marquant la fin de la récolte. C\'est un moment de gratitude envers la terre et les ancêtres .',
          'location': 'Région de Yamoussoukro & Bouaké, Côte d\'Ivoire',
          'dateTime': Timestamp.fromDate(DateTime(2026, 4, 06)),
          'imageUrl': null,
          'category': 'Fête Traditionnelle',
        });
      }
    } catch (e) {
      print('Erreur lors de l\'initialisation des événements: $e');
    }
  }

  // Récupérer tous les événements
  Stream<List<CulturalEvent>> getEventsStream() {
    return _firestore
        .collection('cultural_events')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CulturalEvent.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Récupérer le nombre d'événements
  Future<int> getEventCount() async {
    try {
      final snapshot = await _firestore.collection('cultural_events').get();
      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  // Ajouter un nouvel événement
  Future<void> addEvent(CulturalEvent event) async {
    try {
      await _firestore.collection('cultural_events').add(event.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Mettre à jour un événement
  Future<void> updateEvent(String eventId, CulturalEvent event) async {
    try {
      await _firestore
          .collection('cultural_events')
          .doc(eventId)
          .update(event.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Supprimer un événement
  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('cultural_events').doc(eventId).delete();
    } catch (e) {
      rethrow;
    }
  }
}

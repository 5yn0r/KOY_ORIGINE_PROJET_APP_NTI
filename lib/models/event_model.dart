import 'package:cloud_firestore/cloud_firestore.dart';

class CulturalEvent {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime dateTime;
  final String? imageUrl;
  final String category; // 'Fête', 'Célébration', 'Rituel', etc.

  CulturalEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    this.imageUrl,
    required this.category,
  });

  factory CulturalEvent.fromMap(Map<String, dynamic> map, String id) {
    return CulturalEvent(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      dateTime: (map['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: map['imageUrl'],
      category: map['category'] ?? 'Événement',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'dateTime': Timestamp.fromDate(dateTime),
      'imageUrl': imageUrl,
      'category': category,
    };
  }
}

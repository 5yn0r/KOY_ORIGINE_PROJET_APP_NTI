import 'package:cloud_firestore/cloud_firestore.dart';

class Module {
  final String id;
  final String title;
  final String description;
  final String level;
  final String imageUrl;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.imageUrl,
  });

  factory Module.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Module(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      level: data['level'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

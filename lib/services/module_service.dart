import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/module_model.dart';

class ModuleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Module>> getModules() {
    return _firestore.collection('modules').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Module.fromFirestore(doc)).toList();
    });
  }
}

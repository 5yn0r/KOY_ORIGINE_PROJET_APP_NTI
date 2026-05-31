import 'dart:async';
import '../data/all_lessons.dart';
import 'package:myapp/models/lesson_model.dart';

class LessonService {
  Stream<List<Lesson>> getLessons(String moduleId) {
    final lessons = List<Lesson>.from(allLessons[moduleId] ?? []);
    lessons.sort((a, b) => a.order.compareTo(b.order));
    return Stream.value(lessons);
  }
}

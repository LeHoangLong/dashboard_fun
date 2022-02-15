import 'package:flutter/widgets.dart';

class CourseModel {
  final int id;
  final String name;
  final int videoCount;
  final String image;

  const CourseModel({
    required this.id,
    required this.name,
    required this.videoCount,
    required this.image,
  });
}

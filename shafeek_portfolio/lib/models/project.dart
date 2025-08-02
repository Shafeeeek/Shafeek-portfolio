// lib/models/project.dart
class Project {
  final String title;
  final String description;
  final String details;
  final String? demoUrl;
  final String? codeUrl;
  final String? videoUrl;

  Project({
    required this.title,
    required this.description,
    required this.details,
    this.demoUrl,
    this.codeUrl,
    this.videoUrl,
  });
}
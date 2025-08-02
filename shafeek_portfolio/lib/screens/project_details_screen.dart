// lib/screens/project_details_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({super.key, required this.project});


  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url.trim());
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open: $url")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: Colors.yellowAccent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  project.details,
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (project.demoUrl != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.language, color: Colors.white),
                    label: const Text("Live Demo"),
                    onPressed: () => _launchURL(context, project.demoUrl!),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                if (project.codeUrl != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.code, color: Colors.white),
                    label: const Text("Source Code"),
                    onPressed: () => _launchURL(context, project.codeUrl!),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
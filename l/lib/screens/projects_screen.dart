import 'package:flutter/material.dart';
import '../models/project.dart';
import 'project_details_screen.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({super.key});

  final List<Project> projects = [
    Project(
      title: 'Portfolio App',
      description: 'Built with Flutter for Web & Mobile',
      details:
          'A responsive portfolio app built using Flutter, supporting both web and mobile platforms with smooth animations and clean UI.',
    ),
    Project(
      title: 'E-Commerce App',
      description: 'Full-featured shopping app',
      details:
          'This app includes user authentication, product browsing, cart management, and payment integration using Stripe.',
    ),
    Project(
      title: 'Chat App',
      description: 'Real-time messaging with Firebase',
      details:
          'A real-time chat application built using Firebase Firestore and Firebase Authentication for secure messaging.',
    ),
    Project(
      title: 'Weather Dashboard',
      description: 'Live weather updates using OpenWeather API',
      details:
          'Displays current and forecasted weather information by fetching data from the OpenWeatherMap API with location support.',
    ),
    Project(
      title: 'Task Manager',
      description: 'Productivity app with local and cloud sync',
      details:
          'A task manager app that allows users to create, edit, and delete tasks with syncing capabilities using Firebase.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              elevation: 0,
              title: const Text(
                "My Projects",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 210, 255, 49),
                ),
              ),
              centerTitle: true,
            ),
            const SizedBox(height: 10),
            const Text(
              "Here are some of the projects I've worked on. They showcase my skills in Flutter, Firebase, and responsive design.",
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 149, 233, 23),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600
                      ? 3
                      : 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProjectDetailsPage(project: projects[index]),
                        ),
                      );
                    },
                    child: projectCard(
                      projects[index].title,
                      projects[index].description,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget projectCard(String title, String description) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.apps, size: 40, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

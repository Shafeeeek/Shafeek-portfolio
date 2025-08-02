// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:l/screens/login_page.dart';
import 'package:l/screens/signup_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 15),
              const Text(
                'Mohamed Alaaeldin Shafeek',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Flutter Developer | AI & Web Enthusiast',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  '🎓 Education: B.Sc. in Computer Science Graduted in 2025 At Future University In Egypt \n'
                  '🔧 Tech Skills: Python, Java, C++, JS, TS, Django, ReactJS, JavaFX\n'
                  'AI/ML: NumPy, pandas, PyTorch, TensorFlow, Scikit-learn\n'
                  'DB: MySQL, MongoDB | Web: HTML, CSS, JS\n'
                  '🚀 Projects: AI Diabetes Risk System, AI Inventory with NLP & Image Processing, PlayStation Rental App, CRUD System\n'
                  '💼 Experience: App Devlopment | NLP Sentiment Analysis Model Trainer\n'
                  '🧠 Soft Skills: Communication, Teamwork, Problem Solving, Adaptability',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    height: 1.6,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  skillChip('Flutter'),
                  skillChip('Dart'),
                  skillChip('NLP'),
                  skillChip('AppDevlopment'),
                  skillChip('AI Eduction'),
                  skillChip('DjangoDB'),
                  skillChip('Python'),
                ],
              ),
              const SizedBox(height: 70),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 50,
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(
                        onRegisterClick: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignUpPage(
                                onLoginClick: () => Navigator.pop(context),
                                onSignUp: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Account created!"),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        onForgotPassword: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password reset link sent!"),
                            ),
                          );
                        },
                        onLogin: () {
                          Navigator.pop(context); // Go back to home
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Logged in successfully!"),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget skillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}

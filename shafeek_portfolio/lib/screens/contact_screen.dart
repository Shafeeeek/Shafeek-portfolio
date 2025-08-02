// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  // ✅ Accept BuildContext as a parameter
  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // ✅ Now context is available and valid
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not open URL: $url")));
    }
  }

  void _sendEmail(BuildContext context) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mohmedshii02@gmail.com',
      queryParameters: {
        'subject': 'Contact from Portfolio App',
        'body':
            'Hello Mohamed,\nI would like to get in touch with you.\nBest regards,\n[Your Name]',
      },
    );
    _launchURL(context, emailLaunchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Me'),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 223, 255, 45),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Feel free to reach out via any of the platforms below.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Email
              ListTile(
                leading: const Icon(Icons.email, color: Colors.white),
                title: const Text(
                  'mohmedshii02@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                trailing: ElevatedButton.icon(
                  icon: const Icon(Icons.mail, size: 16),
                  label: const Text('Send Email'),
                  onPressed: () => _sendEmail(context), // ✅ Pass context
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Divider(),

              // Phone
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text(
                  '+20 100 460 3038',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: const Text(
                  'Phone',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: ElevatedButton.icon(
                  icon: const Icon(Icons.message, size: 16),
                  label: const Text('Send Message'),
                  onPressed: () => _launchURL(
                    context,
                    'sms:+201004603038',
                  ), // ✅ Pass context
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Divider(),

              // LinkedIn
              ListTile(
                leading: const Icon(Icons.link, color: Colors.blue),
                title: const Text(
                  'LinkedIn Profile',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'linkedin.com/in/mohamed-a-shafeek',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('View Profile'),
                  onPressed: () => _launchURL(
                    context,
                    'https://www.linkedin.com/in/mohamed-a-shafeek-/',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Divider(),

              // GitHub
              ListTile(
                leading: Icon(Icons.code, color: Colors.black.withOpacity(0.7)),
                title: const Text(
                  'GitHub Profile',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'github.com/Shafeeeek',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Visit'),
                  onPressed: () =>
                      _launchURL(context, 'https://github.com/Shafeeeek/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

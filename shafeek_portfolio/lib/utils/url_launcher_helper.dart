// lib/utils/url_launcher_helper.dart
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void sendEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'mohmedshii02@gmail.com',
      queryParameters: {
        'subject': 'Contact from Portfolio App',
        'body': 'Hello Mohamed,\nI would like to get in touch with you.\nBest regards,\n[Your Name]'
      },
    );
    launchURL(emailLaunchUri.toString());
  }
}
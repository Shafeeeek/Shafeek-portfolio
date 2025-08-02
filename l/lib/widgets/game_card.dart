// lib/widgets/game_card.dart
import 'package:flutter/material.dart';

Widget gameCard(BuildContext context, String title, IconData icon, Widget page) {
  return GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
    child: Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.black),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.black, fontSize: 18)),
          ],
        ),
      ),
    ),
  );
}
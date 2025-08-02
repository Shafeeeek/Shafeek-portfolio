// lib/screens/games_screen.dart
import 'package:flutter/material.dart';
import '../games/snake_game_screen.dart';
import '../games/crash_ball_game_screen.dart';
import '../games/sudoku_game_screen.dart';
import '../widgets/game_card.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 223, 255, 45),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            gameCard(
              context,
              "Snake Game",
              Icons.videogame_asset,
              const SnakeGameScreen(),
            ),
            gameCard(
              context,
              "Crash Ball",
              Icons.sports_baseball,
              const CrashBallGameScreen(),
            ),
            gameCard(
              context,
              "Sudoku",
              Icons.grid_3x3,
              const SudokuGameScreen(),
            ), // ✅ Added
          ],
        ),
      ),
    );
  }
}

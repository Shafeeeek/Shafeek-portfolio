// lib/games/crash_ball_game_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';

class CrashBallGameScreen extends StatefulWidget {
  const CrashBallGameScreen({super.key});

  @override
  State<CrashBallGameScreen> createState() => _CrashBallGameScreenState();
}

class _CrashBallGameScreenState extends State<CrashBallGameScreen> {
  double ballX = 0;
  double ballY = 0;
  double ballDX = 0.02;
  double ballDY = 0.02;
  double paddleX = 0;
  double paddleWidth = 0.3;
  bool isGameOver = false;
  late Timer gameTimer;

  void startGame() {
    isGameOver = false;
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        ballX += ballDX;
        ballY += ballDY;

        if (ballX <= -1 || ballX >= 1) ballDX = -ballDX;
        if (ballY <= -1) ballDY = -ballDY;

        if (ballY >= 0.9 && ballX >= paddleX && ballX <= paddleX + paddleWidth) {
          ballDY = -ballDY;
        }

        if (ballY > 1) {
          isGameOver = true;
          gameTimer.cancel();
        }
      });
    });
  }

  void restartGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      ballDX = 0.02;
      ballDY = 0.02;
      paddleX = 0;
      isGameOver = false;
    });
    startGame();
  }

  void movePaddle(bool isLeft) {
    setState(() {
      if (isLeft) {
        paddleX -= 0.1;
        if (paddleX < -1) paddleX = -1;
      } else {
        paddleX += 0.1;
        if (paddleX + paddleWidth > 1) paddleX = 1 - paddleWidth;
      }
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crash Ball")),
      body: Stack(
        children: [
          Container(color: Colors.black),
          if (!isGameOver)
            Align(
              alignment: Alignment(ballX, ballY),
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            ),
          Align(
            alignment: Alignment(paddleX, 0.95),
            child: Container(
              width: MediaQuery.of(context).size.width * paddleWidth / 2,
              height: 20,
              color: Colors.green,
            ),
          ),
          if (isGameOver)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Game Over!", style: TextStyle(color: Colors.white, fontSize: 30)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: restartGame,
                    child: const Text("Restart"),
                  )
                ],
              ),
            ),
          Positioned(
            bottom: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_left, size: 40, color: Colors.white),
              onPressed: () => movePaddle(true),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_right, size: 40, color: Colors.white),
              onPressed: () => movePaddle(false),
            ),
          ),
          if (!isGameOver)
            Positioned(
              bottom: 80,
              left: MediaQuery.of(context).size.width / 2 - 40,
              child: ElevatedButton(
                onPressed: startGame,
                child: const Text("Start"),
              ),
            ),
        ],
      ),
    );
  }
}
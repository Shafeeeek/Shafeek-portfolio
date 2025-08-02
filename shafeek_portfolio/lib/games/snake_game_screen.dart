// lib/games/snake_game_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int rows = 20;
  static const int columns = 20;
  List<Offset> snake = [Offset(10, 10)];
  Offset food = Offset(5, 5);
  String direction = 'right';
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    const duration = Duration(milliseconds: 200);
    Future.doWhile(() async {
      await Future.delayed(duration);
      if (isGameOver) return false;
      setState(() {
        moveSnake();
      });
      return true;
    });
  }

  void moveSnake() {
    Offset newHead = snake.first;
    switch (direction) {
      case 'up': newHead = Offset(newHead.dx, newHead.dy - 1); break;
      case 'down': newHead = Offset(newHead.dx, newHead.dy + 1); break;
      case 'left': newHead = Offset(newHead.dx - 1, newHead.dy); break;
      case 'right': newHead = Offset(newHead.dx + 1, newHead.dy); break;
    }

    if (newHead.dx < 0 || newHead.dy < 0 || newHead.dx >= columns || newHead.dy >= rows || snake.contains(newHead)) {
      isGameOver = true;
      return;
    }

    snake.insert(0, newHead);
    if (newHead == food) {
      food = Offset(
        (columns * (0.1 + 0.8 * Random().nextDouble())).floorToDouble(),
        (rows * (0.1 + 0.8 * Random().nextDouble())).floorToDouble(),
      );
    } else {
      snake.removeLast();
    }
  }

  void changeDirection(String newDirection) {
    if ((direction == 'up' && newDirection != 'down') ||
        (direction == 'down' && newDirection != 'up') ||
        (direction == 'left' && newDirection != 'right') ||
        (direction == 'right' && newDirection != 'left')) {
      direction = newDirection;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snake Game')),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0) changeDirection('up');
                if (details.primaryDelta! > 0) changeDirection('down');
              },
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta! < 0) changeDirection('left');
                if (details.primaryDelta! > 0) changeDirection('right');
              },
              child: Container(
                color: Colors.black,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns),
                  itemCount: rows * columns,
                  itemBuilder: (context, index) {
                    int x = index % columns;
                    int y = index ~/ columns;
                    Offset point = Offset(x.toDouble(), y.toDouble());
                    Color color;
                    if (snake.contains(point)) {
                      color = Colors.green;
                    } else if (point == food) {
                      color = Colors.red;
                    } else {
                      color = Colors.grey[900]!;
                    }
                    return Container(margin: const EdgeInsets.all(1), color: color);
                  },
                ),
              ),
            ),
          ),
          if (isGameOver)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Game Over', style: TextStyle(fontSize: 24, color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
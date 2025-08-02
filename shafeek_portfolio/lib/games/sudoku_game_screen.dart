// lib/games/sudoku_game_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';

class SudokuGameScreen extends StatefulWidget {
  const SudokuGameScreen({super.key});

  @override
  State<SudokuGameScreen> createState() => _SudokuGameScreenState();
}

class _SudokuGameScreenState extends State<SudokuGameScreen> {
  // 0 represents empty cells
  final List<List<int>> _solution = [
    [5, 3, 4, 6, 7, 8, 9, 1, 2],
    [6, 7, 2, 1, 9, 5, 3, 4, 8],
    [1, 9, 8, 3, 4, 2, 5, 6, 7],
    [8, 5, 9, 7, 6, 1, 4, 2, 3],
    [4, 2, 6, 8, 5, 3, 7, 9, 1],
    [7, 1, 3, 9, 2, 4, 8, 5, 6],
    [9, 6, 1, 5, 3, 7, 2, 8, 4],
    [2, 8, 7, 4, 1, 9, 6, 3, 5],
    [3, 4, 5, 2, 8, 6, 1, 7, 9],
  ];

  late List<List<int>> _board;
  late List<List<bool>> _isEditable;
  int? _selectedRow;
  int? _selectedCol;

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  void _resetBoard() {
    // Create a puzzle by removing some numbers from the solution
    _board = List.generate(9, (i) => List.generate(9, (j) => _solution[i][j]));
    _isEditable = List.generate(9, (i) => List.generate(9, (j) => true));

    // Remove numbers to create puzzle (keep ~30 filled)
    final rand = Random();
    for (int i = 0; i < 81 - 30; i++) {
      int row, col;
      do {
        row = rand.nextInt(9);
        col = rand.nextInt(9);
      } while (_isEditable[row][col] == false);
      _board[row][col] = 0;
      _isEditable[row][col] = false;
    }
    _selectedRow = null;
    _selectedCol = null;
  }

  bool _isValidMove(int row, int col, int num) {
    // Check row
    for (int c = 0; c < 9; c++) {
      if (c != col && _board[row][c] == num) return false;
    }

    // Check column
    for (int r = 0; r < 9; r++) {
      if (r != row && _board[r][col] == num) return false;
    }

    // Check 3x3 box
    int boxRow = (row ~/ 3) * 3;
    int boxCol = (col ~/ 3) * 3;
    for (int r = boxRow; r < boxRow + 3; r++) {
      for (int c = boxCol; c < boxCol + 3; c++) {
        if ((r != row || c != col) && _board[r][c] == num) return false;
      }
    }

    return true;
  }

  bool _isBoardComplete() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (_board[r][c] == 0) return false;
        if (_board[r][c] != _solution[r][c]) return false;
      }
    }
    return true;
  }

  void _makeMove(int num) {
    if (_selectedRow == null || _selectedCol == null) return;
    final row = _selectedRow!;
    final col = _selectedCol!;

    if (!_isEditable[row][col]) return;

    if (_isValidMove(row, col, num)) {
      setState(() {
        _board[row][col] = num;
      });

      if (_isBoardComplete()) {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("🎉 Puzzle Solved!"),
              content: const Text("Congratulations! You've completed the Sudoku."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _resetBoard();
                  },
                  child: const Text("Play Again"),
                ),
              ],
            ),
          );
        });
      }
    } else {
      // Invalid move feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid move!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sudoku"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Tap a cell and choose a number below",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemCount: 81,
                  itemBuilder: (context, index) {
                    final row = index ~/ 9;
                    final col = index % 9;
                    final isSelected = _selectedRow == row && _selectedCol == col;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRow = row;
                          _selectedCol = col;
                        });
                      },
                      child: Container(
                        color: isSelected
                            ? Colors.blue.withOpacity(0.3)
                            : (row ~/ 3 + col ~/ 3) % 2 == 0
                            ? Colors.grey[900]
                            : Colors.grey[800],
                        child: Center(
                          child: Text(
                            _board[row][col] == 0 ? '' : _board[row][col].toString(),
                            style: TextStyle(
                              color: _isEditable[row][col] ? Colors.white : Colors.yellow,
                              fontWeight: _isEditable[row][col] ? FontWeight.normal : FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Number pad
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(9, (i) {
                return ElevatedButton(
                  onPressed: () => _makeMove(i + 1),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text("${i + 1}", style: const TextStyle(fontSize: 18)),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.restart_alt),
              label: const Text("Reset Puzzle"),
              onPressed: () {
                _resetBoard();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
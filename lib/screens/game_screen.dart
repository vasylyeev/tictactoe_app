import 'package:flutter/material.dart';
import 'package:tictactoe/game_logic/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();

  @override
  void initState() {
    game.board = Game.initGameBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'It\'s $lastValue turn'.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF272C58),
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardLength ~/ 3,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(Game.boardLength, (index) {
                  return GestureDetector(
                    onTap: gameOver
                        ? null
                        : () {
                      if (game.board![index] == '') {
                        setState(() {
                          game.board![index] = lastValue;
                          turn++;
                          gameOver = game.winnerCheck(
                              lastValue, index, scoreboard, 3);
                          if (gameOver) {
                            result = '$lastValue is the winner!';
                          }
                          if (lastValue == "X") {
                            lastValue = "O";
                          } else {
                            lastValue = "X";
                          }
                        });
                      }
                    },
                    child: Container(
                      width: Game.blockSize.toDouble(),
                      height: Game.blockSize.toDouble(),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == 'X'
                                ? const Color(0xFF62D1E2)
                                : const Color(0xFFE95B61),
                            fontSize: 64,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              result,
              style: const TextStyle(
                color: Color(0xFF272C58),
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = '';
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF62D1E2),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              child: const Text('Repeat Game'),
            ),
          ],
        ),
      ),
    );
  }
}
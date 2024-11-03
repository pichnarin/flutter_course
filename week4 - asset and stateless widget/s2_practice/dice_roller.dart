import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const List<String> diceImages = [
  'assets/diceimages/dice-1.png', //0
  'assets/diceimages/dice-2.png', //1
  'assets/diceimages/dice-3.png', //2
  'assets/diceimages/dice-4.png', //3
  'assets/diceimages/dice-5.png', //4
  'assets/diceimages/dice-6.png', //5
];


class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => DiceRollerState();
}

class DiceRollerState extends State<DiceRoller> {
  //randomly change the the dice image
  String activeDiceImage = diceImages[0];

  void rollDice() {
    setState(() {
      if (kDebugMode) {
        print('Current dice: $activeDiceImage');
        print('Current ms: ${DateTime.now().millisecond}');
        print('Current ms % by the length of list of dice images: ${DateTime.now().millisecond % 6}');
      }
      activeDiceImage = diceImages[DateTime.now().millisecond % 6];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}

void main() => runApp(const MaterialApp(
  home: Scaffold(
    backgroundColor: Colors.deepPurple,
    body: Center(child: DiceRoller()),
  ),
));
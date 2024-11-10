import 'package:flutter/material.dart';

//stateful widget to handle the score bar
class ScoreBar extends StatefulWidget {
  final String title;
  final Color textColor;
  final Color backgroundColor;

  const ScoreBar({super.key, this.title = 'Score Bar', this.textColor = Colors.white, this.backgroundColor = Colors.blueAccent});

  @override
  State<ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBar> {

  //attribute to catch the current score
  int score = 0;

  //method to increase the score by 1
  void increaseScore() {
    setState(() {
      if(score == 10) {
        score = 10;
      }else{
        score++;
      }
    });
  }

  //method to decrease the score by 1
  void decreaseScore() {
    setState(() {
      if(score == 0){
        score = 0;
      }else{
        score--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //use progress bar to show the score
    return SizedBox(
      width: 400,
      height: 200,

      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //the title of the score bar
          Text(widget.title, style: TextStyle(fontSize: 20, color: widget.textColor),),
          const SizedBox(height: 20),
          //the increase and decrease button
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: increaseScore, icon: const Icon(Icons.add)),
              Text(score.toString(), style: const TextStyle(fontSize: 20)),
              IconButton(onPressed: decreaseScore, icon: const Icon(Icons.remove)),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: score / 10,
            backgroundColor: Colors.blueAccent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ],
      )
    );
  }
}



void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Score Bar'),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScoreBar(title: 'Math Score', textColor: Colors.black, backgroundColor: Colors.black),
              SizedBox(height: 20),
              ScoreBar(title: 'Chemistry Score', textColor: Colors.blue, backgroundColor: Colors.green),
              SizedBox(height: 20),
              ScoreBar(title: 'Physic Score', textColor: Colors.black, backgroundColor: Colors.red),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
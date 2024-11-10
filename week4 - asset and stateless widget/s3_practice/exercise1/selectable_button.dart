import 'package:flutter/material.dart';

class SelectableButton extends StatefulWidget {
  const SelectableButton({super.key});

  @override
  State<SelectableButton> createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {

  //attribute
  bool isSelected = false;
  Color color = Colors.grey;
  Widget textChild = const Center (child: Text("Not Selected", style: TextStyle(color: Colors.white)));

  void isTouching(){
    setState(() {

      isSelected = !isSelected;

      if(isSelected) {
        color = Colors.blue;
        textChild = const Center (child: Text("Selected", style: TextStyle(color: Colors.white)));
      }else{
        color = Colors.grey;
        textChild = const Center (child: Text("Not Selected", style: TextStyle(color: Colors.white)));
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 100,
        child: ElevatedButton(
          onPressed: isTouching,
          style: ElevatedButton.styleFrom(backgroundColor: color,),
          child: textChild,
        )
      )
    );
  }
}


void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom buttons"),
        ),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableButton(),
              SizedBox(height: 20),
              SelectableButton(),
              SizedBox(height: 20),
              SelectableButton(),
              SizedBox(height: 20),
              SelectableButton(),
            ],
          ),
        ),
      ),
    ));


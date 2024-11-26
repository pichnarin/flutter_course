import 'package:flutter/material.dart';

//app button that have label, icon and onTap function
//which will use to handle the quiz start, skip and submit button

class AppButton extends StatelessWidget {
  @immutable
  final String label;
  final IconData? icon;
  final void Function() onTap;


  const AppButton({super.key, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
      ),
    );
  }
}

// void main(){
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         body: SizedBox(
//           child: AppButton(
//             label: "Start Quiz",
//             icon: Icons.play_arrow,
//             onTap: () {
//               print("Quiz Started");
//             },
//           ),
//         ),
//       )
//     )
//   );
// }

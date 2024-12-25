import 'package:flutter/material.dart';
import 'package:music_app/MusicPlaylistOrganizer/UI/screen/welcome_screen.dart';
import 'package:music_app/MusicPlaylistOrganizer/service/snackbar_sms_service.dart';
import 'package:provider/provider.dart';

import 'data/provider/music_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackBarSmsService.messengerKey, //global key for snack bar
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}

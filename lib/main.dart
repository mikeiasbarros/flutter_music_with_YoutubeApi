import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumusic/consts.dart';
import 'package:yumusic/screens/OfflineMusic/music_user.dart';
import 'package:yumusic/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          //     colorScheme:  ColorScheme.fromSeed(seedColor: Colors.black),
          appBarTheme: AppBarTheme(
              // toolbarHeight: 70,
              iconTheme: IconThemeData(color: Colors.white, size: 30))),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

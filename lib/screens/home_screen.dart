import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumusic/consts.dart';
import 'package:yumusic/screens/BodyHome.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: const BodyHome(),
    );
  }
}

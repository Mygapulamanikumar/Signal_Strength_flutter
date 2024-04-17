import 'package:flutter/material.dart';
//import 'UIComponents/flashScreen.dart';
import 'UIComponents/MainCanvas.dart';

class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:MainCanvas()//flashScreen(),
    );
  }
}

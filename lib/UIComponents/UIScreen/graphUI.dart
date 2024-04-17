import 'package:flutter/material.dart';

class graphUI extends StatefulWidget {
  const graphUI({super.key});

  @override
  State<graphUI> createState() => _graphUIState();
}

class _graphUIState extends State<graphUI> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('graph Screen')),
    );
  }
}
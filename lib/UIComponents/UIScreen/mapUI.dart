import 'package:flutter/material.dart';

class mapUI extends StatefulWidget {
  const mapUI({super.key});

  @override
  State<mapUI> createState() => _mapUIState();
}

class _mapUIState extends State<mapUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('MAPS Screen')),
    );
  }
}
import 'package:flutter/material.dart';
import '../BottomNavBar.dart';

class logsContentUI extends StatefulWidget {
  const logsContentUI({super.key});

  @override
  State<logsContentUI> createState() => _logsContentUIState();
}

class _logsContentUIState extends State<logsContentUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('LOGS Screen')),
    );
  }
}
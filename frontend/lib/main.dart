import 'package:flutter/material.dart';
import 'package:smart_canteen/screens/student/home_screen.dart';


void main() {
  runApp(const SmartCanteen());
}

class SmartCanteen extends StatelessWidget {
  const SmartCanteen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Canteen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.green),
      ),
      home: HomeScreen(),
    );
  }
}
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const id = 'Home ';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

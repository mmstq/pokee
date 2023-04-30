import 'package:flutter/material.dart';

class FakeTabScreen extends StatelessWidget {
  final Color color;
  const FakeTabScreen({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
    );
  }
}

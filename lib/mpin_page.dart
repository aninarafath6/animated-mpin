import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mpin/mpin_animation.dart';

class MPinPage extends StatelessWidget {
  const MPinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.pink,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: MPinAnimation(),
            ),
          ),
        ],
      ),
    );
  }
}

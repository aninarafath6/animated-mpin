import 'package:flutter/material.dart';
import 'package:mpin/mpin_animation.dart';
import 'package:mpin/mpin_controller.dart';
import 'package:mpin/mpin_widget.dart';

class MPinPage extends StatelessWidget {
  MPinPage({Key? key}) : super(key: key);
  final MPinAnimationController controller = new MPinAnimationController();
  final MPinController mpinController = new MPinController();

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MpinWidget(pinLength: 5, controller: mpinController),
                  MaterialButton(
                    onPressed: () {
                      // controller.animate();
                      mpinController.addInput('1');
                    },
                    color: Colors.white,
                    child: Text('1'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

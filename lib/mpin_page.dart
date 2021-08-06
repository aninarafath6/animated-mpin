import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpin/mpin_animation.dart';
import 'package:mpin/mpin_controller.dart';
import 'package:mpin/mpin_widget.dart';
import 'package:vibration/vibration.dart';

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
                  MpinWidget(
                    pinLength: 5,
                    controller: mpinController,
                    onComplete: (mpin) async {
                      print('you enterd pin is $mpin');
                      if (mpin == '12345') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return new AlertDialog(
                                title: Text('success '),
                                content: Text('you are aproved'),
                              );
                            });
                      } else {
                        mpinController.notfiyWrongInput();
                        Vibration.vibrate();
                      }
                    },
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1.6,
                    children: List.generate(
                      9,
                      (index) => mpinInput(index + 1),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 1.6,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          // controller.animate();
                        },
                        textColor: Colors.white,
                        child: Icon(Icons.fingerprint),
                      ),
                      MaterialButton(
                        onPressed: () {
                          // controller.animate();
                          mpinController.addInput('0');
                        },
                        textColor: Colors.white,
                        child: Text('0'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          // controller.animate();
                          mpinController.delete();
                        },
                        textColor: Colors.white,
                        child: Icon(Icons.backspace),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  MaterialButton mpinInput(int input) {
    return MaterialButton(
      onPressed: () {
        // controller.animate();
        mpinController.addInput(input.toString());
      },
      textColor: Colors.white,
      child: Text(input.toString()),
    );
  }
}

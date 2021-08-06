import 'package:flutter/material.dart';
import 'package:mpin/mpin_animation.dart';
import 'package:mpin/mpin_controller.dart';

class MpinWidget extends StatefulWidget {
  final pinLength;
  final MPinController controller;
  MpinWidget({Key? key, required this.pinLength, required this.controller})
      : assert(pinLength <= 6 && pinLength > 0),
        super(key: key);

  @override
  _MpinWidgetState createState() => _MpinWidgetState(controller);
}

class _MpinWidgetState extends State<MpinWidget> {
  late List<MPinAnimationController> _animationControllers;
  String mpin = '';

  _MpinWidgetState(controller) {
    controller.addInput = addInput;
    controller.delete = deleteInput;
  }

  void addInput(String input) {
    mpin += input;

    if (mpin.length <= widget.pinLength) {
      _animationControllers[mpin.length - 1].animate(input);
    }
  }

  void deleteInput() {
    mpin = mpin.substring(0, mpin.length - 1);
    if (mpin.length >= 0) {
      _animationControllers[mpin.length].animate('');
    }
  }

  @override
  void initState() {
    _animationControllers =
        List.generate(widget.pinLength, (index) => MPinAnimationController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.pinLength,
        (index) => MPinAnimation(
          controller: _animationControllers[index],
        ),
      ),
    );
  }
}

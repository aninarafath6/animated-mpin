import 'package:flutter/material.dart';
import 'package:mpin/mpin_animation.dart';
import 'package:mpin/mpin_controller.dart';

class MpinWidget extends StatefulWidget {
  final pinLength;
  final MPinController controller;
  MpinWidget({Key? key, required this.pinLength, required this.controller})
      : super(key: key);

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
      _animationControllers[mpin.length].animate(input);
    }
  }

  void deleteInput() {
    _animationControllers[0].animate('');
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpin/mpin_animation.dart';
import 'package:mpin/mpin_controller.dart';

class MpinWidget extends StatefulWidget {
  final pinLength;
  final MPinController controller;
  final Function(String)? onComplete;

  MpinWidget(
      {Key? key,
      required this.pinLength,
      required this.controller,
      this.onComplete})
      : assert(pinLength <= 6 && pinLength > 0),
        super(key: key);

  @override
  _MpinWidgetState createState() => _MpinWidgetState(controller);
}

class _MpinWidgetState extends State<MpinWidget>
    with SingleTickerProviderStateMixin {
  late List<MPinAnimationController> _animationControllers;
  late AnimationController _wrongAnimationController;
  late Animation<double> _wiggleAnimation;

  String mpin = '';

  _MpinWidgetState(controller) {
    controller?.addInput = addInput;
    controller?.delete = deleteInput;
    controller?.notfiyWrongInput = notfiyWrongInput;
  }

  void addInput(String input) async {
    mpin += input;

    if (mpin.length < widget.pinLength) {
      _animationControllers[mpin.length - 1].animate(input);
    } else if (mpin.length == widget.pinLength) {
      _animationControllers[mpin.length - 1].animate(input);
      Future.delayed(Duration(milliseconds: 300));
      widget.onComplete?.call(mpin);
      mpin = '';
    }
  }

  void deleteInput() {
    if (mpin.isNotEmpty) {
      mpin = mpin.substring(0, mpin.length - 1);
      _animationControllers[mpin.length].animate('');
    }
  }

  void notfiyWrongInput() {
    _wrongAnimationController.forward();
    _animationControllers.forEach((controller) {
      controller.clear();
    });
  }

  @override
  void initState() {
    _animationControllers =
        List.generate(widget.pinLength, (index) => MPinAnimationController());

    _wrongAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _wrongAnimationController.reverse();
            }
          });
    _wiggleAnimation = Tween<double>(begin: 0.0, end: 25.0).animate(
        CurvedAnimation(
            parent: _wrongAnimationController, curve: Curves.elasticIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _wiggleAnimation.value,
        0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.pinLength,
          (index) => MPinAnimation(
            controller: _animationControllers[index],
          ),
        ),
      ),
    );
  }
}

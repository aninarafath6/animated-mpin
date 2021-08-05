import 'package:flutter/material.dart';

class MPinAnimation extends StatefulWidget {
  MPinAnimation({Key? key, this.controller}) : super(key: key);
  final MPinAnimationController? controller;

  @override
  _MPinAnimationState createState() => _MPinAnimationState(controller);
}

class _MPinAnimationState extends State<MPinAnimation>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  String pin = '';

  void animate(String input) {
    _controller.forward();
    setState(() {
      pin = input;
    });
  }

  _MPinAnimationState(controller) {
    controller?.animate = animate;
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      animationBehavior: AnimationBehavior.preserve,
    );
    _controller.addListener(
      () {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        }
        setState(() {});
      },
    );
    _sizeAnimation = Tween<double>(
      begin: 25,
      end: 73,
    ).animate(_controller);
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      child: Container(
        height: _sizeAnimation.value,
        width: _sizeAnimation.value,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            _sizeAnimation.value / 2,
          ),
        ),
        child: Center(
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _sizeAnimation.value / 44,
              child: Text(
                pin,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MPinAnimationController {
  late void Function(String) animate;
}

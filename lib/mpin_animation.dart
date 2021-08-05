import 'package:flutter/material.dart';

class MPinAnimation extends StatefulWidget {
  const MPinAnimation({Key? key}) : super(key: key);

  @override
  _MPinAnimationState createState() => _MPinAnimationState();
}

class _MPinAnimationState extends State<MPinAnimation>
    with SingleTickerProviderStateMixin {
  // ignore: unused_field
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
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
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              '1',
            ),
          ),
        ),
      ),
    );
  }
}

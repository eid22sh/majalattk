import 'package:flutter/material.dart';

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  int index = 1;
  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    animation = Tween<double>(begin: 1, end: 1.2).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.isCompleted) {
            index = index++ % 3 + 1;
            if (index % 3 == 0) {
              controller.reverse();
            } else {
              controller.reset();
              controller.forward();
            }
          } else if (animation.isDismissed && index % 3 == 0) {
            index = index++ % 3 + 1;
            controller.forward();
          }
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Image.asset(
        "assets/images/welcome$index.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

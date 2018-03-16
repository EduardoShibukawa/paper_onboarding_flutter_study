import 'dart:math';

import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {

  final double revealPercent;
  final Widget child;

  PageReveal({this.revealPercent, this.child});  

  @override
  Widget build(BuildContext context) {
    return new ClipOval(
      clipper: new CircleRevealClipper(this.revealPercent),
      child: this.child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {  

  final double revealPercent;  

  CircleRevealClipper(this.revealPercent);  

  @override
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width / 2, size.height * 0.9);

    //Calculate distance from epicenter to the top left corner to make sure we fill the screen
    double theta = atan(epicenter.dy / epicenter.dy);
    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diamater = 2 * radius;

    return new Rect.fromLTWH(
      epicenter.dx - radius, 
      epicenter.dy - radius, 
      diamater, 
      diamater
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

  
}
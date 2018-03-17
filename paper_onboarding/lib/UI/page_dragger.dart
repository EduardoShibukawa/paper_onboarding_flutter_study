import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paper_onboarding/UI/page_indicator.dart';

class PageDragger extends StatefulWidget {

  final bool canDragLeftToRight;
  final bool canDragRightToLeft;
  final StreamController<SlideUpdate> slideUpdateStream;

  PageDragger({
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream
  });

  @override
  _PageDraggerState createState() => new _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details) {
    this.dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    final newPosition = details.globalPosition;
    final dx = this.dragStart.dx - newPosition.dx;

    if (dx > 0.0 && widget.canDragRightToLeft) {
      slideDirection = SlideDirection.rightToLeft;
    } else if (dx < 0.0 && widget.canDragLeftToRight) {
      slideDirection = SlideDirection.leftToRight;
    } else {
      slideDirection = SlideDirection.none;
    }

    if (slideDirection != SlideDirection.none)
      slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
    else slidePercent = 0.0;

    widget.slideUpdateStream.add(
        new SlideUpdate(
          UpdateType.dragging, 
          slideDirection, 
          slidePercent
        )
    );

    print("Dragging $slideDirection at $slidePercent%");
  }

  onDragEnd(DragEndDetails details) {
    dragStart = null;
    widget.slideUpdateStream.add(
      new SlideUpdate(
        UpdateType.doneDragging,
        SlideDirection.none,
        0.0
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

class AnimationPageDragger {

  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final transitionGoal;

  AnimationController completeAnimationController;

  AnimationPageDragger({
      this.slideDirection, 
      this.transitionGoal,
      slidePercent,
      StreamController<SlideUpdate> slideUpdateStream,
      TickerProvider vsync,      
  }) {
    var endSlidePercent;
    var duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaning = 1.0 - slidePercent;
      duration  = new Duration(
        milliseconds: (slideRemaning / PERCENT_PER_MILLISECOND).round()
      );
    } else {
      endSlidePercent = 0.0;
      duration = new Duration(
        microseconds: (slidePercent / PERCENT_PER_MILLISECOND).round()
      );
    } 

    completeAnimationController = new AnimationController(
      duration: duration,
      vsync: vsync
    )
    ..addListener(
      () {
        slideUpdateStream.add(
          new SlideUpdate(
            UpdateType.dragging,
            slideDirection, 
            slidePercent
          )
        );
      }
      )
    ..addStatusListener(
      (AnimationStatus status) {

      }
    );
  }  
}

enum TransitionGoal {
  open,
  close,
}

enum UpdateType{
  dragging,
  doneDragging
}

class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;

  SlideUpdate(
    this.updateType,
    this.direction, 
    this.slidePercent
  );  
}
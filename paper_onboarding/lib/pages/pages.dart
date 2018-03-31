import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paper_onboarding/UI/page_dragger.dart';
import 'package:paper_onboarding/UI/page_indicator.dart';
import 'package:paper_onboarding/UI/page_reveal.dart';
import 'package:paper_onboarding/pages/page.dart';

class Pages extends StatefulWidget {

  final PagesViewModel viewModel;

  Pages({this.viewModel});

  @override
  _PagesState createState() => new _PagesState();  
}

class _PagesState extends State<Pages> with TickerProviderStateMixin {
    
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  int activateIndex = 0;
  int nextPageIndex = 0;  

  @override
  void dispose(){
    slideUpdateStream.close();
    super.dispose();
  }

  _PagesState(){
    this.slideUpdateStream = new StreamController<SlideUpdate>();
    this.slideUpdateStream.stream.listen((SlideUpdate event) {
        setState(() {                                        
          if (this._isDragging(event)) {
            this.updateDragging(event);
          } else if (this._hasDoneDragging(event)) {
            this._updateDoneDragging();
          } else if (this._isAnimatting(event)) {            
            this._updateAnimatting(event);
          } else if (this._hasDoneAnimatting(event)) {            
            this._updateDoneAnimatting();
          }          
        });
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Page(widget.viewModel.pages[activateIndex], 1.0),
        new PageReveal(
          child: new Page(
              widget.viewModel.pages[nextPageIndex], 
              this.slidePercent
          ),
          revealPercent: this.slidePercent,
        ),
        new PageIndicator(
          viewModel: new PageIndicatorViewModel(
            widget.viewModel.pages, 
            this.activateIndex, 
            this.slideDirection,
            this.slidePercent
          ),
        ),
        new PageDragger(
          canDragLeftToRight: activateIndex > 0,
          canDragRightToLeft: activateIndex < widget.viewModel.pages.length - 1,
          slideUpdateStream: this.slideUpdateStream,
        )
      ],
    ));
  }

  bool _isDragging(SlideUpdate event) {
    return event.updateType == UpdateType.dragging;
  }

  bool _hasDoneDragging(SlideUpdate event){
    return event.updateType == UpdateType.doneDragging;
  }

  bool _isAnimatting(SlideUpdate event) {
    return event.updateType == UpdateType.animating;
  }

  bool _hasDoneAnimatting(SlideUpdate event) {
    return event.updateType == UpdateType.doneAnimating;
  }

  updateDragging(SlideUpdate event){    
    this.slidePercent = event.slidePercent;            
    this.slideDirection = event.direction;
    
    if (slideDirection == SlideDirection.leftToRight) {
      this.nextPageIndex = this.activateIndex -1;
    } else if (slideDirection == SlideDirection.rightToLeft) {
      this.nextPageIndex = this.activateIndex + 1;
    } else {
      this.nextPageIndex = this.activateIndex;
    }                        
  }

  _updateDoneDragging() {
    if (this.slidePercent > 0.5) {
      this.animatedPageDragger = new AnimatedPageDragger(
        slideDirection: this.slideDirection,
        transitionGoal: TransitionGoal.open,
        slidePercent: this.slidePercent,
        slideUpdateStream: this.slideUpdateStream,
        vsync: this,
      );
    } else {
      this.animatedPageDragger = new AnimatedPageDragger(
        slideDirection: this.slideDirection,
        transitionGoal: TransitionGoal.close,
        slidePercent: this.slidePercent,
        slideUpdateStream: this.slideUpdateStream,
        vsync: this,
      );

      this.nextPageIndex = this.activateIndex;
    }

    this.animatedPageDragger.run();                              
  }

  _updateAnimatting(SlideUpdate event) {
    this.slideDirection = event.direction;
    this.slidePercent = event.slidePercent;
  }

  _updateDoneAnimatting() {
    this.activateIndex = this.nextPageIndex;            
    this.slideDirection = SlideDirection.none;
    this.slidePercent = 0.0;                        
    this.animatedPageDragger.dispose();    
  }
}

class PagesViewModel {
  final List<PageViewModel> pages;

  PagesViewModel(this.pages);
}
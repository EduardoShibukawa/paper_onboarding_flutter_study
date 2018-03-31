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
          if (event.updateType == UpdateType.dragging) {
            slideDirection = event.direction;
            slidePercent = event.slidePercent;            

            if (slideDirection == SlideDirection.leftToRight) {
              nextPageIndex = activateIndex -1;
            } else if (slideDirection == SlideDirection.rightToLeft) {
              nextPageIndex = activateIndex + 1;
            } else {
              nextPageIndex = activateIndex;
            }                        
          } else if (event.updateType == UpdateType.doneDragging) {
            if (this.slidePercent > 0.5) {
              animatedPageDragger = new AnimatedPageDragger(
                slideDirection: this.slideDirection,
                transitionGoal: TransitionGoal.open,
                slidePercent: this.slidePercent,
                slideUpdateStream: this.slideUpdateStream,
                vsync: this,
              );
            } else {
              animatedPageDragger = new AnimatedPageDragger(
                slideDirection: this.slideDirection,
                transitionGoal: TransitionGoal.close,
                slidePercent: this.slidePercent,
                slideUpdateStream: this.slideUpdateStream,
                vsync: this,
              );

              nextPageIndex = activateIndex;
            }
            animatedPageDragger.run();                          
          } else if (event.updateType == UpdateType.animating) {
            slideDirection = event.direction;
            slidePercent = event.slidePercent;            
          } else if (event.updateType == UpdateType.doneAnimating) {            
            activateIndex = nextPageIndex;            
            slideDirection = SlideDirection.none;
            slidePercent = 0.0;                        
            animatedPageDragger.dispose();
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
}

class PagesViewModel {
  final List<PageViewModel> pages;

  PagesViewModel(this.pages);
}
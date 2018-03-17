import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paper_onboarding/UI/page_dragger.dart';
import 'package:paper_onboarding/UI/page_indicator.dart';
import 'package:paper_onboarding/UI/page_reveal.dart';
import 'package:paper_onboarding/pages/page.dart';
import 'package:paper_onboarding/domain/pages.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<SlideUpdate> slideUpdateStream;

  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  int activateIndex = 0;
  int nextPageIndex = 1;  

  _MyHomePageState(){
    this.slideUpdateStream = new StreamController<SlideUpdate>();
    this.slideUpdateStream.stream.listen(
      (SlideUpdate event) {
        setState(() {                    
          if (event.updateType == UpdateType.dragging) {
            if (slideDirection == SlideDirection.leftToRight) {
              nextPageIndex = activateIndex -1;
            }
            else if (slideDirection == SlideDirection.rightToLeft) {
              nextPageIndex = activateIndex + 1;
            } else {
              nextPageIndex = activateIndex;
            }                        
          }
          else if (event.updateType == UpdateType.doneDragging) {
            if (this.slidePercent > 0.5) {
              activateIndex = this.slideDirection == SlideDirection.leftToRight
                ? activateIndex - 1
                : activateIndex + 1;
            }
          }

          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Page(pages[activateIndex], 1.0),
        new PageReveal(
          child: new Page(
              pages[nextPageIndex], 
              this.slidePercent
          ),
          revealPercent: this.slidePercent,
        ),
        new PageIndicator(
          viewModel: new PageIndicatorViewModel(
            pages, 
            this.activateIndex, 
            this.slideDirection,
            this.slidePercent
          ),
        ),
        new PageDragger(
          canDragLeftToRight: activateIndex > 0,
          canDragRightToLeft: activateIndex < pages.length - 1,
          slideUpdateStream: this.slideUpdateStream,
        )
      ],
    ));
  }
}

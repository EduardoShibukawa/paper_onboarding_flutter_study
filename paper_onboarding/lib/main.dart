import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Page(pages[2], 1.0),
        new PageReveal(
          child: new Page(pages[1], 1.0),
          revealPercent: 1.0,
        ),
        new PageIndicator(
          viewModel: new PageIndicatorViewModel(
            pages, 
            1, 
            SlideDirection.leftToRight,
            1.0
          ),
        )                
      ],
    ));
  }
}

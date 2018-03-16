import 'package:flutter/material.dart';
import 'package:paper_onboarding/UI/page_bubble.dart';
import 'package:paper_onboarding/pages/page.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;

  PageIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; i ++) {
      final page = viewModel.pages[i];
      bubbles.add(
        new PageBubble(
          viewModel: new PageBubbleViewModel(
            page.iconAssetIcon,
            page.color,
            i > viewModel.activateIndex,
            i == viewModel.activateIndex ? 1.0 : 0.0
          ),
        )
      );
    }

    return new Column(
      children: <Widget>[
        new Expanded(child: new Container()),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bubbles,          
        )
      ],
    );
  }
}

enum SlideDirection { 
  none, 
  leftToRight, 
  rightToLeft 
}

class PageIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activateIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PageIndicatorViewModel(
      this.pages, this.activateIndex, this.slideDirection, this.slidePercent);
}

import 'dart:ui';

import 'package:flutter/material.dart';

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Container(
          width: lerpDouble(25.0, 45.0, viewModel.activatePercent),
          height: lerpDouble(25.0, 45.0, viewModel.activatePercent),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,             
            color: viewModel.isHollow
              ? const Color(0X88FFFFFF).withAlpha((0X88 * viewModel.activatePercent).round())
              : const Color(0X88FFFFFF),
            border: new Border.all(
              width: 3.0, 
              color: viewModel.isHollow
              ? const Color(0X88FFFFFF).withAlpha((0X88 * (1.0 - viewModel.activatePercent)).round())
              : Colors.transparent,
            ),
          ),
          child: new Opacity(
            opacity: viewModel.activatePercent,
            child: new Image.network(
                viewModel.iconAssetPath,
                color: viewModel.color,
              )
          )
      ),
    );
  }
}

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activatePercent;

  PageBubbleViewModel(
      this.iconAssetPath, this.color, this.isHollow, this.activatePercent);
}

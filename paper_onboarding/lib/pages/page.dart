import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisibible;

  Page(this.viewModel, this.percentVisibible);

  @override
  Widget build(BuildContext build) {
    return new Container(
        color: viewModel.color,
        width: double.INFINITY,
        child: new Opacity(
          opacity: this.percentVisibible,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: new Image.network(viewModel.heroAssetPath,
                    width: 200.0, height: 200.0),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: new Text(viewModel.title,
                    style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 34.0)),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: new Text(viewModel.body,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    )),
              )
            ],
          ),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetIcon;

  PageViewModel(this.color, this.heroAssetPath, this.title, this.body,
      this.iconAssetIcon);
}

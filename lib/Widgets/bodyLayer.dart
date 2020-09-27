import 'package:flutter/material.dart';
import 'package:synword/Widgets/layerTitle.dart';

class BodyLayer extends StatelessWidget {
  final Widget _widget;
  final LayerTitle _title;
  final bool isTitileVisible;

  BodyLayer(
      this._widget,
      this._title,
      this.isTitileVisible
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Visibility(
            child: _title,
            visible: isTitileVisible,
          ),
          Container(
            child: _widget,
          )
        ],
      ),
    );
  }
}

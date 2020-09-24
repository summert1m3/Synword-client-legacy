import 'package:flutter/material.dart';
import 'package:synword/Widgets/layerTitle.dart';

class BodyLayer extends StatelessWidget {
  final Widget _widget;
  final LayerTitle _title;

  BodyLayer(
      this._widget,
      this._title,
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
          _title,
          Container(
            child: _widget,
          )
        ],
      ),
    );
  }
}

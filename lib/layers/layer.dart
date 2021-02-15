import 'package:flutter/material.dart';

abstract class Layer {
  Widget _widget;

  Widget getWidget() {
    return _widget;
  }

  void setWidget(Widget value) {
    _widget = value;
  }
  
  void build();
}

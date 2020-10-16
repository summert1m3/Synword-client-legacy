import 'package:flutter/material.dart';

abstract class Layer {
  Widget widget;

  Widget getWidget() {
    return widget;
  }

  void build();
}

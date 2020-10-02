import 'package:flutter/material.dart';
import 'layer.dart';
import 'types.dart';

abstract class MovingLayer extends Layer {
  void setTitleColor(Color value);
  void setTitleVisible(bool value);
  void setCloseButtonVisible(bool value);
  void setOnPanUpdateCallback(OnPanUpdateCallback value);
  void setOnPanEndCallback(OnPanEndCallback value);
  void setCloseButtonCallback(CloseButtonCallback value);
  void setOffset(Offset offset);
  Color getDefaultColor();
  Offset getOffset();
  Widget getWidget();
}

import 'package:flutter/material.dart';
import 'layer.dart';
import 'types.dart';

abstract class MovingLayer extends Layer {
  Widget loadingWidget;
  Offset offset;
  Color titleColor;
  OnPanUpdateCallback onPanUpdateCallback;
  OnPanEndCallback onPanEndCallback;
  CloseButtonCallback closeButtonCallback;
  bool isLoadingWidgetEnabled;
  bool isTitleVisible;
  bool isCloseButtonVisible;

  MovingLayer(this.loadingWidget, this.offset, this.titleColor, this.onPanUpdateCallback, this.onPanEndCallback, this.closeButtonCallback, this.isLoadingWidgetEnabled, this.isTitleVisible, this.isCloseButtonVisible);

  void setWaitWidget(Widget value) {
    loadingWidget = value;
    build();
  }

  void setTitleColor(Color value) {
    titleColor = value;
    build();
  }

  void setLoadingWidgetEnabled(bool value) {
    isLoadingWidgetEnabled = value;
    build();
  }

  void setTitleVisible(bool value) {
    isTitleVisible = value;
    build();
  }

  void setCloseButtonVisible(bool value) {
    isCloseButtonVisible = value;
    build();
  }

  void setOnPanUpdateCallback(OnPanUpdateCallback value) {
    onPanUpdateCallback = value;
    build();
  }

  void setOnPanEndCallback(OnPanEndCallback value) {
    onPanEndCallback = value;
    build();
  }

  void setCloseButtonCallback(CloseButtonCallback value) {
    closeButtonCallback = value;
    build();
  }

  void setOffset(Offset value) {
    offset = value;
    build();
  }

  Offset getOffset() {
    return offset;
  }

  Color getDefaultColor();
}

import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueTextWidget.dart';
import 'package:synword/widgets/uniqueText.dart';
import 'package:synword/widgets/loadingScreen.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class UniqueTextLayer extends MovingLayer {
  String _text;

  UniqueTextLayer.zero() : super(LoadingScreen(), Offset.zero, layersSetting.uniqueTextTitleColor, null, null, null, false, true, true, true) {
    _text = "";
    build();
  }

  UniqueTextLayer.common(Offset offset, this._text, bool isLoadingWidgetEnabled) : super(null, offset, layersSetting.uniqueTextTitleColor, null, null, null, isLoadingWidgetEnabled, true, true, true) {
    build();
  }

  UniqueTextLayer(Offset offset, Color titleColor, this._text, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(null, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueTextWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : UniqueText(_text, getOffset()),
        getOffset(),
        getTitleColor(),
        isTitleVisible(),
        isCloseButtonVisible(),
        getOnPanUpdateCallback(),
        getOnPanEndCallback(),
        getCloseButtonCallback()
    ));
  }

  Color getDefaultColor() {
    return layersSetting.uniqueTextTitleColor;
  }

  void setText(String value) {
    _text = value;
    build();
  }
}

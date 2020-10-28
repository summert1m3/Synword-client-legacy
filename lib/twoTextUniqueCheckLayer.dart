import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/twoTextUniqueCheck.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class TwoTextUniqueCheckLayer extends MovingLayer {
  double _originalProgress;
  double _uniqueProgress;

  TwoTextUniqueCheckLayer.zero() : super(null, Offset.zero, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    _originalProgress = 0;
    _uniqueProgress = 0;
    build();
  }

  TwoTextUniqueCheckLayer.common(Offset offset, this._originalProgress, this._uniqueProgress) : super(null, offset, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true)  {
    build();
  }

  TwoTextUniqueCheckLayer(Offset offset, this._originalProgress, this._uniqueProgress, Color titleColor, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(null, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueCheckWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : TwoTextUniqueCheckWidget(getOffset(), _originalProgress, _uniqueProgress),
        getOffset(),
        getTitleColor(),
        isTitleVisible(),
        isCloseButtonVisible(),
        getOnPanUpdateCallback(),
        getOnPanEndCallback(),
        getCloseButtonCallback()
    ));
  }

  void setOriginalProgress(double value) {
    _originalProgress = value;
    build();
  }

  void setUniqueProgress(double value) {
    _uniqueProgress = value;
    build();
  }

  Color getDefaultColor() {
    return layersSetting.uniqueCheckTitleColor;
  }
}

import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/twoTextUniqueCheck.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class TwoTextUniqueCheckLayer extends MovingLayer {
  double _originalProgress;
  double _uniqueProgress;

  TwoTextUniqueCheckLayer.zero() : super(null, Offset.zero, UniqueCheckTitleColor, null, null, null, false, true, true) {
    _originalProgress = 0;
    _uniqueProgress = 0;
    build();
  }

  TwoTextUniqueCheckLayer.common(Offset offset, this._originalProgress, this._uniqueProgress) : super(null, offset, UniqueCheckTitleColor, null, null, null, false, true, true)  {
    build();
  }

  TwoTextUniqueCheckLayer(Offset offset, this._originalProgress, this._uniqueProgress, Color titleColor, bool isLoadingWidgetEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(null, offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    widget = UniqueCheckWidget(
        isLoadingWidgetEnabled ? loadingWidget : TwoTextUniqueCheckWidget(offset, _originalProgress, _uniqueProgress),
        offset,
        titleColor,
        isTitleVisible,
        isCloseButtonVisible,
        onPanUpdateCallback,
        onPanEndCallback,
        closeButtonCallback
    );
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
    return UniqueCheckTitleColor;
  }
}

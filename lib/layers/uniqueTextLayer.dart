import 'package:flutter/material.dart';
import 'package:synword/layers/layersSetting.dart';
import 'package:synword/model/json/uniqueUpData.dart';
import 'package:synword/widgets/layers/uniqueTextWidget.dart';
import 'package:synword/widgets/uniqueText.dart';
import 'package:synword/widgets/loadingScreen.dart';
import 'movingLayer.dart';
import 'package:synword/types.dart';

class UniqueTextLayer extends MovingLayer {
  UniqueUpData? _uniqueUpData;

  UniqueTextLayer.zero() : super(LoadingScreen(), Offset.zero, layersSetting.uniqueTextTitleColor, null, null, null, false, true, true, true) {
    _uniqueUpData = null;
    build();
  }

  UniqueTextLayer.common(Offset offset, this._uniqueUpData, bool isLoadingWidgetEnabled) : super(LoadingScreen(), offset, layersSetting.uniqueTextTitleColor, null, null, null, isLoadingWidgetEnabled, true, true, true) {
    build();
  }

  UniqueTextLayer(Offset offset, Color titleColor, this._uniqueUpData, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(LoadingScreen(), offset, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueTextWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : UniqueText(_uniqueUpData, getOffset()),
        _uniqueUpData != null ? _uniqueUpData!.text : '',
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

  void setUniqueUpData(UniqueUpData value) {
    _uniqueUpData = value;
    build();
  }
}

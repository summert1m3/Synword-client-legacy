import 'package:flutter/material.dart';
import 'package:synword/uniqueCheckData.dart';
import 'package:synword/uniqueCheckLayer.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/twoTextUniqueCheck.dart';
import 'package:synword/widgets/loadingScreen.dart';
import 'layersSetting.dart';
import 'types.dart';

class TwoTextUniqueCheckLayer extends UniqueCheckLayer {
  TwoTextUniqueCheckLayer.zero() : super(LoadingScreen(), Offset.zero, null, null, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true) {
    build();
  }

  TwoTextUniqueCheckLayer.common(Offset offset, UniqueCheckData originalTextCheckData, UniqueCheckData uniqueTextCheckData) : super(LoadingScreen(), offset, originalTextCheckData, uniqueTextCheckData, layersSetting.uniqueCheckTitleColor, null, null, null, false, true, true, true, )  {
    build();
  }

  TwoTextUniqueCheckLayer(Offset offset, UniqueCheckData originalTextCheckData, UniqueCheckData uniqueTextCheckData, Color titleColor, bool isLoadingWidgetEnabled, bool isMovingEnabled, bool isTitleVisible, bool isCloseButtonVisible, OnPanUpdateCallback onPanUpdateCallback, OnPanEndCallback onPanEndCallback, CloseButtonCallback closeButtonCallback)
      : super(LoadingScreen(), offset, originalTextCheckData, uniqueTextCheckData, titleColor, onPanUpdateCallback, onPanEndCallback, closeButtonCallback, isLoadingWidgetEnabled, isMovingEnabled, isTitleVisible, isCloseButtonVisible) {
    build();
  }

  void build() {
    setWidget(UniqueCheckWidget(
        isLoadingScreenEnabled() ? getLoadingScreen() : TwoTextUniqueCheckWidget(getOriginalTextCheckData(), getUniqueTextCheckData(), getOffset()),
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
    return layersSetting.uniqueCheckTitleColor;
  }
}

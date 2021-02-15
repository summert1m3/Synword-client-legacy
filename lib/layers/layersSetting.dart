import 'package:flutter/material.dart';

LayersSetting layersSetting;

class LayersSetting {
  static LayersSetting _layerSetting;
  double titleHeight;
  double titleContactHeight;
  Color originalTextTitleColor;
  Color uniqueTextTitleColor;
  Color uniqueCheckTitleColor;
  double waveBarWidth;
  double waveBarHeight;

  LayersSetting._(
    this.titleHeight,
    this.titleContactHeight,
    this.originalTextTitleColor,
    this.uniqueTextTitleColor,
    this.uniqueCheckTitleColor,
    this.waveBarWidth,
    this.waveBarHeight
  );

  static LayersSetting initialize(double titleHeight, double titleContactHeight, Color originalTextTitleColor, Color uniqueTextTitleColor, Color uniqueCheckTitleColor, double waveBarWidth, double waveBarHeight) {
    if (_layerSetting == null) {
      _layerSetting = LayersSetting._(titleHeight, titleContactHeight, originalTextTitleColor, uniqueTextTitleColor, uniqueCheckTitleColor, waveBarWidth, waveBarHeight);
    }

    return _layerSetting;
  }
}
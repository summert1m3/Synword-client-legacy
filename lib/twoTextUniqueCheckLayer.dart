import 'package:flutter/material.dart';
import 'package:synword/widgets/layers/uniqueCheckWidget.dart';
import 'package:synword/widgets/twoTextUniqueCheck.dart';
import 'movingLayer.dart';
import 'layersSetting.dart';
import 'types.dart';

class TwoTextUniqueCheckLayer extends MovingLayer {
  Offset _offset;
  double _originalProgress;
  double _uniqueProgress;
  Color _titleColor;
  OnPanUpdateCallback _onPanUpdateCallback;
  OnPanEndCallback _onPanEndCallback;
  CloseButtonCallback _closeButtonCallback;
  bool _isTitleVisible;
  bool _isCloseButtonVisible;
  Widget _widget;

  TwoTextUniqueCheckLayer.zero() {
    _offset = Offset.zero;
    _originalProgress = 0;
    _uniqueProgress = 0;
    _titleColor = UniqueCheckTitleColor;
    _onPanUpdateCallback = null;
    _onPanEndCallback = null;
    _closeButtonCallback = null;
    _isTitleVisible = true;
    _isCloseButtonVisible = true;
    build();
  }

  TwoTextUniqueCheckLayer.common(this._offset, this._originalProgress, this._uniqueProgress) {
    _titleColor = UniqueCheckTitleColor;
    _isTitleVisible = true;
    _isCloseButtonVisible = true;
    _onPanUpdateCallback = null;
    _onPanEndCallback = null;
    _closeButtonCallback = null;
    build();
  }

  TwoTextUniqueCheckLayer(this._offset, this._originalProgress, this._uniqueProgress, this._titleColor, this._isTitleVisible, this._isCloseButtonVisible, this._onPanUpdateCallback, this._onPanEndCallback, this._closeButtonCallback) {
    build();
  }

  void build() {
    _widget = UniqueCheckWidget(
        TwoTextUniqueCheckWidget(_offset, _originalProgress, _uniqueProgress),
        _offset,
        _titleColor,
        _isTitleVisible,
        _isCloseButtonVisible,
        _onPanUpdateCallback,
        _onPanEndCallback,
        _closeButtonCallback
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

  void setTitleColor(Color value) {
    _titleColor = value;
    build();
  }

  void setTitleVisible(bool value) {
    _isTitleVisible = value;
    build();
  }

  void setCloseButtonVisible(bool value) {
    _isCloseButtonVisible = value;
    build();
  }

  void setOnPanUpdateCallback(OnPanUpdateCallback value) {
    _onPanUpdateCallback = value;
    build();
  }

  void setOnPanEndCallback(OnPanEndCallback value) {
    _onPanEndCallback = value;
    build();
  }

  void setCloseButtonCallback(CloseButtonCallback value) {
    _closeButtonCallback = value;
    build();
  }

  void setOffset(Offset value) {
    _offset = value;
    build();
  }

  Color getDefaultColor() {
    return UniqueCheckTitleColor;
  }

  Offset getOffset() {
    return _offset;
  }

  Widget getWidget() {
    return _widget;
  }
}

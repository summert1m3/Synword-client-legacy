import 'package:flutter/material.dart';
import 'package:synword/layers/layer.dart';
import 'package:synword/types.dart';

abstract class MovingLayer extends Layer {
  Widget _loadingScreen;
  Offset _offset;
  Color _titleColor;
  OnPanUpdateCallback? _onPanUpdateCallback;
  OnPanEndCallback? _onPanEndCallback;
  CloseButtonCallback? _closeButtonCallback;
  bool _isLoadingScreenEnabled;
  bool _isMovingEnabled;
  bool _isTitleVisible;
  bool _isCloseButtonVisible;

  MovingLayer(this._loadingScreen, this._offset, this._titleColor, this._onPanUpdateCallback, this._onPanEndCallback, this._closeButtonCallback, this._isLoadingScreenEnabled, this._isMovingEnabled, this._isTitleVisible, this._isCloseButtonVisible);

  void setLoadingScreen(Widget value) {
    _loadingScreen = value;
    build();
  }

  Widget getLoadingScreen() {
    return _loadingScreen;
  }

  void setTitleColor(Color value) {
    _titleColor = value;
    build();
  }

  Color getTitleColor() {
    return _titleColor;
  }

  void setLoadingScreenEnabled(bool value) {
    _isLoadingScreenEnabled = value;
    build();
  }

  bool isLoadingScreenEnabled() {
    return _isLoadingScreenEnabled;
  }

  void setMovingEnabled(bool value) {
    _isMovingEnabled = value;
    build();
  }

  bool isMovingEnabled() {
    return _isMovingEnabled;
  }

  void setTitleVisible(bool value) {
    _isTitleVisible = value;
    build();
  }

  bool isTitleVisible() {
    return _isTitleVisible;
  }

  void setCloseButtonVisible(bool value) {
    _isCloseButtonVisible = value;
    build();
  }

  bool isCloseButtonVisible() {
    return _isCloseButtonVisible;
  }

  void setOnPanUpdateCallback(OnPanUpdateCallback value) {
    _onPanUpdateCallback = value;
    build();
  }

  OnPanUpdateCallback? getOnPanUpdateCallback() {
    return _onPanUpdateCallback;
  }

  void setOnPanEndCallback(OnPanEndCallback value) {
    _onPanEndCallback = value;
    build();
  }

  OnPanEndCallback? getOnPanEndCallback() {
    return _onPanEndCallback;
  }

  void setCloseButtonCallback(CloseButtonCallback value) {
    _closeButtonCallback = value;
    build();
  }

  CloseButtonCallback? getCloseButtonCallback() {
    return _closeButtonCallback;
  }

  void setOffset(Offset value) {
    _offset = value;
    build();
  }

  Offset getOffset() {
    return _offset;
  }

  Color getDefaultColor();
}

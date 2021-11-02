import 'package:synword/layers/layer.dart';
import 'package:synword/widgets/layers/buttonBarWidget.dart';
import 'package:synword/types.dart';

class ButtonBarLayer extends Layer {
  bool _isFirstButtonVisible = true;
  bool _isSecondButtonVisible = true;
  FloatingActionButtonCallback? _firstButtonCallback;
  FloatingActionButtonCallback? _secondButtonCallback;

  ButtonBarLayer.zero() {
    _firstButtonCallback = null;
    _secondButtonCallback = null;
    build();
  }

  ButtonBarLayer(this._isFirstButtonVisible, this._isSecondButtonVisible, this._firstButtonCallback, this._secondButtonCallback) {
    build();
  }

  void build() {
    setWidget(ButtonBarWidget(
        _isFirstButtonVisible,
        _isSecondButtonVisible,
        _firstButtonCallback,
        _secondButtonCallback
    ));
  }

  void setFirstButtonVisible(bool value) {
    _isFirstButtonVisible = value;
    build();
  }

  void setSecondButtonVisible(bool value) {
    _isSecondButtonVisible = value;
    build();
  }

  void setFirstButtonCallback(FloatingActionButtonCallback value) {
    _firstButtonCallback = value;
    build();
  }

  void setSecondButtonCallback(FloatingActionButtonCallback value) {
    _secondButtonCallback = value;
    build();
  }

  bool getFirstButtonVisible() {
    return _isFirstButtonVisible;
  }

  bool getSecondButtonVisible() {
    return _isSecondButtonVisible;
  }
}

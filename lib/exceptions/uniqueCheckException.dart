import 'package:synword/layers/uniqueCheckLayer.dart';

class UniqueCheckException implements Exception {
  String message;
  UniqueCheckLayer _layer;
  UniqueCheckException(this.message, this._layer);

  UniqueCheckLayer getLayer() {
    return _layer;
  }

  String getErrorMessage() {
    return message;
  }
}
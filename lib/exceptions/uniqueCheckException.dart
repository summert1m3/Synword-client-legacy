import 'package:synword/layers/uniqueCheckLayer.dart';

class UniqueCheckException implements Exception {
  UniqueCheckLayer _layer;

  UniqueCheckException(this._layer);

  UniqueCheckLayer getLayer() {
    return _layer;
  }
}
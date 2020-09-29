class LayerInfo {
  String _name;
  int _positionInStack;

  LayerInfo(this._name, this._positionInStack);

  String getName() {
    return _name;
  }

  void setPosition(int newPosition) {
    _positionInStack = newPosition;
  }

  int getPositionInStack() {
    return _positionInStack;
  }
}

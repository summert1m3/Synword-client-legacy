class LayerInfo {
  String _name;
  int _position;

  LayerInfo(this._name, this._position);

  String getName() {
    return _name;
  }

  void setPosition(int newPosition) {
    _position = newPosition;
  }

  int getPosition() {
    return _position;
  }
}

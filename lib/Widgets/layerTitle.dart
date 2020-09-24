import 'package:flutter/material.dart';

typedef GestureDetectorCallback = void Function(Offset offset);
typedef CloseButtonCallback = void Function();

class LayerTitle extends StatelessWidget {
  final Text _title;
  final Color _titleColor;
  final bool _isTitleEnable;
  final bool _isCloseButtonEnable;
  final bool _isGestureDetectorEnable;
  final GestureDetectorCallback _gestureDetectorCallback;
  final CloseButtonCallback _closeButtonCallback;

  LayerTitle(
      this._title,
      this._titleColor,
      this._isTitleEnable,
      this._isCloseButtonEnable,
      this._isGestureDetectorEnable,
      this._gestureDetectorCallback,
      this._closeButtonCallback
  );

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: GestureDetector(
        child: Container(
            width: MediaQuery.of(context).copyWith().size.width - 20,
            height: 65,
            decoration: BoxDecoration(
                color: _titleColor,
                borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(
              children: [
                Positioned(
                    child: Center(
                        child: _title
                    )
                ),
                Visibility(
                  child: Positioned(
                    top: 8,
                    left: MediaQuery.of(context).copyWith().size.width - 65,
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: _closeButtonCallback,
                    ),
                  ),
                  visible: _isCloseButtonEnable,
                )
              ],
            )
        ),
        onPanUpdate: (details) {
          if (_isGestureDetectorEnable) {
            _gestureDetectorCallback(Offset(details.delta.dx, details.delta.dy));
          }
        },
      ),
      visible: _isTitleEnable,
    );
  }
}

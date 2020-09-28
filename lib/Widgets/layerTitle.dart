import 'package:flutter/material.dart';

typedef CloseButtonCallback = void Function();

class LayerTitle extends StatelessWidget {
  final Text _title;
  final Color _titleColor;
  final Color _shadowColor;
  final bool _isCloseButtonEnable;
  final CloseButtonCallback _closeButtonCallback;

  LayerTitle(
      this._title,
      this._titleColor,
      this._shadowColor,
      this._isCloseButtonEnable,
      this._closeButtonCallback
  );

  @override
  Widget build(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).copyWith().size.width - 20,
          height: 65,
          decoration: BoxDecoration(
              color: _titleColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: _shadowColor,
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: Offset(0, -10)
                ),
              ]
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
    );
  }
}

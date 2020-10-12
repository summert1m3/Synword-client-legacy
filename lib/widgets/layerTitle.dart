import 'package:flutter/material.dart';
import 'package:synword/layersSetting.dart';
import 'package:synword/types.dart';

class LayerTitle extends StatelessWidget {
  final Text _title;
  final Color _titleColor;
  final Color _shadowColor;
  final bool _isTitleVisible;
  final bool _isCloseButtonVisible;
  final CloseButtonCallback _closeButtonCallback;

  LayerTitle(
    this._title,
    this._titleColor,
    this._shadowColor,
    this._isTitleVisible,
    this._isCloseButtonVisible,
    this._closeButtonCallback
  );

  @override
  Widget build(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).copyWith().size.width - 20,
          height: TitleHeight,
          decoration: BoxDecoration(
              color: _titleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                    color: _shadowColor,
                    spreadRadius: 1,
                    blurRadius: 13,
                    offset: Offset(0, -15)
                ),
              ]
          ),
          child: Visibility(
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
                  visible: _isCloseButtonVisible,
                )
              ],
            ),
            visible: _isTitleVisible,
          )
    );
  }
}

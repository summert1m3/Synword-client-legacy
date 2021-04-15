import 'package:flutter/material.dart';
import 'package:synword/layers/layersSetting.dart';
import 'package:synword/types.dart';
import 'package:sizer/sizer.dart';

class LayerTitle extends StatelessWidget {
  final Text _title;
  final Color _titleColor;
  final Color _shadowColor;
  final bool _isTitleVisible;
  final bool _isCloseButtonVisible;
  final CloseButtonCallback? _closeButtonCallback;
  final Widget? _aditionalButton;

  LayerTitle(
    this._title,
    this._titleColor,
    this._shadowColor,
    this._isTitleVisible,
    this._isCloseButtonVisible,
    this._closeButtonCallback, { Widget? additionalButton }
  ) : _aditionalButton = additionalButton;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).copyWith().size.width - 20,
          height: layersSetting.titleHeight,
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
                    offset: Offset(0, -20)
                ),
              ]
          ),
          child: Visibility(
            child: Stack(
              children: [
                Visibility(
                  visible: _aditionalButton != null,
                  child: Positioned(
                    top: 8,
                    left: 10,
                    child: _aditionalButton!,
                  ),
                ),
                Positioned(
                    child: Center(
                        child: _title
                    )
                ),
                Visibility(
                  child: Positioned(
                    top: 8,
                    left: MediaQuery.of(context).copyWith().size.width - 22.5.w,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        splashRadius: 23,
                        icon: Icon(Icons.cancel),
                        onPressed: _closeButtonCallback,
                      ),
                    )
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

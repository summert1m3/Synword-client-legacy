import 'package:flutter/material.dart';
import 'package:synword/constants/defaultUserRestrictions.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTextForm.dart';
import 'package:synword/widgets/layerTitle.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';

class OriginalTextWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final bool _isTitleVisible;
  final bool _isReadOnly;
  final void Function() _onChangedCallback;

  OriginalTextWidget(
    this._textEditingController,
    this._isTitleVisible,
    this._isReadOnly,
    this._onChangedCallback
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: BodyLayer(
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Visibility(
                    visible: _textEditingController.text.isNotEmpty,
                    child: Container(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Text(
                            _textEditingController.text.length.toString() + '/' + DefaultUserRestrictions.uniqueUpMaxSymbolLimit.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: _textEditingController.text.length > DefaultUserRestrictions.uniqueUpMaxSymbolLimit ? Colors.red : Colors.black.withOpacity(0.8),
                              fontFamily: 'Roboto',
                            )
                        )
                    ),
                  ),
                  Expanded(child: LayerTextForm(_textEditingController, _isReadOnly, _onChangedCallback)),
                ],
              ),
            ),
            LayerTitle(
                Text('originalTextHeader', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)).tr(),
              HexColor('#D45357'),
                Colors.black.withOpacity(0.0),
                true,
                false,
                null
            ),
            _isTitleVisible,
            false,
            null,
            null,
            null
        )
    );
  }
}

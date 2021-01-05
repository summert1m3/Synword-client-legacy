import 'package:flutter/material.dart';
import 'package:synword/widgets/bodyLayer.dart';
import 'package:synword/widgets/layerTextForm.dart';
import 'package:synword/widgets/layerTitle.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';

class OriginalTextWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final bool _isTitleVisible;

  OriginalTextWidget(
    this._textEditingController,
    this._isTitleVisible
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: BodyLayer(
            Expanded(child: LayerTextForm(_textEditingController)),
            LayerTitle(
                Text('originalTextHeader', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)).tr(),
              HexColor('#D45357'),
                Colors.black.withOpacity(0.0),
                true,
                false,
                null,
            ),
            _isTitleVisible,
            false,
            null,
            null
        )
    );
  }
}

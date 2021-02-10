import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LayerTextForm extends StatelessWidget {
  final TextEditingController _textEditingController;

  LayerTextForm(this._textEditingController);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var lang = Localizations.localeOf(context).languageCode;

    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: _textEditingController,
        maxLines: screenSize.height ~/ 20,
        style: TextStyle(
          fontFamily: ('Roboto'),
          fontSize: 20
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: lang == 'ru' ? 'Gardens' : 'Audrey',
                fontSize: (screenSize.height / 55 + screenSize.width / 55),
                fontWeight: FontWeight.bold),
            hintText: 'textFormHintText'.tr(),
            fillColor: Colors.white,
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

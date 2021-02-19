import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LayerTextForm extends StatelessWidget {
  final TextEditingController _textEditingController;
  final bool _isReadOnly;
  final void Function() _onChangedCallback;

  LayerTextForm(this._textEditingController, this._isReadOnly, this._onChangedCallback);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var lang = Localizations.localeOf(context).languageCode;

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: Scrollbar(
        thickness: 5,
        radius: Radius.circular(10),
        child: TextFormField(
          textInputAction: TextInputAction.done,
          autofocus: false,
          readOnly: _isReadOnly,
          controller: _textEditingController,
          maxLines: null,
          style: TextStyle(
              fontFamily: ('Roboto'),
              fontSize: 20
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, right: 15),
            hintStyle: TextStyle(
                fontFamily: lang == 'ru' ? 'Gardens' : 'Audrey',
                fontSize: (screenSize.height / 55 + screenSize.width / 55),
                fontWeight: FontWeight.bold),
            hintText: 'textFormHintText'.tr(),
            fillColor: Colors.transparent,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          onChanged: (String text) {
            _onChangedCallback();
          },
        ),
      ),
    );
  }
}

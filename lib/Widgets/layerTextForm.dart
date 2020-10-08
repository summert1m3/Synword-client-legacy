import 'package:flutter/material.dart';

class LayerTextForm extends StatelessWidget {
  final TextEditingController _textEditingController;

  LayerTextForm(this._textEditingController);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: _textEditingController,
        maxLines: MediaQuery.of(context).copyWith().size.height ~/ 20,
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: 'Audrey',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            hintText: 'Enter your text here',
            fillColor: Colors.white,
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: InputBorder.none,
            //disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

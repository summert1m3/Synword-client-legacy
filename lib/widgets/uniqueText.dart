import 'package:flutter/material.dart';

class UniqueText extends StatelessWidget {
  final String _uniqueText;
  final Offset _offset;

  UniqueText(
    this._uniqueText,
    this._offset
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SelectableText(_uniqueText,
            style: TextStyle(fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold)),
        ),
        width: MediaQuery.of(context).copyWith().size.width - 20,
        height: (MediaQuery.of(context).copyWith().size.height - 167) - _offset.dy,
    );
  }
}
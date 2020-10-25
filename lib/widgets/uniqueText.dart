import 'package:flutter/material.dart';

class UniqueText extends StatelessWidget {
  final String _uniqueText;
  final Offset _offset;

  UniqueText(
    this._uniqueText,
    this._offset
  );

  double _getSizedBoxHeight(BuildContext context) {
    double height = (MediaQuery.of(context).copyWith().size.height - 167) - _offset.dy;

    if (height < 0) {
      height = 0;
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SelectableText(_uniqueText,
            style: TextStyle(fontSize: 20)),
        ),
        width: MediaQuery.of(context).copyWith().size.width - 20,
        height: _getSizedBoxHeight(context),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UniqueUpResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Card(
          color: HexColor('#366CCA'),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage('icons/docx_logo.png'),
                  height: 90,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('docData.file.names.first',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Roboto')),
              ],
            ),
          ),
        ),
        Card(
          color: HexColor('#5C5C5C'),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, top: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Заменено слов: --',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Количество символов: --',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        ButtonBar(
          buttonMinWidth: 90,
          alignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.blueAccent,
              onPressed: () => {},
              child: Text('Сохранить'),
            ),
            RaisedButton(
              color: Colors.amber,
              onPressed: () => {},
              child: Text('Открыть'),
            )
          ],
        )
      ],
    );
  }
}

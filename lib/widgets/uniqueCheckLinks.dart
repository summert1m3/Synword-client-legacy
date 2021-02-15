import 'package:flutter/material.dart';
import 'package:synword/model/json/uniqueCheckData.dart';

class UniqueCheckLinks extends StatelessWidget {
  final UniqueCheckData _uniqueCheckData;
  final double _height;

  UniqueCheckLinks(
    this._uniqueCheckData,
    this._height
  );

  List<Widget> _createLinksItems(UniqueCheckData uniqueCheckData) {
    List<Widget> linksItems = List<Widget>();

    uniqueCheckData.matches.forEach((element) {
      linksItems.add(UniqueCheckLinksItem(element.url, element.percent.toInt()));
    });

    return linksItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: ListView(
        children: _createLinksItems(_uniqueCheckData),
      )
    );
  }
}

class UniqueCheckLinksItem extends StatelessWidget {
  final String _website;
  final int _value;

  UniqueCheckLinksItem(
    this._website,
    this._value
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _website,
            style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Audrey', fontWeight: FontWeight.bold),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(width: 0.5)
            ),
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 0.5)
                ),
                child: Center(
                  child: Text(
                    _value.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 13,  fontWeight: FontWeight.bold),
                  )
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class UniqueCheckLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          UniqueCheckLinksItem(
              'google.com',
              10
          ),
          UniqueCheckLinksItem(
              'yandex.ru',
              10
          ),
          UniqueCheckLinksItem(
              'wikipedia.org',
              5
          ),
          UniqueCheckLinksItem(
              'yahoo.com',
              5
          ),
        ],
      ),
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
            style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Audrey', fontWeight: FontWeight.bold),
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(width: 0.5)
            ),
            child: Center(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(width: 0.5)
                ),
                child: Center(
                  child: Text(
                    _value.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 15,  fontWeight: FontWeight.bold),
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
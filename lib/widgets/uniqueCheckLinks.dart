import 'package:flutter/material.dart';
import 'package:synword/model/json/uniqueCheckData.dart';
import 'package:url_launcher/url_launcher.dart';

class UniqueCheckLinks extends StatelessWidget {
  final UniqueCheckData _uniqueCheckData;
  final double _height;
  final Color _textColor;
  final Axis _axis;
  final bool _scheme;

  UniqueCheckLinks(
    this._uniqueCheckData,
    this._height, {
      Color textColor = Colors.black,
      Axis axis = Axis.vertical,
        bool scheme = true
    }
  ) : _textColor = textColor,
      _axis = axis,
      _scheme = scheme;

  List<Widget> _createLinksItems(UniqueCheckData uniqueCheckData) {
    List<Widget> linksItems = List<Widget>();

    uniqueCheckData.matches.forEach((element) {
      String urlTitle = element.url;

      if (urlTitle.length > 20) {
        urlTitle = urlTitle.substring(0, 17);
        urlTitle += '...';
      }

      linksItems.add(UniqueCheckLinksItem(element.url, urlTitle, element.percent.toInt(), _textColor, _scheme));
    });

    return linksItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Scrollbar(
        thickness: 5,
        radius: Radius.circular(10),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: _axis,
              child: Column(
                children: _createLinksItems(_uniqueCheckData),
              ),
            )
          ],
        ),
      )
    );
  }
}

class UniqueCheckLinksItem extends StatelessWidget {
  final String _websiteUrl;
  final String _websiteTitle;
  final int _value;
  final Color _textColor;
  final bool _scheme;

  UniqueCheckLinksItem(this._websiteUrl, this._websiteTitle, this._value, this._textColor, this._scheme);

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text(
              _scheme == true ? Uri.parse(_websiteTitle).scheme + '://' + Uri.parse(_websiteTitle).host : Uri.parse(_websiteTitle).host,
              style: TextStyle(color: _textColor, fontSize: (screenSize.height + screenSize.width) / 50, fontFamily: 'Audrey', fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              await _launchURL(_websiteUrl);
            },
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

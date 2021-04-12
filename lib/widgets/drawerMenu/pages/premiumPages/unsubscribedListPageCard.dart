import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UnsubscribedListPageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  UnsubscribedListPageCard({
    this.imagePath,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: (screenSize.height + screenSize.width) / 330,
          horizontal: 30),
      child: Card(
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: (screenSize.height + screenSize.width) / 130,
              horizontal: (screenSize.height + screenSize.width) / 50),
          onTap: () => {},
          leading: Image(
            image: AssetImage(imagePath),
            color: Colors.red,
            height: 40,
          ),
          title: Text(title,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: (screenSize.height + screenSize.width) / 70))
              .tr(),
          subtitle: Text(subtitle,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: (screenSize.height + screenSize.width) / 70))
              .tr(),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:synword/widgets/drawerMenu/pages/coinPages/coinPage.dart';
import 'package:wiredash/wiredash.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dialogs/langDialog.dart';
import 'package:synword/widgets/drawerMenu/pages/premiumPage.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 2.8,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: 5
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: (screenSize.height + screenSize.width) / 40,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 3,
              ),
              Text('drawerCommercial',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, fontSize: (screenSize.height + screenSize.width) / 80,
                  ),
              ).tr(),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 240,
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                icon: SvgPicture.asset(
                  'icons/premium.svg',
                  semanticsLabel: 'Premium',
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PremiumPage())),
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                icon: SvgPicture.asset(
                  'icons/buy_symbols.svg',
                  semanticsLabel: 'Buy',
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CoinPage())),
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 160,
              ),
              Text(
                  'drawerSocial',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: (screenSize.height + screenSize.width) / 80,
                  ),
              ).tr(),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 240,
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                icon: Image(
                  image: AssetImage('icons/instagram.png'),
                ),
                onPressed: () => _launchURL('https://www.instagram.com/')
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                icon: Image(
                  image: AssetImage('icons/vk.png'),
                ),
                onPressed: () => _launchURL('https://vk.com/'),
              ),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 160,
              ),
              Text('drawerOther',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: (screenSize.height + screenSize.width)/80,
                  ),
              ).tr(),
              SizedBox(
                height: (screenSize.height + screenSize.width) / 240,
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                icon: SvgPicture.asset(
                  'icons/language.svg',
                  semanticsLabel: 'Language',
                ),
                onPressed: () => _showLangDialog(context),
              ),
              IconButton(
                iconSize: (screenSize.height / 17 + screenSize.width / 17),
                icon: SvgPicture.asset(
                  'icons/feedback.svg',
                  semanticsLabel: 'Feedback',
                ),
                onPressed: () => Wiredash.of(context)!.show(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _showLangDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return LangDialog();
    },
  );
}

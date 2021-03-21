import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:open_file/open_file.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../uniqueCheckLinks.dart';
import '../../../waveBar.dart';
import '../../documentData.dart';

class DocUpAndCheckResultPage extends StatelessWidget {
  TabController _tabController;

  var _kTabs = <Tab>[
    Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.blue, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Icon(Icons.arrow_circle_up),
        ),
      ),
    ),
    Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.blue, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Icon(Icons.check_circle),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: TabBarView(
            controller: _tabController,
            children: {
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: WaveBar(docData.uniqueCheckData.percent / 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: UniqueCheckLinks(
                      docData.uniqueCheckData,
                      screenSize.height - (screenSize.height / 1.8),
                      textColor: Colors.black,
                      scheme: false,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                          Text("synword_" + docData.file.names.first,
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Roboto')),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Card(
                    color: HexColor('#5C5C5C'),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'documentHandleFinishCaseSavedFile'.tr(),
                            style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonBar(
                    buttonMinWidth: 90,
                    alignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        color: Colors.amber,
                        onPressed: () => OpenFile.open(DocumentData.downloadPath + "synword_" + docData.file.names.first, type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"),
                        child: Text('documentHandleFinishCaseUniqueUpButton', style: TextStyle(fontFamily: 'Roboto'),).tr(),
                      )
                    ],
                  )
                ],
              )
            }.toList(),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 15.0.h,
          title: Text('resultHeader', style: TextStyle(fontSize: 18.0.sp)).tr(),
          backgroundColor: Colors.black,
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TabBar(
                    controller: _tabController,
                    unselectedLabelColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue),
                    tabs: _kTabs,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

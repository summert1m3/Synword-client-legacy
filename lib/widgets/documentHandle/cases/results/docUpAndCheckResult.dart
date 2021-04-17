import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueCheckResultPage.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueUpResultPage.dart';

class ResultsCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ResultsCaseState();
}

class _ResultsCaseState extends State<ResultsCase> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _kTabPages = <Widget>[
    DocUniqueUpResultPage(),
    DocUniqueCheckResultPage()
  ];

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
  void initState(){
    super.initState();
    _tabController = TabController(
        length: _kTabPages.length,
        vsync: this,
    );
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: TabBarView(
            controller: _tabController,
            children: _kTabPages,
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(58),
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
            ),
          ),
        ));
  }
}

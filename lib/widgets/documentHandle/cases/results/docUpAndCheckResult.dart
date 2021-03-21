import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueCheckResult.dart';
import 'package:synword/widgets/documentHandle/cases/results/docUniqueUpResult.dart';

class ResultsCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ResultsCaseState();
}

class _ResultsCaseState extends State<ResultsCase> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _kTabPages = <Widget>[
    UniqueUpResult(),
    UniqueCheckResult()
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        backgroundColor: HexColor('#262626'),
        body: TabBarView(
          controller: _tabController,
          children: _kTabPages,
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Align(
              alignment: Alignment.centerLeft,
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
    );
  }
}

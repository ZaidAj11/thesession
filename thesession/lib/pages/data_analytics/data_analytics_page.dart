import 'package:flutter/material.dart';
import 'package:thesession/pages/data_analytics/sessions_analytics_page.dart';
import 'package:thesession/utils/dataManager.dart';

import '../../main.dart';

class DataAnalyticsPage extends StatefulWidget {
  DataAnalyticsPage({super.key});
  final dataManager = DataManager();

  @override
  State<DataAnalyticsPage> createState() => _DataAnalyticsPageState();
}

class _DataAnalyticsPageState extends State<DataAnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Session Data Analytics"),
          backgroundColor: AppColours.DefaultDarkColour,
        ),
        body: Center(
            child: SessionsAnalyticsPage(dataManager: widget.dataManager)));
  }
}

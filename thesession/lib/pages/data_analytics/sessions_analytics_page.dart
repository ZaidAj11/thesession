import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:thesession/utils/dataManager.dart';

import '../../models/data_analytics/SessionData.dart';
import '../../widgets/my_appbar.dart';
import '../../widgets/side_drawer.dart';

class SessionsAnalyticsPage extends StatefulWidget {
  final DataManager dataManager;
  const SessionsAnalyticsPage({super.key, required this.dataManager});

  @override
  State<SessionsAnalyticsPage> createState() => _SessionsAnalyticsPageState();
}

class _SessionsAnalyticsPageState extends State<SessionsAnalyticsPage> {
  List<ItemCountryData> sessionCountryData = [];
  List<ItemCountryData> sessionCountyData = [];

  final user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  Future<bool> getData() async {
    bool isReady = await widget.dataManager.setSessionData();
    if (isReady) {
      sessionCountryData
          .addAll(await widget.dataManager.getSessionToCountrySections());
      sessionCountyData
          .addAll(await widget.dataManager.getSessionToCountySections());
      if (sessionCountryData.isNotEmpty && sessionCountyData.isNotEmpty)
        return true;
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: getData(),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (sessionCountryData.isNotEmpty) {
              return SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: SfCircularChart(
                          legend: Legend(isVisible: true, isResponsive: true),
                          title: ChartTitle(text: "Sessions by Country"),
                          series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ItemCountryData, String>(
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            name: "Sessions by Country",
                            dataSource: sessionCountryData,
                            pointColorMapper: (ItemCountryData data, _) =>
                                data.color,
                            xValueMapper: (ItemCountryData data, _) =>
                                data.item,
                            yValueMapper: (ItemCountryData data, _) =>
                                data.count)
                      ])),
                  Container(
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(text: "Sessions by Irish County"),
                          series: <ChartSeries<ItemCountryData, String>>[
                        // Renders column chart
                        ColumnSeries<ItemCountryData, String>(
                            dataSource: sessionCountyData,
                            xValueMapper: (ItemCountryData data, _) =>
                                data.item,
                            yValueMapper: (ItemCountryData data, _) =>
                                data.count)
                      ])),
                ],
              ));
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

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
  List<ItemCountryData> sessionData = [];
  final user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  Future<bool> getData() async {
    bool isReady = await widget.dataManager.setSessionData();
    if (isReady) {
      sessionData
          .addAll(await widget.dataManager.getSessionToCountrySections());
      if (sessionData.isNotEmpty) return true;
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
            if (sessionData.isNotEmpty) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                      child: SfCircularChart(
                          legend: Legend(isVisible: true, isResponsive: true),
                          series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ItemCountryData, String>(
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            name: "Sessions by Country",
                            dataSource: sessionData,
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
                          series: <ChartSeries<ItemCountryData, String>>[
                        // Renders column chart
                        ColumnSeries<ItemCountryData, String>(
                            dataSource: sessionData,
                            xValueMapper: (ItemCountryData data, _) =>
                                data.item,
                            yValueMapper: (ItemCountryData data, _) =>
                                data.count)
                      ])),
                  Container(
                      child: SfCircularChart(series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ItemCountryData, String>(
                        dataSource: sessionData,
                        pointColorMapper: (ItemCountryData data, _) =>
                            data.color,
                        xValueMapper: (ItemCountryData data, _) => data.item,
                        yValueMapper: (ItemCountryData data, _) => data.count)
                  ])),
                  Container(
                      child: SfCircularChart(series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ItemCountryData, String>(
                        dataSource: sessionData,
                        pointColorMapper: (ItemCountryData data, _) =>
                            data.color,
                        xValueMapper: (ItemCountryData data, _) => data.item,
                        yValueMapper: (ItemCountryData data, _) => data.count)
                  ]))
                ],
              ));
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

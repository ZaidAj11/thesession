import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:thesession/utils/dataManager.dart';

class TunesAnalyticsPage extends StatefulWidget {
  const TunesAnalyticsPage({super.key, required this.dataManager});
  final DataManager dataManager;

  @override
  State<TunesAnalyticsPage> createState() => _TunesAnalyticsPageState();
}

class _TunesAnalyticsPageState extends State<TunesAnalyticsPage> {
  List<ItemCountryData> tuneData = [];
  List<ItemCountryData> tuneSetsData = [];

  Future<bool> getData() async {
    bool isReady = await widget.dataManager.setTuneData();
    if (isReady) {
      tuneData.addAll(await widget.dataManager.getTuneToTypeSections());
      tuneSetsData.addAll(await widget.dataManager.getTuneToTypeSections());
      if (tuneData.isNotEmpty) return true;
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var tooltip = TooltipBehavior(enable: true);
    return Center(
      child: FutureBuilder(
          future: getData(),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (tuneData.isNotEmpty) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                      child: SfCartesianChart(
                          title: ChartTitle(text: "Most Popular Types"),
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                              minimum: 0, maximum: 40, interval: 10),
                          tooltipBehavior: tooltip,
                          series: <ChartSeries<ItemCountryData, String>>[
                        BarSeries<ItemCountryData, String>(
                            dataSource: tuneData,
                            xValueMapper: (ItemCountryData data, _) =>
                                data.item,
                            yValueMapper: (ItemCountryData data, _) =>
                                data.count,
                            name: 'Gold',
                            color: Color.fromRGBO(8, 142, 255, 1))
                      ])),
                  Container(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(text: "Most Popular Types"),
                        series: <ChartSeries<ItemCountryData, String>>[
                          // Renders column chart
                          ColumnSeries<ItemCountryData, String>(
                              dataSource: tuneData,
                              xValueMapper: (ItemCountryData data, _) =>
                                  data.item,
                              yValueMapper: (ItemCountryData data, _) =>
                                  data.count)
                        ]),
                  ),
                ],
              ));
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

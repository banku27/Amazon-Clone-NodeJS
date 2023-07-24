import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/loader.dart';
import '../models/sales.dart';
import '../services/admin_services.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(children: [
            Text(
              '₹$totalSales',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<Sales, String>(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 29, 201, 192),
                    Color.fromARGB(255, 125, 221, 216),
                  ]),
                  dataSource: earnings!,
                  xValueMapper: (Sales sales, _) => sales.label,
                  yValueMapper: (Sales sales, _) => sales.earning,
                ),
              ],

              // SizedBox(
              //   height: 600,
              //   child: Card(
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(4)),
              //     // color: const Color(0xff2c4260),
              //     child: BarChart(
              //       BarChartData(
              //         alignment: BarChartAlignment.spaceAround,
              //         maxY: getMaxEarnings(),
              //         barTouchData: BarTouchData(
              //           touchTooltipData: BarTouchTooltipData(
              //             tooltipBgColor: Colors.grey,
              //             getTooltipItem: (group, groupIndex, rod, rodIndex) {
              //               return BarTooltipItem(
              //                 '${earnings![groupIndex].label}: \$${rod.toY.toStringAsFixed(2)}',
              //                 const TextStyle(color: Colors.yellow),
              //               );
              //             },
              //           ),
              //         ),
              //         //   titlesData: FlTitlesData(
              //         //     show: true,
              //         //     bottomTitles: AxisTitles(

              //         //       show: true,
              //         //       textStyle: const TextStyle(
              //         //           color: Color(0xff7589a2),
              //         //           fontWeight: FontWeight.bold,
              //         //           fontSize: 14),
              //         //       margin: 20,
              //         //       getTitles: (double value) {
              //         //         return salesData![value.toInt()].label;
              //         //       },
              //         //     ),
              //         //     leftTitles: const SideTitles(showTitles: true),
              //         //   ),
              //         //   borderData: FlBorderData(
              //         //     show: false,
              //         //   ),
              //         barGroups: getBarGroups(),
              //       ),
              //     ),
              //   ),
              // )
            )
          ]);
  }

  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < earnings!.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
                toY: earnings![i].earning.toDouble(), color: Colors.lightBlue)
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barGroups;
  }

  double getMaxEarnings() {
    double maxEarnings = 0;
    for (Sales sale in earnings!) {
      if (sale.earning > maxEarnings) {
        maxEarnings = sale.earning.toDouble();
      }
    }
    return maxEarnings;
  }
}

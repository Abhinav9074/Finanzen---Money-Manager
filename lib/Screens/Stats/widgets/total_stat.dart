import 'package:flutter/material.dart';
import 'package:money_manager/Screens/Stats/models/stat_models.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalStats extends StatefulWidget {
  const TotalStats({super.key});

  @override
  State<TotalStats> createState() => _TotalStatsState();
}

class _TotalStatsState extends State<TotalStats> {

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    CategoryDb().refreshUI();
    TransactionDb().refreshUI();
    
    getAllChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AllChartDataNotifier,
      builder: (BuildContext context, List<TotalDataModel> newList, Widget? _){
        return AllChartDataNotifier.value.isNotEmpty?Center(
      child: SfCircularChart(
        legend: const Legend(
            isVisible: true,
            isResponsive: true,
            overflowMode: LegendItemOverflowMode.wrap,
            alignment: ChartAlignment.center,
            position: LegendPosition.left,
            iconHeight: 20,
            iconWidth: 30,
            textStyle: TextStyle(
                fontFamily: 'texgyreadventor-regular',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 2, 39, 71))),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          DoughnutSeries<TotalDataModel, String>(
              dataSource: newList,
              xValueMapper: (TotalDataModel data, _) => data.Type,
              yValueMapper: (TotalDataModel data, _) => data.amount,      
              enableTooltip: true,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              legendIconType: LegendIconType.seriesType),
              
        ],
      ),
    ):Center(child: Text('No Data'));
      },
    );
  }
}
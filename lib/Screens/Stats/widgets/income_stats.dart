import 'package:flutter/material.dart';
import 'package:money_manager/Screens/stats/models/stat_models.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeStats extends StatefulWidget {
  const IncomeStats({super.key});

  @override
  State<IncomeStats> createState() => _IncomeStatsState();
}

class _IncomeStatsState extends State<IncomeStats> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    CategoryDb().refreshUI();
    TransactionDb().refreshUI();
    getIncomeChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: IncomeChartDataNotifier,
      builder: (BuildContext context, List<IncomeData> newList, Widget? _){
        return IncomeChartDataNotifier.value.isNotEmpty?Center(
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
          DoughnutSeries<IncomeData, String>(
              dataSource: newList,
              xValueMapper: (IncomeData data, _) => data.incomeSource,
              yValueMapper: (IncomeData data, _) => data.amount,      
              enableTooltip: true,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              legendIconType: LegendIconType.seriesType),
              
        ],
      ),
    ):Center(
      child: Text('No Data'),
    );
      },
    );
  }
  
}

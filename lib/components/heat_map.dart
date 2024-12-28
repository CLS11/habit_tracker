import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMap extends StatelessWidget {
  const HeatMap({
    required this.initDate,
    required this.datasets,
    super.key,
  });

  final DateTime initDate;
  final Map<DateTime, int>? datasets;

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      initDate: initDate,
      datasets: datasets,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Colors.white,
      showColorTip: false,
      colorMode: ColorMode.color,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
    );
  }
}

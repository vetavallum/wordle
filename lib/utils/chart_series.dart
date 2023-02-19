import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chart_model.dart';

Future<List<charts.Series<ChartModel, String>>> getSeries() async {
  List<ChartModel> data = [];

  final prefs = await SharedPreferences.getInstance();
  final scores = await prefs.getStringList('chart');
  final row = await prefs.getInt('row');
  if (scores != null) {
    for (var e in scores) {
      data.add(ChartModel(score: int.parse(e), currentGame: false));
    }
  }

  if (row != null) {
    data[row - 1].currentGame = true;
  }

  return [
    charts.Series<ChartModel, String>(
      id: 'Stats',
      data: data,
      domainFn: (model, index) {
        // x-axis label
        int i = index! + 1;
        //return i.toString();
        // ignore: prefer_interpolation_to_compose_strings
        if (i == 1) {
          return 'Splendid';
        } else if (i == 2) {
          return 'Wow';
        } else if (i == 3) {
          return 'Great';
        } else if (i == 4) {
          return 'Good';
        } else if (i == 5) {
          return 'Nice';
        } else {
          return 'Phew';
        }
      },
      measureFn: (model, index) => model.score, //y-axis label
      colorFn: (model, index) {
        if (model.currentGame) {
          return charts.MaterialPalette.green.shadeDefault;
        } else {
          return charts.MaterialPalette.gray.shadeDefault;
        }
      },
    ),
  ];
}

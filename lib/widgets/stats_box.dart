import '../main.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/chart_model.dart';
import '../utils/calculate_stats.dart';
import '../constants/answer_stages.dart';
import '../utils/chart_series.dart';
import '../data/keys_map.dart';
import './stats_tile.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12,
          size.width * 0.08, size.height * 0.12),
      content:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        IconButton(
            alignment: Alignment.centerRight,
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: const Icon(Icons.clear)),
        const Expanded(
          child: Text(
            'STATISTICS',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: FutureBuilder(
              future: getStats(),
              builder: (context, snapshot) {
                List<String> results = ['0', '0', '0', '0', '0'];
                if (snapshot.hasData) {
                  results = snapshot.data as List<String>;
                  print('statsbox - inside FutureBuilder snapshot hasdata- 1');
                }
                print('statsbox - outside FutureBuilder snapshot hasdata- 2');
                return Row(children: [
                  StatsTile(heading: 'Played', value: int.parse(results[0])),
                  StatsTile(heading: 'Win %', value: int.parse(results[2])),
                  StatsTile(
                      heading: 'Current\nStreak', value: int.parse(results[3])),
                  StatsTile(
                      heading: 'Max\nStreak', value: int.parse(results[4])),
                ]);
              }),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
            child: FutureBuilder(
              future: getSeries(),
              builder: (context, snapshot) {
                final List<charts.Series<ChartModel, String>> series;
                if (snapshot.hasData) {
                  series =
                      snapshot.data as List<charts.Series<ChartModel, String>>;
                  return charts.BarChart(
                    series,
                    vertical: false,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              keysMap
                  .updateAll((key, value) => value = AnswerStage.notAnswered);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                  (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Replay',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ]),
    );
  }
}

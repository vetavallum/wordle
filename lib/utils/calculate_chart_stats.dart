import 'package:shared_preferences/shared_preferences.dart';

setChartStats({required int currentRow}) async {
  List<int> distribution = [0, 0, 0, 0, 0, 0];
  List<String> distributionString = [];

  final stats = await getStats();
  if (stats != null) {
    distribution = stats;
  }

  for (int i = 0; i < distribution.length; i++) {
    if (currentRow - 1 == i) {
      distribution[i]++;
    }
  }

  for (int i = 0; i < distribution.length; i++) {
    distributionString.add(distribution[i].toString());
  }

  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('row', currentRow);
  prefs.setStringList('chart', distributionString);
}

Future<List<int>?> getStats() async {
  final prefs = await SharedPreferences.getInstance();

  final stats = prefs.getStringList('chart');
  print(
      'IMPORTANT - getStringList of stats is called from calculate_chart_stats');

  final statsData = prefs.getStringList('stats');
  final rowData = prefs.getStringList('row');
  print('chart Series - getStats() statsData - 0 - ${statsData}');

  print('chart Series - getStats() stats - 1 - ${stats}');
  print('chart Series - getStats() row - 1 - ${rowData}');

  if (stats != null) {
    List<int> result = [];
    print('chart Series - getStats() stats NOT null - 2 ${stats}');

    for (var e in stats) {
      result.add(int.parse(e));
    }
    return result;
  } else {
    print('chart Series - getStats() stats = null - 3 ${stats}');

    return null;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

calculateStats({required bool gameWon}) async {
  int gamesPlayed = 0,
      gamesWon = 0,
      winPercentage = 0,
      currentStreak = 0,
      maxStreak = 0;

  print('CalculateStats - before getting statistics - 0');

  final stats = await getStats();
  print('geting Statistics - 1');
  if (stats != null) {
    print('CalculateStats -  inside not null ${stats[0]} - 2');

    gamesPlayed = int.parse(stats[0]);
    gamesWon = int.parse(stats[1]);
    winPercentage = int.parse(stats[2]);
    currentStreak = int.parse(stats[3]);
    maxStreak = int.parse(stats[4]);
  }
  gamesPlayed++;
  print('CalculateStats -  got statistics $gamesPlayed- 3');

  if (gameWon) {
    gamesWon++;
    currentStreak++;
  } else {
    currentStreak = 0;
  }

  if (currentStreak > maxStreak) {
    maxStreak = currentStreak;
  }
  winPercentage = ((gamesWon / gamesPlayed) * 100).toInt();

  final prefs = await SharedPreferences.getInstance();
  print('CalculateStats - prefs defined - 4');
  prefs.setStringList('stats', [
    gamesPlayed.toString(),
    gamesWon.toString(),
    winPercentage.toString(),
    currentStreak.toString(),
    maxStreak.toString()
  ]);
  print('CalculateStats - values set in the shared preferences - 5');
  final values = await getStats();
  print('geting Statistics to confirm if the value is set - 6 ');
  if (values != null) {
    print(
        'Values are ${values[0]}, ${values[1]}, ${values[2]}, ${values[3]}, ${values[4]}');
  } else {
    print(
        'Values are null ${values![0]}, ${values[1]}, ${values[2]}, ${values[3]}, ${values[4]}');
  }
}

Future<List<String>?> getStats() async {
  print('calculate_stats - getStats() - 1');

  final prefs = await SharedPreferences.getInstance();
  print('calculate_stats - getStats() - 2');

  final stats = prefs.getStringList('stats');
  if (stats != null) {
    print('calculate_stats - getStats() stats NOT null - 3 ${stats}');

    return stats;
  } else {
    print('calculate_stats - getStats() stats null - 4 ${stats}');

    return null;
  }
}

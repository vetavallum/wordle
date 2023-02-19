import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/quick_box.dart';
import '../widgets/stats_box.dart';
import '../constants/words.dart';
import '../providers/controller.dart';
import '../widgets/grid.dart';
import '../widgets/keyboard_row.dart';
import './settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _word;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    print('words index = $r');
    _word = words[r];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: _word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickBox(context: context, message: 'Not Enough Letters');
              }
              if (!notifier.validWord) {
                runQuickBox(context: context, message: 'Not a valid word');
              }
              print('homepage - AppBar(actions:[]) - 1');
              if (notifier.gameCompleted) {
                print('homepage - AppBar(actions:[]) game completed - 2');

                if (notifier.gameWon) {
                  print('homepage - AppBar(actions:[]) game won - 3');

                  if (notifier.currentRow == 6) {
                    runQuickBox(context: context, message: 'Phew!');
                  } else if (notifier.currentRow == 5) {
                    runQuickBox(context: context, message: 'Nice!');
                  } else if (notifier.currentRow == 4) {
                    runQuickBox(context: context, message: 'Good!');
                  } else if (notifier.currentRow == 3) {
                    runQuickBox(context: context, message: 'Great!');
                  } else if (notifier.currentRow == 2) {
                    runQuickBox(context: context, message: 'Wow!');
                  } else {
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                } else {
                  runQuickBox(
                      context: context, message: notifier.correctWordString);
                }
                Future.delayed(
                  const Duration(milliseconds: 3000),
                  () {
                    print('homepage - AppBar(actions:[]) game completed - 4');
                    if (mounted) {
                      print(
                          'homepage - AppBar(actions:[]) mounted game completed - 5');

                      showDialog(
                          context: context, builder: (_) => const StatsBox());
                    }
                  },
                );
              }
              return IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context, builder: (_) => const StatsBox());
                  },
                  icon: const Icon(Icons.bar_chart_outlined));
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(children: [
        const Divider(
          height: 1,
          thickness: 2,
        ),
        const Expanded(
          flex: 7,
          child: Grid(),
        ),
        Expanded(
          flex: 4,
          child: Column(children: const [
            KeyBoardRow(min: 1, max: 10),
            KeyBoardRow(min: 11, max: 19),
            KeyBoardRow(min: 20, max: 29),
          ]),
        ),
      ]),
    );
  }
}

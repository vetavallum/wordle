import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/constants/colors.dart';

import '../data/keys_map.dart';
import '../providers/controller.dart';

class KeyBoardRow extends StatelessWidget {
  final int min, max;

  const KeyBoardRow({
    required this.min,
    required this.max,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double ratio = size.height / size.width;
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        var index = 0;
        return IgnorePointer(
          ignoring: notifier.gameCompleted,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keysMap.entries.map(
              (e) {
                index++;
                if (index >= min && index <= max) {
                  Color color = Theme.of(context).primaryColorLight;
                  Color keyColor = Colors.white;

                  if (e.value == AnswerStage.correct) {
                    color = correctGreen;
                  } else if (e.value == AnswerStage.contains) {
                    color = containsYellow;
                  } else if (e.value == AnswerStage.incorrect) {
                    color = Theme.of(context).primaryColorDark;
                  } else {
                    keyColor = Theme.of(context).textTheme.bodyText2?.color ??
                        Colors.black;
                  }
                  return Padding(
                    //padding: EdgeInsets.all(size.width * 0.006),
                    padding: ratio < 1.0
                        ? EdgeInsets.all(size.width * 0.004)
                        : EdgeInsets.all(size.width * 0.006),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        width: e.key == 'ENTER' || e.key == 'BACK'
                            ? size.width * 0.138
                            : size.width * 0.085,
                        height: size.height * 0.090,
                        child: Material(
                          color: color,
                          child: InkWell(
                            onTap: () {
                              Provider.of<Controller>(context, listen: false)
                                  .setKeyTapped(value: e.key);
                            },
                            child: Center(
                              child: (Text(
                                e.key,
                                // style: const TextStyle(
                                //     color: Colors.black,
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.bold),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: keyColor),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ).toList(),
          ),
        );
      },
    );
  }
}

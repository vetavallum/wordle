// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/controller.dart';
import '../constants/answer_stages.dart';
import '../constants/colors.dart';

class Tile extends StatefulWidget {
  final int index;
  const Tile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;

  Color _backgroundColor = Colors.transparent;
  late AnswerStage _answerStage;

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (_, notifier, __) {
      String text = "";
      Color fontColor = Colors.white;

      // _animationController = AnimationController(
      //     duration: const Duration(microseconds: 600), vsync: this);

      // bool _animate = false;

      // @override
      // void dispose() {
      //   _animationController.dispose();
      //   super.dispose();
      // }

      // ;

      if (widget.index < notifier.tilesEntered.length) {
        text = notifier.tilesEntered[widget.index].letter;
        _answerStage = notifier.tilesEntered[widget.index].answerStage;
        // _animationController.forward();
        if (_answerStage == AnswerStage.correct) {
          _backgroundColor = correctGreen;
        } else if (_answerStage == AnswerStage.contains) {
          _backgroundColor = containsYellow;
        } else if (_answerStage == AnswerStage.incorrect) {
          _backgroundColor = Theme.of(context).primaryColorDark;
        } else {
          fontColor =
              Theme.of(context).textTheme.bodyText2?.color ?? Colors.black;
        }
      } else {
        const SizedBox();
      }

      // return AnimatedBuilder(
      // animation: _animationController,
      // builder: (_, child) {
      // return Transform(
      //   alignment: Alignment.center,
      //   transform: Matrix4.identity()
      //     ..rotateX(_animationController.value * pi),
      return Container(
        color: _backgroundColor,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              text,
              style: const TextStyle().copyWith(color: fontColor),
            ),
          ),
        ),
        //     ),
        //   // );
        // },
      );
    });
  }
}

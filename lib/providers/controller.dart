import 'package:flutter/material.dart';

import '../constants/valid_words.dart';
import '../constants/answer_stages.dart';
import '../models/tile_model.dart';
import '../data/keys_map.dart';
import '../utils/calculate_chart_stats.dart';
import '../utils/calculate_stats.dart';

class Controller with ChangeNotifier {
  bool checkLine = false,
      backOrEnterTapped = false,
      gameWon = false,
      gameCompleted = false,
      notEnoughLetters = false,
      validWord = true;
  String correctWordString = "";
  int currentTile = 0, currentRow = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWordString = word;

  setKeyTapped({required String value}) {
    validWord = true;
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == 5 * (currentRow + 1)) {
        print(correctWordString);
        checkWord();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > (5 * (currentRow + 1)) - 5) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(
            TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  checkWord() {
    List<String> guessedList = [], remainingCorrectList = [];
    String guessedWordString = "";

    for (int i = (currentRow * 5); i < (currentRow * 5) + 5; i++) {
      guessedList.add(tilesEntered[i].letter);
    }

    guessedWordString = guessedList.join();
    remainingCorrectList = correctWordString.characters.toList();

    if (!validWords.contains(guessedWordString)) {
      //print('Srinivasan - not a valid word');
      validWord = false;
      return;
    } else {
      validWord = true;
      //print('Srinivasan - is a valid word -');
    }

    if (guessedWordString == correctWordString) {
      for (int i = (currentRow * 5); i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < 5; i++) {
        if (guessedWordString[i] == correctWordString[i]) {
          remainingCorrectList.remove(guessedWordString[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWordString[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrectList.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (remainingCorrectList[i] ==
              tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage =
                  AnswerStage.contains;
            }
            final resultKey = keysMap.entries.where((element) =>
                element.key == tilesEntered[j + (currentRow * 5)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }

      for (int i = (currentRow * 5); i < (currentRow * 5) + 5; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;
          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }

    checkLine = true;
    currentRow++;
    if (currentRow == 6) {
      gameCompleted = true;
    }
    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }
    notifyListeners();
  }
}

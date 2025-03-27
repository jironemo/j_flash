import 'package:flutter/material.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/repository/card_repository.dart';

class QuizModel extends ChangeNotifier {
  int _score = 0;
  String _currentQuestion = '';
  bool _currentCorrect = false;
  bool _endOfQuestions = false;
  String _correctAnswer = '';
  static int deckIndex = 0;
  int _totalQuestions = 0;
  static final CardEntityRepository _cardEntityRepository =
      CardEntityRepository();
  QuizModel.withDeck(int deckIdx) {
    deckIndex = deckIdx;
  }
  QuizModel();
  static List<CardEntity> _questions = [];

  void loadQuestions() async {
    _questions = await _cardEntityRepository.fetchCards(deckIndex);
    _currentQuestion = _questions[0].front;
    _correctAnswer = _questions[0].back;
    _totalQuestions = _questions.length;
    notifyListeners();
  }

  int get score => _score;
  String get currentQuestion => _currentQuestion;
  bool get currentCorrect => _currentCorrect;
  String get correctAnswer => _correctAnswer;
  bool get endOfQuestions => _endOfQuestions;
  int get totalQuestions => _totalQuestions;
  void submitAnswer(String userAnswer) {
    if (userAnswer == _correctAnswer) {
      _score++;
      _currentCorrect = true;
    }
    notifyListeners();
  }

  void nextQuestion() {
    _questions.removeAt(0);
    if (_questions.isNotEmpty) {
      _currentQuestion = _questions[0].front;
    } else {
      _endOfQuestions = true;
    }

    notifyListeners();
  }

  void nextAnswer() {
    if (_questions.isNotEmpty) {
      _correctAnswer = _questions[0].back;
    }
    notifyListeners();
  }
}

import 'dart:async';

import 'package:e_learning_application/models/quiz.dart';
import 'package:e_learning_application/models/quiz_attempt.dart';
import 'package:e_learning_application/services/dummy_data_service.dart';
import 'package:flutter/material.dart';

class QuizAttempScreen extends StatefulWidget {
  final String quizId;

  const QuizAttempScreen({super.key, required this.quizId});

  @override
  State<QuizAttempScreen> createState() => _QuizAttempScreenState();
}

class _QuizAttempScreenState extends State<QuizAttempScreen> {
  late final Quiz quiz;
  late final PageController _pageController;
  int _currentPage = 0;
  Map<String, String> selectedAnswer = {}; // questionId : optionId
  int remainingSeconds = 0;
  Timer? _timer;
  QuizAttempt? currentAttempt;

  @override
  void initState() {
    super.initState();
    quiz = DummyDataService.getQuizById(widget.quizId);
    _pageController = PageController();
    _pageController.addListener(_onPageChanged);
    remainingSeconds = quiz.timeLimit * 60;
    _startTimer();
  }

  void _onPageChanged() {
    if (_pageController.page != null) {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        _submitQuiz();
      }
    });
  }

  void _submitQuiz() {
    _timer?.cancel();
    final score = _calculateScore();
    currentAttempt = QuizAttempt(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      quizId: quiz.id,
      userId: 'current user is',
      answer: selectedAnswer,
      score: score,
      startedAt: DateTime.now().subtract(
        Duration(seconds: quiz.timeLimit * 60 - remainingSeconds),
      ),
      timeSpent: quiz.timeLimit * 60 - remainingSeconds,
    );

    DummyDataService.saveQuizAttempt(currentAttempt!);

    // navigate to quiz result screen
  }

  int _calculateScore() {
    int score = 0;
    for (final question in quiz.questions) {
      if (selectedAnswer[question.id] == question.correctOptionId) {
        score += question.points;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz attempt screen'),
      ),
    );
  }
}

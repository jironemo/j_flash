import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:j_flash/quiz_system/providers/quiz_provider.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
  }

  Padding flipFace(String text) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 300,
        width: 500,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              blurStyle: BlurStyle.outer,
              color: Colors.blueGrey,
              spreadRadius: 5,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  FlipCardController controller = FlipCardController();
  FlipCard _generateCard(front, back) {
    return FlipCard(
      rotateSide: RotateSide.left,
      axis: FlipAxis.vertical,
      controller: controller,
      frontWidget: flipFace(front),
      backWidget: flipFace(back),
      animationDuration: const Duration(milliseconds: 1000),
    );
  }

  final TextEditingController _answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isEnabled = _answerController.text.isNotEmpty;
    final int deckIndex =
        (ModalRoute.of(context)!.settings.arguments as List)[0];
    return ChangeNotifierProvider(
      create: (_) {
        QuizModel q = QuizModel.withDeck(deckIndex);
        q.loadQuestions();
        return q;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Page'),
        ),
        body: Center(
          child: Consumer<QuizModel>(
            builder: (context, quizModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _generateCard(
                      quizModel.currentQuestion, quizModel.correctAnswer),
                  const SizedBox(height: 40),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Answer',
                          ),
                          controller: _answerController,
                          onChanged: (value) => setState(
                            () {
                              isEnabled = value.isNotEmpty;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled
                              ? () {
                                  controller.flipcard().then((_) {
                                    quizModel
                                        .submitAnswer(_answerController.text);
                                    _answerController.clear();
                                    quizModel.nextQuestion();
                                    if (quizModel.endOfQuestions) {
                                      if (context.mounted) {
                                        Navigator.of(context).popUntil(
                                          ModalRoute.withName('/'),
                                        );
                                        if (context.mounted) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text('Quiz Over'),
                                                  content: Text(
                                                      'Your score is ${quizModel.score}/${quizModel.totalQuestions}'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    } else {
                                      Timer(const Duration(seconds: 1), () {
                                        controller.flipcard().then(
                                            (_) => quizModel.nextAnswer());
                                      }).tick;
                                    }
                                  });
                                }
                              : null,
                          child: const Text("Next"),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

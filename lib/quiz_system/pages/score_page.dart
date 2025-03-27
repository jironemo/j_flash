import 'package:flutter/material.dart';
import 'package:j_flash/quiz_system/providers/quiz_provider.dart';
import 'package:provider/provider.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as List;
    final quizModel = args[0] as QuizModel;
    return ChangeNotifierProvider(
      create: (_) => quizModel,
      child: Consumer<QuizModel>(
        builder: (context, quizModel, child) {
          return Scaffold(
            body: Center(
              child: Text("Your score is: ${quizModel.score}"),
            ),
          );
        },
      ),
    );
  }
}

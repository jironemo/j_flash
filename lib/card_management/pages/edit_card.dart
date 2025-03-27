import 'package:flutter/material.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/repository/card_repository.dart';

class EditCardPage extends StatefulWidget {
  const EditCardPage({super.key});

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  CardEntityRepository repo = CardEntityRepository();
  TextEditingController frontController = TextEditingController();
  TextEditingController backController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int currrentCard = (ModalRoute.of(context)?.settings.arguments as List)[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Card"),
      ),
      body: Form(
        child: FutureBuilder(
          future: repo.fetchCard(currrentCard),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              CardEntity card = snapshot.data!;
              frontController.text = card.front;
              backController.text = card.back;
              return Column(
                children: [
                  TextFormField(
                    controller: frontController,
                    decoration: const InputDecoration(
                      labelText: 'Front (Question)',
                    ),
                  ),
                  TextFormField(
                    controller: backController,
                    decoration: const InputDecoration(
                      labelText: 'Back (Answer)',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      card.front = frontController.text;
                      card.back = backController.text;
                      if (await repo.updateCard(card) == true &&
                          context.mounted) {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card Updated'),
                          ),
                        );
                      } else {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card Update Failed'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool g = await repo.deleteCard(currrentCard);
                      if (g == true && context.mounted) {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card Deleted'),
                          ),
                        );
                        Navigator.pop(context);
                      } else if (context.mounted) {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card Delete Failed'),
                          ),
                        );
                      }
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

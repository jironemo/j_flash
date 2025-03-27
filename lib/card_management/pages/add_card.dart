import 'package:flutter/material.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/models/deck.dart';
import 'package:j_flash/repository/card_repository.dart';
import 'package:j_flash/repository/deck_repository.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  int deckId = 0;
  CardEntityRepository cardEntityRepository = CardEntityRepository();
  TextEditingController frontController = TextEditingController();
  TextEditingController backController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Card To Deck"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
              FutureBuilder<List<Deck>>(
                future: DeckRepository().fetchDecks(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Deck>> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Select Deck',
                    ),
                    items: snapshot.data!.map((Deck cardList) {
                      return DropdownMenuItem<int>(
                        value: cardList.id,
                        child: Text(cardList.name),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        deckId = newValue!;
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  int success = await cardEntityRepository.insertCard(
                    CardEntity(
                        front: frontController.text,
                        back: backController.text,
                        deckId: deckId),
                  );
                  if (success != 0 && context.mounted) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Card added successfully'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                },
                                child: const Text('OK'),
                              )
                            ],
                          );
                        });
                  } // Add card to database
                },
                child: const Text('Add Card'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

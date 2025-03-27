import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:j_flash/components/navigation_drawer.dart';
import 'package:j_flash/main_functionaltities/provider/deck_content_provider.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/repository/card_repository.dart';
import 'package:provider/provider.dart';

class CardViewPage extends StatefulWidget {
  const CardViewPage({super.key, required this.title});

  final String title;

  @override
  State<CardViewPage> createState() => _CardViewPageState();
}

class _CardViewPageState extends State<CardViewPage> {
  var controller = FlipCardController();

  CardEntityRepository db = CardEntityRepository();

  Padding flipFace(String text) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 300,
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

  Widget _generateCards(List<CardEntity> cards) {
    return SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return FlipCard(
              onTapFlipping: true,
              rotateSide: RotateSide.left,
              axis: FlipAxis.vertical,
              controller: controller,
              frontWidget: flipFace(cards[index].front),
              backWidget: flipFace(cards[index].back),
              animationDuration: const Duration(milliseconds: 500),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    var args = (ModalRoute.of(context)?.settings.arguments as List);

    return Scaffold(
        drawer: const CustomNavigationDrawer(
          selectedIndex: 0,
        ),
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            title: Text(args[0].toString())),
        body: ChangeNotifierProvider(
          create: (_) => DeckContentProvider(args[0]),
          child: Consumer<DeckContentProvider>(
            builder: (context, deckContentProvider, child) {
              return _generateCards(deckContentProvider.cards);
            },
          ),
        ));
  }
}

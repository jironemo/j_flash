import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:j_flash/components/navigation_drawer.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/util/db.dart';

class CardViewPage extends StatefulWidget {
  const CardViewPage({super.key, required this.title});

  final String title;

  @override
  State<CardViewPage> createState() => _CardViewPageState();
}

class _CardViewPageState extends State<CardViewPage> {
  var controller = FlipCardController();

  DatabaseHelper db = DatabaseHelper.instance;

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
              blurStyle: BlurStyle.solid,
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

  Future<Widget> _generateCard(int cardId) async {
    return FutureBuilder(
        future: db.fetchCard(cardId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final card = snapshot.data as CardEntity;
            return FlipCard(
              onTapFlipping: true,
              rotateSide: RotateSide.left,
              axis: FlipAxis.vertical,
              controller: controller,
              frontWidget: flipFace(card.front),
              backWidget: flipFace(card.back),
              animationDuration: const Duration(milliseconds: 500),
            );
          } else {
            return const Text("No data available");
          }
        });
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: FutureBuilder<Widget>(
          future: _generateCard(args[0] as int),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [snapshot.data!],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

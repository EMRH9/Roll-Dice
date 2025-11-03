import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var num = 1;
  final player = AudioPlayer();

  void changeNumber() async {
    var random = Random();
    int randomNumber = random.nextInt(6) + 1;
    setState(() {
      num = randomNumber;
    });
    await player.play(AssetSource('sounds/sound.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple,
              Color.fromARGB(255, 71, 2, 83),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/dice-$num.png",
                height: 230,
                width: 230,
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  changeNumber();
                },
                child: const Text(
                  "Roll Dice",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

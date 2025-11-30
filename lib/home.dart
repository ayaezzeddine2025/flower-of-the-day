import 'package:flutter/material.dart';

import 'flower_data.dart';

import 'dart:math';

class FlowerHome extends StatefulWidget {

  const FlowerHome({super.key});

  @override

  State<FlowerHome> createState() => _FlowerHomeState();

}

class _FlowerHomeState extends State<FlowerHome> {

  int currentIndex = 0;

  void nextFlower() {

    setState(() {

      currentIndex = Random().nextInt(flowers.length);

    });

  }

  void showFlowerInfo(String flowerName, String flowerInfo) {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text(flowerName),

          content: Text(flowerInfo),

          actions: [

            TextButton(

                onPressed: () => Navigator.pop(context),

                child: const Text("Close"))

          ],

        );

      },

    );

  }

  @override

  Widget build(BuildContext context) {

    final flower = flowers[currentIndex];



    return Scaffold(

      appBar: AppBar(

        title: const Text('Flower of the Day'),

        centerTitle: true,

      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(24.0),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset(flower.imagePath, width: 350, height: 250),



              const SizedBox(height: 20),



              // Row: Flower Name + Info Icon

              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(

                    flower.name,

                    style: const TextStyle(

                        fontSize: 28, fontWeight: FontWeight.bold),

                  ),

                  const SizedBox(width: 10),



                  // INFO BUTTON

                  IconButton(

                    icon: const Icon(Icons.info_outline, size: 28),

                    onPressed: () {

                      showFlowerInfo(

                        flower.name,

                        flower.description, // <-- your extra info here

                      );

                    },

                  ),

                ],

              ),



              const SizedBox(height: 15),



              Text(

                '\"${flower.quote}\"',

                textAlign: TextAlign.center,

                style: const TextStyle(

                    fontSize: 20, fontStyle: FontStyle.italic),

              ),



              const SizedBox(height: 30),



              ElevatedButton(

                onPressed: nextFlower,

                child: const Text('Next Flower & Quote',

                    style: TextStyle(fontSize: 18)),

              ),

            ],

          ),

        ),

      ),

    );

  }

}
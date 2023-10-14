import 'package:example/bunny.dart';
import 'package:example/cube.dart';
import 'package:example/planet.dart';
import 'package:example/ruby.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cube',
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8)),
            child: const Text("Change Object"),
          ),
          onTap: () {
            setState(() {
              if (index == 3) {
                index = 0;
              } else {
                index++;
              }
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: IndexedStack(
          index: index,
          children: const [
            Planet(),
            CubeExample(),
            Bunny(),
            Ruby(),
          ],
        ),
      ),
    );
  }
}

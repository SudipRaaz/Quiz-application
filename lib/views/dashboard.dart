import 'package:flutter/material.dart';
import 'package:smile/views/quiz.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 245, 212, 94),
          child: Column(
            children: [
              Container(),
              const Padding(
                padding: EdgeInsets.all(100.0),
                child: Text("hello world"),
              ),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Quiz()));
                  },
                  child: const Text("Play game")),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Leadership Board")),
              ElevatedButton(onPressed: () {}, child: const Text("Help")),
            ],
          )),
    );
  }
}

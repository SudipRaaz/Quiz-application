import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smile/services/remote.dart';
import 'package:smile/views/Answer_tile.dart';
import '../models/Question.dart';
import 'package:smile/models/global.dart' as global;

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _HomeState();
}

class _HomeState extends State<Quiz> {
  Question? quest;
  var isLoaded = false;
  bool answerSelected = false;
  List<int> answerOptions = <int>[];
  int questionIndex = 0;
  int totalScore = 0;
  bool endOfQuiz = false;

  @override
  void initState() {
    super.initState();
    getQuestion();
  }

  void questionAnswered(int correctAnswer) {
    setState(() {
      answerSelected = true;
    });

    if (correctAnswer == global.selectedAnswer) {
      totalScore++;
    }
    print("ans selected ::: ${global.selectedAnswer}");
  }

  getQuestion() async {
    quest = await Remote().getQuestion();
    if (quest != null) {
      setState(() {
        isLoaded = true;
        answerOptions = [];
        answerOptions.add(quest!.solution);
        var random = Random();

        for (int i = 0; i < 2; i++) {
          int randomNum = random.nextInt(10);
          if (i == 0) {
            if (answerOptions[i] != randomNum) {
              answerOptions.add(randomNum);
            } else if (answerOptions[i] == randomNum) {
              randomNum = random.nextInt(10);
              answerOptions.add(randomNum);
            }
          } else if (i == 1) {
            if (answerOptions[0] != randomNum &&
                answerOptions[1] != randomNum) {
              answerOptions.add(randomNum);
            } else if (answerOptions[0] == randomNum ||
                answerOptions[1] == randomNum) {
              randomNum = random.nextInt(10);
              answerOptions.add(randomNum);
            }
          }
        }
        print("the list is $answerOptions");
        print("solution = ${quest?.solution}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
        leading: Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 3),
          child: Text(
            "${questionIndex} / 10 ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.black38,
                height: 300,
                width: double.infinity,
                child: QuestionPack(quest: quest),
              ),
            ),
            ...List.generate(
                answerOptions.length,
                (index) => AnswerTile(
                      answers: answerOptions[index],
                      answerColor: answerSelected
                          ? (answerOptions[index] == quest?.solution)
                              ? Colors.green
                              : Colors.red
                          : null,
                      answerTap: () {
                        questionAnswered(quest!.solution);
                      },
                    )),
            // Expanded(
            //   flex: 8,
            //   child: ListView.builder(
            //     itemBuilder: ((context, index) {
            //       return AnswerTile(
            //         answers: answerOptions[index],
            //         answerColor: answerSelected ? Colors.green : null,
            //         answerTap: () {
            //           questionAnswered(quest!.solution);
            //         },
            //       );
            //     }),
            //     itemCount: 3,
            //   ),
            // ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        getQuestion();
                      },
                      child: const Text("Next"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuestionPack extends StatelessWidget {
  const QuestionPack({
    super.key,
    required this.quest,
  });

  final Question? quest;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("${quest?.question}")),
              border: Border.all(color: Colors.black38)),
        ),
        // Container(
        //   height: 70,
        //   decoration: BoxDecoration(
        //       color: Colors.white, borderRadius: BorderRadius.circular(16)),
        //   child: Row(
        //     children: [
        //       Text(
        //         "${quest?.solution}",
        //         style: TextStyle(fontSize: 20),
        //       ),
        //       Chip(label: Text("${quest?.solution}"))
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smile/models/global.dart' as global;

class AnswerTile extends StatelessWidget {
  AnswerTile(
      {this.answerColor,
      required this.answers,
      required this.answerTap,
      super.key});

  int answers;
  final Color? answerColor;
  final Function answerTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        answerTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.black26, borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                ),
                child: Text(
                  "Option 1: ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                "${answers}",
                style: TextStyle(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.check_circle,
                  color: answerColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

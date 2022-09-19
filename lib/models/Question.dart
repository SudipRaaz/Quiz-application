import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    required this.question,
    required this.solution,
  });

  String question;
  int solution;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        solution: json["solution"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "solution": solution,
      };
}

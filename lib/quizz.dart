import 'package:structuring_app/qustion.dart';

class Quizz {
  int qNum = 0;
  // ignore: prefer_final_fields, unused_field
  List<Question> _question = [
    Question(
        "Debugging is the process of finding and removing errors in a program. In this process, the program is thoroughly checked for errors. Then errors are pointed out and debugged",
        false),
    Question(
        "There are three types of errors which can occur during the execution of a program. Syntax Errors, Runtime Errors and Logical errors",
        true),
    Question(
        "An algorithm is a finite set of steps which, if followed, accomplish a particular task. An algorithm must be clear, finite and effective.",
        true)
  ];

  void nextQuestion() {
    qNum++;
  }

  String getQuestion(int qNum) {
    return _question[qNum].question;
  }

  bool getSolution(int qNum) {
    return _question[qNum].solution;
  }

  bool isFinish() {
    if (qNum > _question.length - 1) {
      print(qNum);
      return true;
    } else {
      print(qNum);
      return false;
    }
  }

  void reset() {
    qNum = 0;
  }
}

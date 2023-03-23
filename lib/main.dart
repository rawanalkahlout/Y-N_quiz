import 'package:flutter/material.dart';
import 'package:structuring_app/quizz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> scoreKeeper = [];
  bool isEnabled = true;
  checkAnswer(bool solution) async {
    setState(() {
      bool correctQ = quizz.getSolution(quizz.qNum);
      quizz.nextQuestion();
      if (solution == correctQ) {
        print('sccuse');

        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });

    if (quizz.isFinish()) {
      isEnabled = false;
      quizz.reset();
      await Future.delayed(Duration(microseconds: 100000));
      Alert(
        context: context,
        type: AlertType.error,
        title: "RFLUTTER ALERT",
        desc: "Flutter is more awesome with RFlutter Alert.",
        buttons: [
          DialogButton(
            // ignore: sort_child_properties_last
            child: const Text(
              "finish",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      setState(() {
        scoreKeeper = [];
      });
    }
  }

  Quizz quizz = new Quizz();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.amber],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Center(
                  child: Text(
                    quizz.getQuestion(quizz.qNum),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (isEnabled
                            ? () {
                                checkAnswer(true);
                              }
                            : null),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(50)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 20))),
                        child: Text('TRUE'),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (isEnabled
                            ? () {
                                checkAnswer(false);
                              }
                            : null),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(50)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 20))),
                        child: Text('FALSE'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: scoreKeeper,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_codigo_quizapp/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {



  List<Widget> scoreKeeper = [];

  QuizBrain quizBrain = QuizBrain();


  checkAnswer(bool userAnswer){

    if(quizBrain.isFinished() == true){

      Alert(
        context: context,
        type: AlertType.success,
        title: "QuizApp",
        desc: "El quiz ha finalizado",
        buttons: [
          DialogButton(
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      quizBrain.restart();
      scoreKeeper.clear();
      setState(() {

      });

    }else{

      bool correctAnswer = quizBrain.getQuestionAnswer();
      if(correctAnswer == userAnswer){
        scoreKeeper.add(Icon(Icons.check, color: Colors.greenAccent,),);
      }else{
        scoreKeeper.add(Icon(Icons.close, color: Colors.redAccent,),);
      }
      quizBrain.nextQuestion();

      setState(() {

      });
    }


  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff2b2d42),
      appBar: AppBar(
        backgroundColor: Color(0xff2b2d42),
        title: Text("QuizApp"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  checkAnswer(true);
                },
                child: Text(
                  "Verdadero",
                ),
                color: Colors.greenAccent,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  checkAnswer(false);
                },
                child: Text(
                  "Falso",
                ),
                color: Colors.redAccent,
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}

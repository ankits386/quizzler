import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text('Quizzler'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Quizzler(),
        )),
      ),
    ));

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  List<Icon> _resultIcons = [];
  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestion(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            )),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  evaluateAnswer(true, context);
                },
                child: Text(
                  'TRUE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20.0,
                  ),
                ),
                color: Colors.green,
              )),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  evaluateAnswer(false, context);
                },
                child: Text(
                  'FALSE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20.0,
                  ),
                ),
                color: Colors.red,
              )),
        ),
        Row(
          children: _resultIcons,
        )
      ],
    );
  }

  void evaluateAnswer(bool userAnswer, BuildContext context) {
    setState(() {
      if (userAnswer == quizBrain.getAnswer())
        _resultIcons.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      else
        _resultIcons.add(Icon(
          Icons.clear,
          color: Colors.red,
        ));
      if (quizBrain.isReachEnd()) {
        quizBrain.resetQuiz();
        _resultIcons = [];
        showAlert();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  void showAlert() {
    Alert(
      context: context,
      title: "Finished!!",
      desc: "You've reached the end of the Quiz",
      style: AlertStyle(
        animationType: AnimationType.fromTop,
        backgroundColor: Colors.grey.shade800,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey.shade900,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.greenAccent,
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.green,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }
}

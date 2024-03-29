import 'package:flutter/material.dart';
import 'package:instabug_flutter/Instabug.dart';
import 'dart:async';
// import 'dart:io' show Platform;
import 'package:instabug_flutter/BugReporting.dart';
import 'package:instabug_flutter/Surveys.dart';
import 'package:instabug_flutter/FeatureRequests.dart';
import 'package:instabug_flutter/CrashReporting.dart';

class Report extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air bus Report',
      color: Color(0xFF083386),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Air Reporting'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void show() {
    Instabug.show();
  }

  void sendBugReport() {
    BugReporting.show(ReportType.bug, [InvocationOption.emailFieldOptional]);
  }

  void sendFeedback() {
    BugReporting.show(
        ReportType.feedback, [InvocationOption.emailFieldOptional]);
  }

  void askQuestion() {
    BugReporting.show(
        ReportType.question, [InvocationOption.emailFieldOptional]);
  }

  void showNpsSurvey() {
    Surveys.showSurvey('pcV_mE2ttqHxT1iqvBxL0w');
  }

  void showMultipleQuestionSurvey() {
    Surveys.showSurvey('ZAKSlVz98QdPyOx1wIt8BA');
  }

  void showFeatureRequests() {
    FeatureRequests.show();
  }

  void setInvocationEvent(InvocationEvent invocationEvent) {
    BugReporting.setInvocationEvents([invocationEvent]);
  }

  void setPrimaryColor(Color c) {
    Instabug.setPrimaryColor(c);
  }

  void setColorTheme(ColorTheme colorTheme) {
    Instabug.setColorTheme(colorTheme);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF083386),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: Text(
                  'Welcome to Air Reporting System',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                // height: double.infinity,
                child: RaisedButton(
                    onPressed: show,
                    textColor: Colors.white,
                    child: Text('Invoke'),
                    color: Color(0xFF083386)),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                // height: double.infinity,
                child: RaisedButton(
                    onPressed: sendBugReport,
                    textColor: Colors.white,
                    child: Text('Send Bug Report'),
                    color: Color(0xFF083386)),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                // height: double.infinity,
                child: RaisedButton(
                    onPressed: showFeatureRequests,
                    textColor: Colors.white,
                    child: Text('Show Feature Requests'),
                    color: Color(0xFF083386)),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                // height: double.infinity,
                child: RaisedButton(
                    onPressed: askQuestion,
                    textColor: Colors.white,
                    child: Text('Ask a Question'),
                    color: Color(0xFF083386)),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                // height: double.infinity,
                child: RaisedButton(
                    onPressed: sendFeedback,
                    textColor: Colors.white,
                    child: Text('Send Feedback'),
                    color: Color(0xFF083386)),
              ),
            ],
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

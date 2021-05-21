import 'dart:async';
import 'dart:developer';
import 'ss.dart';
import 'package:bubble_overlay/bubble_overlay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'live.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:animated_float_action_button/animated_floating_action_button.dart';

import 'usage.dart';
import 'report.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';

import 'package:instabug_flutter/Instabug.dart';
import 'dart:async';
// import 'dart:io' show Platform;
import 'package:instabug_flutter/BugReporting.dart';
import 'package:instabug_flutter/Surveys.dart';
import 'package:instabug_flutter/FeatureRequests.dart';
import 'package:instabug_flutter/CrashReporting.dart';

Future<void> main() async {
  runApp(MaterialApp(
    title: 'Konnex',
    theme: new ThemeData(
      primaryColor: Color(0xFF083386), // Your app THEME-COLOR
    ),
    debugShowCheckedModeBanner: false,
    home: Home(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new Home(),
    },
  ));
}

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final BubbleOverlay bubbleOverlay = BubbleOverlay();
  final GlobalKey<AnimatedFloatingActionButtonState> fabKey = GlobalKey();

  bool alternateColor = false;
  bool _isShowDial = false;

  void setMiddleTextCounter() {
    int time = 0;
    if (bubbleOverlay.isOpen)
      bubbleOverlay
          .setCallback(Timer.periodic(Duration(milliseconds: 500), (timer) {
        time++;
        if (bubbleOverlay.isOpen) bubbleOverlay.updateMiddleText('$time');
        log('callback');
      }));
  }

  void setBottomTextHelloWorld() {
    if (bubbleOverlay.isOpen) {
      bubbleOverlay.removeCallback();
      bubbleOverlay.updateBottomText('Hello World');
    }
  }

  void closeBubble() {
    if (bubbleOverlay.isOpen) {
      bubbleOverlay.closeBubble();
    }
  }

  void closeVideoBubble() {
    if (bubbleOverlay.isVideoOpen) {
      bubbleOverlay.closeVideoBubble();
    }
  }

  void updateTextAndBgColor() {
    if (bubbleOverlay.isOpen) {
      bubbleOverlay.removeCallback();
      String textColor = alternateColor ? '#000000' : '#ffffff';
      String bgColor = alternateColor ? '#ffffff' : '#000000';
      bubbleOverlay.updateMiddleTextColor(textColor);
      bubbleOverlay.updateTopTextColor(textColor);
      bubbleOverlay.updateBottomTextColor(textColor);
      bubbleOverlay.updateBackgroundColor(bgColor);
      alternateColor = !alternateColor;
    }
  }

  void setTopText() {
    if (bubbleOverlay.isOpen) {
      bubbleOverlay.removeCallback();
      bubbleOverlay.updateTopText('User');
    }
  }

  void setTopIcon() async {
    String url =
        'https://meterpreter.org/wp-content/uploads/2018/09/flutter.png';
    http.get(Uri.parse(url)).then(
        (response) => bubbleOverlay.updateTopIconWithBytes(response.bodyBytes));
  }

  void setBottomIcon() async {
    String url =
        'https://github.githubassets.com/images/modules/open_graph/github-mark.png';
    http.get(Uri.parse(url)).then((response) =>
        bubbleOverlay.updateBottomIconWithBytes(response.bodyBytes));
  }

  void openBubbleVideo() async {
    String url =
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    bubbleOverlay.openVideoBubble(url,
        startTimeInMilliseconds: 15000, controlsType: ControlsType.MINIMAL);
  }

  void openBubbleVideoAssets() async {
    String asset;
    // asset = 'assets/video.mp4';
    asset = 'assets/1bitadder.png';
    bubbleOverlay.openVideoBubbleAsset(asset,
        controlsType: ControlsType.MINIMAL);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Konnex',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF083386),
          toolbarHeight: 66,
        ),
        drawer: Container(
          color: Color(0xFF083386),
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  arrowColor: Color(0xFF083386),
                  accountName: Text("User"),
                  accountEmail: Text("User@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      "U",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text("Contact Us"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        // body: _getBodyWidget(),
        //floatingActionButton: _getFloatingActionButton(),
        //body: Container(),
        floatingActionButton: DraggableFab(
            child: AnimatedFloatingActionButton(
                colorStartAnimation: Color(0xFF083386),
                key: fabKey,
                fabButtons: <Widget>[
                  chat(),
                  live(),
                  inbox(),
                  report(),
                ],
                colorEndAnimation: Colors.red,
                animatedIconData: AnimatedIcons.menu_close //To principal button
                )),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FlatButton(
                  color: Color(0xFF083386),
                  child: Text('Open Bubble',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => bubbleOverlay.openBubble()),
              FlatButton(
                onPressed: setTopText,
                color: Color(0xFF083386),
                child: Text('Set Bubble Top Text',
                    style: TextStyle(color: Colors.white)),
              ),
              FlatButton(
                color: Color(0xFF083386),
                onPressed: setMiddleTextCounter,
                child: Text('Set Middle Text Counter',
                    style: TextStyle(color: Colors.white)),
              ),
              FlatButton(
                color: Color(0xFF083386),
                child: Text('Chat bot', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
              FlatButton(
                color: Color(0xFF083386),
                child:
                    Text('Live support', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApps()),
                  );
                },
              ),
              FlatButton(
                color: Color(0xFF083386),
                child: Text('App Usage', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Usage()),
                  );
                },
              ),
              FlatButton(
                color: Color(0xFF083386),
                child: Text('Report', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Report()),
                  );
                },
              ),
              FlatButton(
                color: Color(0xFF083386),
                onPressed: closeBubble,
                child:
                    Text('Close Bubble', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );

  Widget chat() {
    return FloatActionButtonText(
      onPressed: () {
        fabKey.currentState.animate();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
      icon: Icons.chat,
      text: "chat bot",
      textLeft: -150,
    );
  }

  Widget live() {
    return FloatActionButtonText(
      onPressed: () {
        fabKey.currentState.animate();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApps()),
        );
      },
      icon: Icons.live_help,
      textLeft: -150,
      text: "Live Support",
    );
  }

  Widget inbox() {
    return FloatActionButtonText(
      onPressed: () {
        fabKey.currentState.animate();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Usage()),
        );
      },
      icon: Icons.data_usage,
      textLeft: -150,
      text: "Application Usage",
    );
  }

  Widget report() {
    return FloatActionButtonText(
      onPressed: () {
        fabKey.currentState.animate();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Report()),
        );
      },
      icon: Icons.report,
      textLeft: -150,
      text: "Bug Reporting",
    );
  }

  Widget _getFloatingActionButton() {
    return DraggableFab(
      child: SpeedDialMenuButton(
        //if needed to close the menu after clicking sub-FAB
        isShowSpeedDial: _isShowDial,
        //manually open or close menu
        updateSpeedDialStatus: (isShow) {
          //return any open or close change within the widget
          this._isShowDial = isShow;
        },
        //general init
        isMainFABMini: false,
        mainMenuFloatingActionButton: MainMenuFloatingActionButton(
            mini: false,
            child: Icon(Icons.menu),
            onPressed: () {},
            closeMenuChild: Icon(Icons.close),
            closeMenuForegroundColor: Colors.white,
            closeMenuBackgroundColor: Colors.red),
        floatingActionButtonWidgetChildren: <FloatingActionButton>[
          FloatingActionButton(
            mini: false,
            isExtended: true,
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[Icon(Icons.chat, size: 25), Text("chat bot")],
            ),
            onPressed: () {
              //if need to close menu after click
              _isShowDial = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            backgroundColor: Colors.pink,
          ),
          FloatingActionButton(
            mini: false,
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[Icon(Icons.report, size: 25), Text("Report")],
            ),
            onPressed: () {
              //if need to toggle menu after click
              _isShowDial = !_isShowDial;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Report()),
              );
            },
            backgroundColor: Colors.orange,
          ),
          FloatingActionButton(
            mini: false,
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(Icons.live_help, size: 25),
                Text("Live support")
              ],
            ),
            onPressed: () {
              //if need to toggle menu after click
              _isShowDial = !_isShowDial;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApps()),
              );
            },
            backgroundColor: Colors.orange,
          ),
          FloatingActionButton(
            mini: false,
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(Icons.data_usage, size: 25),
                Text("Usage")
              ],
            ),
            onPressed: () {
              //if no need to change the menu status
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Usage()),
              );
            },
            backgroundColor: Colors.deepPurple,
          ),
        ],
        isSpeedDialFABsMini: true,
        paddingBtwSpeedDialButton: 30.0,
      ),
    );
  }

  Widget _getBodyWidget() {
    return Container();
  }
}

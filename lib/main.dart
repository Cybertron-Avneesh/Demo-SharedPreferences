import 'package:demo/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<int> counter;

  @override
  void initState() {
    super.initState();
    counter = SharedPreferencesHelper.getIntegerValue('counter');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo Shared_Preferences'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.restore), onPressed: (){
              SharedPreferencesHelper.clearPreferences();
              setState(() {
                      counter =
                          SharedPreferencesHelper.getIntegerValue('counter');
                    });
            })
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                            'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}');
                      }
                    },
                    future: counter),
                    SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () async {
                    // fetches current value of counter
                    int lastValue =
                        await SharedPreferencesHelper.getIntegerValue(
                            'counter');

                    // increaments latest value by 1
                    lastValue++;

                    // pushes updated value of counter to SharedPreferences
                    await SharedPreferencesHelper.setIntegerValue(
                        'counter', lastValue);

                    // updates State of App
                    setState(() {
                      counter =
                          SharedPreferencesHelper.getIntegerValue('counter');
                    });
                  },
                  child: Icon(Icons.touch_app),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
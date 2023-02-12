import 'package:flutter/material.dart';
import 'package:tiempo/settings.dart';
import 'package:tiempo/timer.dart';
import 'package:tiempo/timermodel.dart';
import 'package:tiempo/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  TimerHomePage() {
    timer.startWork();
  }

  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Timer"),
          // popup menu button
          actions: [
            PopupMenuButton<String>(
                itemBuilder: (context) => [
                      // popupmenu item 1
                      PopupMenuItem(
                        value: "Settings",
                        // row has two child icon and text.
                        child: Row(
                          children: [
                            Icon(Icons.star),
                            SizedBox(
                              // sized box with width 10
                              width: 10,
                            ),
                            Text("Settings")
                          ],
                        ),
                      ),
                      // popupmenu item 2
                      PopupMenuItem(
                        value: "About",
                        // row has two child icon and text
                        child: Row(
                          children: [
                            Icon(Icons.chrome_reader_mode),
                            SizedBox(
                              // sized box with width 10
                              width: 10,
                            ),
                            Text("About")
                          ],
                        ),
                      ),
                    ],
                offset: Offset(0, 100),
                color: Colors.grey,
                elevation: 2,
                onSelected: (s) {
                  if (s == 'Settings') {
                    goToSettings(context);
                  }
                }),
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    text: "Work",
                    onPressed: () => timer.startWork(),
                    size: 0,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff607D8B),
                    text: "Short Break",
                    onPressed: () => timer.startBreak(true),
                    size: 0,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff455A64),
                    text: "Long Break",
                    onPressed: () => timer.startBreak(false),
                    size: 0,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          initialData: '00:00',
                          stream: timer.stream(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            TimerModel timer = (snapshot.data == '00:00')
                                ? TimerModel('00:00', 1)
                                : snapshot.data;
                            return Expanded(
                                child: CircularPercentIndicator(
                              radius: availableWidth / 7,
                              lineWidth: 10.0,
                              percent: timer.percent,
                              center: Text(timer.time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              progressColor: Color(0xff009688),
                            ));
                          })),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    onPressed: () => timer.stopTimer(),
                    size: 0,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    text: 'Restart',
                    onPressed: () => timer.startTimer(),
                    size: 0,
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              )
            ],
          );
        }));
  }
}

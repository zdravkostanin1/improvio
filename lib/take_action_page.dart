import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:improvio/choose_areas_page.dart';

class TakeActionPage extends StatefulWidget {
  const TakeActionPage({Key? key}) : super(key: key);

  @override
  State<TakeActionPage> createState() => _TakeActionPageState();
}

class _TakeActionPageState extends State<TakeActionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take Action Screen',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          // child is wrapped with a Builder because I got the error: "The context used to push or pop routes from the Navigator must be that of a widget that is a descendant of a Navigator widget."
          // wrapping it inside a Builder widget fixes that.
          // FOR REFERENCE ABOUT BUILDER PROBLEM: https://stackoverflow.com/questions/50124355/flutter-navigator-not-working
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // maybe use CircleAvatar
                  const DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Image(
                      image: AssetImage('assets/goal.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextAnimator(
                      'Improvio helps you take the first step to improvement and guides you along the way to reach your goals & dreams',
                      initialDelay: const Duration(seconds: 2),
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Asd',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      atRestEffect: WidgetRestingEffects.none(),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 340,
                    child: DelayedDisplay(
                      delay: const Duration(seconds: 8),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChooseAreasPage()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xffffff00),
                          ),
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

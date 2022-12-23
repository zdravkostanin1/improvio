import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:delayed_display/delayed_display.dart';
import 'sign_up.dart';

class SplashScreen3 extends StatefulWidget {
  const SplashScreen3({Key? key}) : super(key: key);

  @override
  State<SplashScreen3> createState() => _SplashScreen3State();
}

class _SplashScreen3State extends State<SplashScreen3> {
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
                      image: AssetImage('assets/level-up1.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextAnimator(
                      'The BEST of all - Improvio offers you a way to conquer your goals by MAKING your life like a video-game, levelling up like in a video game',
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
                      delay: const Duration(seconds: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SignUp()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xffffff00),
                          ),
                        ),
                        child: const Text(
                          'START HERE',
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

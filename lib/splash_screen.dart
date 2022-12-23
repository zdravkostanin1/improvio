import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'take_action_page.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          // child is wrapped with a Builder because I got the error: "The context used to push or pop routes from the Navigator must be that of a widget that is a descendant of a Navigator widget."
          // wrapping it inside a Builder widget fixes that.
          // FOR REFERENCE ABOUT BUILDER PROBLEM: https://stackoverflow.com/questions/50124355/flutter-navigator-not-working
          child: Builder(
            builder: (BuildContext context) {
              return WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(
                        duration: const Duration(seconds: 2)),
                atRestEffect: WidgetRestingEffects.swing(numberOfPlays: 1),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/test_ico.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 100,
                  height: 100,
                  // Here, I use AnimatedTextKit for the onFinished() function,
                  // because I did not find a way to transition to the next page
                  // so therefore, I used onFinished on the AnimatedTextKit animation..
                  child: AnimatedTextKit(
                    animatedTexts: [
                          TypewriterAnimatedText(
                            '',
                          ),
                    ],
                    onFinished: () {
                      // Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TakeActionPage()));

                    },
                  ),
                  // color: Colors.blue,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

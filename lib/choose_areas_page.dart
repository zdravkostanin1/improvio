import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:delayed_display/delayed_display.dart';
import 'splash_screen_page_3.dart';

class ChooseAreasPage extends StatefulWidget {
  const ChooseAreasPage({Key? key}) : super(key: key);

  @override
  State<ChooseAreasPage> createState() => _ChooseAreasPageState();
}

class _ChooseAreasPageState extends State<ChooseAreasPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choose Areas Screen',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // maybe use CircleAvatar
              const DelayedDisplay(
                delay: Duration(seconds: 1),
                child: Image(
                  image: AssetImage('assets/target.png'),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 300,
                child: TextAnimator(
                  'Through quests, through challenges, and through massive action taking + habit tracking, you\'ll reach your goals & wildest of dreams',
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
                  delay: const Duration(seconds: 9),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen3()));
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
          ),
        ),
      ),
    );
  }
}

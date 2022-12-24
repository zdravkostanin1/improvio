import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void signUserOut() async {
  await FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.rectangle,
          snakeViewColor: Colors.black,
          // shape: ShapeBorder(),
          unselectedItemColor: Colors.black,
          onTap: (int i) {},
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'challenges'),
          ],
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0B0A0A),
        body: Builder(builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    signUserOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    'Sign OUT',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                // SafeArea(
                //   child: CustomNavigationBar(
                //     onTap: (int s) {},
                //     items: [
                //       CustomNavigationBarItem(
                //         icon: const Icon(Icons.settings),
                //       ),
                //       CustomNavigationBarItem(
                //         icon: const Icon(Icons.calendar_month),
                //       ),
                //       CustomNavigationBarItem(
                //         icon: const Icon(Icons.add_chart_sharp),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

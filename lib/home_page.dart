import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'challenges_page.dart';
import 'sign_up.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void signUserOut() async {
  await FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void switchNavBar(int screen) {
    switch(screen) {
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ChallengesPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        bottomNavigationBar: Builder(
          builder: (context) {
            return CurvedNavigationBar(
              key: _bottomNavigationKey,
              backgroundColor: Colors.black,
              items: const <Widget>[
                Icon(Icons.person, size: 35),
                Icon(Icons.calendar_month, size: 35),
                Icon(Icons.track_changes, size: 35),
                Icon(Icons.settings, size: 35),
              ],
              onTap: (index) {
                // if index x is clicked - then do X
                setState(() {
                  switch(index) {
                    case 2:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChallengesPage()));
                      break;
                  }
                  // switchNavBar(index);
                });
              },
            );
          }
        ),
        // remove line below if needed.
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0B0A0A),
        body: Builder(builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(_page.toString(), textScaleFactor: 10.0),
                // ElevatedButton(
                //   child: Text('Go To Page of index 1'),
                //   onPressed: () {
                //     //Page change using state does the same as clicking index 1 navigation button
                //     final CurvedNavigationBarState? navBarState =
                //         _bottomNavigationKey.currentState;
                //     navBarState?.setPage(1);
                //   },
                // ),
                // TextButton(
                //   onPressed: () {
                //     signUserOut();
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const SignUp()));
                //   },
                //   child: const Text(
                //     'Sign OUT',
                //     style: TextStyle(
                //       fontSize: 30.0,
                //     ),
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

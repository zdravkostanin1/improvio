import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'challenges_page.dart';
import 'sign_up.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  // removed const keyword
  //const
  HomePage({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
    initialPath: '/home_page',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const Router(),
      },
    ),
  );


  @override
  State<HomePage> createState() => _HomePageState();
}

void signUserOut() async {
  await FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  // int _page = 0;
  // final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void switchNavBar(int screen) {
    // switch(screen) {
    //   case 2:
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => const ChallengesPage()));
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        bottomNavigationBar: Builder(
          builder: (context) {
            return CurvedNavigationBar(
              // key: _bottomNavigationKey,
              backgroundColor: Colors.black,
              items: const <Widget>[
                Icon(Icons.person, size: 35),
                Icon(Icons.calendar_month, size: 35),
                Icon(Icons.track_changes, size: 35),
                Icon(Icons.settings, size: 35),
              ],
              onTap: (index) {
                // TODO: Implement different pages with navigation bar
                // if index x is clicked - then do X
                setState(() {
                  // switch(index) {
                  //   case 2:
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const ChallengesPage()));
                  //     break;
                  }
                  // switchNavBar(index);
                );
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

class ALocation extends BeamLocation<BeamState> {
  ALocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
     BeamPage(
      key: const ValueKey('home_page'),
      title: 'Tab A',
      type: BeamPageType.noTransition,
      child: HomePage(),
    ),
    // if (state.uri.pathSegments.length == 2)
    //   const BeamPage(
    //     key: ValueKey('a/details'),
    //     title: 'Details A',
    //     child: DetailsScreen(label: 'A'),
    //   ),
  ];
}

class BLocation extends BeamLocation<BeamState> {
  BLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    const BeamPage(
      key: ValueKey('challenges_page'),
      title: 'Tab A',
      type: BeamPageType.noTransition,
      child: ChallengesPage(),
    ),
    // if (state.uri.pathSegments.length == 2)
    //   const BeamPage(
    //     key: ValueKey('a/details'),
    //     title: 'Details A',
    //     child: DetailsScreen(label: 'A'),
    //   ),
  ];
}


class Router extends StatefulWidget {
  const Router({Key? key}) : super(key: key);

  @override
  State<Router> createState() => _RouterState();
}

class _RouterState extends State<Router> {
  // keep track of the currently selected index
  late int _currentIndex;

  // create two nested delegates
  final _routerDelegates = [
    BeamerDelegate(
      initialPath: '/home_page',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/home_page')) {
          return ALocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/challenges_page',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/challenges_page')) {
          return BLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
  ];

  // update the _currentIndex if necessary
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    _currentIndex = uriString.contains('/home_page') ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // use Beamer widgets as children
          Beamer(
            routerDelegate: _routerDelegates[0],
          ),
          Beamer(
            routerDelegate: _routerDelegates[1],
          ),
        ],
      ),
      bottomNavigationBar: Builder(
          builder: (context) {
            return CurvedNavigationBar(
              index: _currentIndex,
              // key: _bottomNavigationKey,
              backgroundColor: Colors.black,
              items: const <Widget>[
                Icon(Icons.person, size: 35),
                Icon(Icons.calendar_month, size: 35),
                Icon(Icons.track_changes, size: 35),
                Icon(Icons.settings, size: 35),
              ],
              onTap: (index) {
                // TODO: Implement different pages with navigation bar
                // if index x is clicked - then do X
                if (index != _currentIndex) {
                  setState(() => _currentIndex = index);
                  _routerDelegates[_currentIndex].update(rebuild: false);
                }
              },
            );
          }
      ),
    );
  }
}


import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'challenges_page.dart';
import 'sign_up.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// SIGN USER OUT FROM FIREBASE ACCOUNT
void signOut() async {
  await FirebaseAuth.instance.signOut();
}

class _HomePageState extends State<HomePage> {
  final routerDelegate = BeamerDelegate(
    initialPath: '/profile_page',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const BottomNav(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}

// // PROFILE PAGE - WHICH CALLS PROFILE_PAGE.DART FILE
class PageProfile extends BeamLocation<BeamState> {
  PageProfile(super.routeInformation);

  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('profile_page'),
          title: 'Profile Page',
          type: BeamPageType.noTransition,
          child: SafeArea(child: ProfilePage()),
        ),
      ];
}

// CHALLENGES PAGE - WHICH CALLS CHALLENGES_PAGE.DART FILE
class PageChallenges extends BeamLocation<BeamState> {
  PageChallenges(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    const BeamPage(
      key: ValueKey('challenges_page'),
      title: 'Challenges Page',
      type: BeamPageType.noTransition,
      child: SafeArea(child: ChallengesPage()),
    ),
  ];
}


class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

// THE NAV BAR AND IT'S VALUES
class _BottomNavState extends State<BottomNav> {

  late int _currentIndex;

  // create two nested delegates
  final _routerDelegates = [
    BeamerDelegate(
      initialPath: '/profile_page',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/profile_page')) {
          return PageProfile(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/challenges_page',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/challenges_page')) {
          return PageChallenges(routeInformation);
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
    _currentIndex = uriString.contains('/profile_page') ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: Builder(builder: (context) {
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
              if (index != _currentIndex) {
                setState(() => _currentIndex = index);
                _routerDelegates[_currentIndex].update(rebuild: false);
              }
              setState(() {});
            },
          );
        }),
        // remove line below if needed.
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0B0A0A),
        body: SafeArea(
          child: IndexedStack(
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
        ),
      ),
    );
  }
}

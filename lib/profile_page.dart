import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:improvio/sign_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'home_page.dart';
import 'sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? currentNode = "";
  String tribeName = "";
  int userLvl = 0;
  bool userInTribe = false;

  getNodeOfUser() async {
    // We limit the node from the Root Users to the last 1 , to get the current NODE - with the CURRENT user's tribe status
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child("Users")
        .orderByKey()
        .limitToLast(1);
    dbRef.onValue.listen((event) => {
          for (var snap in event.snapshot.children)
            {
              // We call these methods to save the current key of the current USER node, and SELECT WHICH DATA WE WANT TO RETRIEVE
              getUserData(snap.key, 'tribe'),
              getUserData(snap.key, 'lvl'),
            }
        });
  }

  String? getUserData(String? node, String data) {
    currentNode = node;
    // get the specific user details with these lines:
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('Users/$currentNode/$data');
    dbRef.onValue.listen((DatabaseEvent event) {
      if (data == 'username') {
        // TODO: Implement saving the username - for later use .. IF NEEDED
      } else if (data == 'tribe') {
        // read data and call method to save it
        saveCurrentUserTribe(event.snapshot.value as String);
      } else if (data == 'lvl') {
        // read data and call method to save it
        saveCurrentUserLevel(event.snapshot.value as int);
      }
      setState(() {});
    });
    return node;
  }

  // TO SAVE THE RETRIEVED DATA FOR FIREBASE, WE USE THESE METHODS:
  saveCurrentUserTribe(String? tribe) {
    tribeName = tribe!;
    // We check if the user is in tribe - IF NOT - we do not display anything
    // in the UI down below. We base it on userInTribe variable.
    if (tribeName == 'N/A') {
      userInTribe = false;
    } else if (tribeName != 'N/A') {
      userInTribe = true;
    }
    setState(() {});
  }

  // TODO:  MAYBE ADD SOME DELAY TO BELOW STATEMENT FOR LEVEL: to fix bug of zero showing first
  saveCurrentUserLevel(int lvl) => userLvl = lvl;

  @override
  void initState() {
    // TODO: implement initState
    getNodeOfUser();
    setState(() {});
    super.initState();
  }

  static String? getUsername() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.displayName!;
  }

  String? username = getUsername();

  // late int lvlOfUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 650.0,
                  width: 550,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 170.0,
                            width: 420.0,
                            color: Colors.white,
                            // TODO: Implement USER BACKGROUND photo here:
                            child: const Center(
                              child: SizedBox(
                                height: 200.0,
                                width: 420.0,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  username!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                const SizedBox(
                                  width: 5.5,
                                ),
                                // TODO: DISPLAY LVL OF USER HERE:
                                const Text(
                                  'lvl:',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                // TODO: DISPLAY LVL OF USER IN INTEGER HERE:
                                Text(
                                  userLvl.toString(),
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            // TODO: Get Tribe of user on this Text Widget
                            child: Text(
                              tribeName,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // IF USER IS IN ANY TRIBE, WE DISPLAY THE TRIBE ROLE..
                          userInTribe
                              ? const Center(
                                  // TODO: Get Tribe ROLE of user in TRIBE use this Text Widget
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              // IF USER IS NOT IN ANY TRIBE, WE DON'T DISPLAY ANY TRIBE ROLE..
                              : Container(),
                          // WE CHANGE THE SPACING BETWEEN TRIBE ROLE AND TRIBE NAME
                          // IF THE USER IS NOT IN ANY TRIBE..
                          userInTribe
                              ? const SizedBox(
                                  height: 10.0,
                                )
                              : const SizedBox(
                                  height: 0.0,
                                ),
                          // TODO: IMPLEMENT TROPHIES HERE
                          Row(
                            // TODO: IF NO TROPHIES FUNCTIONALITY ..
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              // SizedBox(
                              //   height: 20.0,
                              //   child: Image(
                              //     image: AssetImage('assets/cup1.png'),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              //   child: Image(
                              //     image: AssetImage('assets/cup2.png'),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              //   child: Image(
                              //     image: AssetImage('assets/cup3.png'),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              //   child: Image(
                              //     image: AssetImage('assets/cup4.png'),
                              //   ),
                              // ),
                            ],
                          ),
                          // FOR HORIZONTAL LINE.. MAYBE REMOVE IT - OR DON'T..
                          const Divider(
                              height: 10.0, thickness: 6, color: Colors.white),
                          const SizedBox(
                            height: 10,
                          ),
                          const SafeArea(
                            child: Padding(
                              padding: EdgeInsets.only(right: 245.0),
                              child: Text(
                                'STATS:',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 49.0),
                              child: Row(
                                children: const [
                                  Text(
                                    'MINDFULNESS:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 169.0,
                                  ),
                                  // THE INDIVIDUAL STATS FOR EACH PART OF IMPROVEMENT STARTS HERE
                                  Text(
                                    'Lvl:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // TODO: HERE IMPLEMENT THE STATS LVL IN AN INTEGER
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '0',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                              child: LinearPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                width: 320.0,
                                lineHeight: 14.0,
                                // this is what moves our metric
                                percent: 0.0,
                                backgroundColor: Colors.white,
                                progressColor: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 49.0),
                              child: Row(
                                children: const [
                                  Text(
                                    'LEARNING:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 196.0,
                                  ),
                                  // THE INDIVIDUAL STATS FOR EACH PART OF IMPROVEMENT STARTS HERE
                                  Text(
                                    'Lvl:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // TODO: HERE IMPLEMENT THE STATS LVL IN AN INTEGER
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '0',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          // SafeArea(
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                          //     child: LinearPercentIndicator(
                          //       animation: true,
                          //       animationDuration: 1000,
                          //       width: 320.0,
                          //       lineHeight: 14.0,
                          //       // this is what moves our metric
                          //       percent: 0.0,
                          //       backgroundColor: Colors.white,
                          //       progressColor: Colors.green,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 15.0,
                          // ),
                          // const SafeArea(
                          //   child: Padding(
                          //     padding: EdgeInsets.only(right: 256.0),
                          //     child: Text(
                          //       'READ:',
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                              child: LinearPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                width: 320.0,
                                lineHeight: 14.0,
                                // this is what moves our metric
                                percent: 0.0,
                                backgroundColor: Colors.white,
                                progressColor: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 49.0),
                              child: Row(
                                children: const [
                                  Text(
                                    'EXERCISE:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 200.0,
                                  ),
                                  // THE INDIVIDUAL STATS FOR EACH PART OF IMPROVEMENT STARTS HERE
                                  Text(
                                    'Lvl:',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // TODO: HERE IMPLEMENT THE STATS LVL IN AN INTEGER
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '0',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                              child: LinearPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                width: 320.0,
                                lineHeight: 14.0,
                                // this is what moves our metric
                                percent: 0.0,
                                backgroundColor: Colors.white,
                                progressColor: Colors.green,
                              ),
                            ),
                          ),
                          // TODO: ADD ACTIVE TRIBE MEMBERS HERE: MAYBE, A LIST OR SOMETHING.. ADD IT ON A LATER STAGE. (or not)
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SafeArea(
                            child: Padding(
                              padding: EdgeInsets.only(right: 150.0),
                              child: Text(
                                'Active Tribe Members: ',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // IF USER IS NOT IN TRIBE.. WE SHOW THIS:
                          const SizedBox(
                            height: 20.0,
                          ),
                          // TODO: IF USER IS IN TRIBE - SHOW THE TRIBE MEMBERS , OTHERWISE SHOW THE TEXT - AND MAKE SEE DETAILS CLICKABLE (HALF OF TEXT), AND THIS WILL PASS YOU DETAILS ABOUT TRIBES
                          userInTribe
                              ? Container()
                              : const SafeArea(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 61),
                                    child: Text(
                                      'You aren\'t in any tribe yet. See details',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          // TODO: At a later stage, remove code for SIGN OUT BUTTON
                          // ElevatedButton(
                          //   onPressed: () {
                          //     signOut();
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //             const SignIn()));
                          //   },
                          //   child: const Text(
                          //     'SIGN OUT',
                          //     style:
                          //         TextStyle(color: Colors.red, fontSize: 30.0),
                          //   ),
                          // )
                        ],
                      ),
                      // TODO: Implement USER photo here: user imports it.
                      Positioned(
                        top: 90.0,
                        // (background container size) - (circle height / 2)
                        child: Stack(
                          // alignment: AlignmentDirectional.topCenter,
                          children: [
                            CircleAvatar(
                              // maybe change the BORDER Of THE IMAGE TO BE BLACK
                              // WE SET A DEFAULT IMAGE - BEFORE THE USER HAS SELECTED ANY IMAGE AS OF YET.
                              backgroundImage:
                                  const AssetImage('assets/defaultUserPic.png'),
                              backgroundColor: Colors.white,
                              radius: 55.0,
                              // ADD IMAGE ICON / BUTTON
                              child: Container(
                                alignment: const Alignment(0.9, 1.0),
                                child: const Icon(Icons.add, color: Colors.white, size: 33,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

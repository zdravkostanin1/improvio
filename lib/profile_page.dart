import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  getNodeOfUser() async {
    // We limit the node from the Root Users to the last 1 , to get the current NODE - with the CURRENT user's tribe status
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child("Users")
        .orderByKey()
        .limitToLast(1);
    dbRef.onValue.listen((event) => {
      for(var snap in event.snapshot.children) {
        // We call these methods to save the current key of the current USER node, and SELECT WHICH DATA WE WANT TO RETRIEVE
        getUserData(snap.key, 'tribe'),
        getUserData(snap.key, 'lvl'),
      }});
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
  saveCurrentUserTribe(String? tribe) => tribeName = tribe!;
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
                          // TODO: Make the person set the image and store it here in this CircleAvatar Widget
                          // const CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //       'https://img.freepik.com/free-photo/cat-white-background_155003-15381.jpg?w=2000'),
                          //   radius: 80,
                          // ),
                          // const SizedBox(
                          //   height: 50,
                          // ),
                          // Center(
                          //   child: Text(
                          //     username!,
                          //     style: const TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 20),
                          //   ),
                          // ),
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
                          const Center(
                            // TODO: Get Tribe ROLE of user on this Text Widget
                            child: Text(
                              'Warrior',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          // TODO: IMPLEMENT TROPHIES HERE
                          Row(
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
                            height: 3,
                          ),
                          const Text(
                            'SKILLS:',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 209.0),
                            child: Text(
                              'MEDITATION:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                            child: LinearPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              width: 320.0,
                              lineHeight: 14.0,
                              percent: 0.1,
                              backgroundColor: Colors.white,
                              progressColor: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 247.0),
                            child: Text(
                              'STUDY:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                            child: LinearPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              width: 320.0,
                              lineHeight: 14.0,
                              percent: 0.2,
                              backgroundColor: Colors.white,
                              progressColor: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 256.0),
                            child: Text(
                              'READ:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                            child: LinearPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              width: 320.0,
                              lineHeight: 14.0,
                              percent: 0.3,
                              backgroundColor: Colors.white,
                              progressColor: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 230.0),
                            child: Text(
                              'EXERCISE:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40.0, 5.0, 0, 0),
                            child: LinearPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              width: 320.0,
                              lineHeight: 14.0,
                              percent: 0.4,
                              backgroundColor: Colors.white,
                              progressColor: Colors.green,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signOut();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //         const SignUp()));
                            },
                            child: const Text(
                              'SIGN OUT',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 30.0),
                            ),
                          )
                        ],
                      ),
                      const Positioned(
                        top: 90.0,
                        // (background container size) - (circle height / 2)
                        child: CircleAvatar(
                          // maybe change the BORDER Of THE IMAGE TO BE BLACK
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/cat-white-background_155003-15381.jpg?w=2000'),
                          radius: 55.0,
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

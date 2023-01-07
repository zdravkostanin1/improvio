import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ToGetCurrentUser {
  // static void refreshUser () async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   await user?.reload();
  //   user = FirebaseAuth.instance.currentUser;
  // }

  static String getUsername() {
    // UserCredential user = UserCredential(FirebaseAuth.instance.currentUser);
    // User? user = FirebaseAuth.instance.currentUser!;
    // FirebaseAuth.instance.userChanges();
    // print(FirebaseAuth.instance.currentUser?.displayName!);
    // print(user.displayName);
    // print(user.displayName);
    return FirebaseAuth.instance.currentUser?.displayName ?? 'no name retrieved';
  }
}

// Future<String?> getUsername()  async {
//   User? user = FirebaseAuth.instance.currentUser;
//   await user?.reload();
//   print(FirebaseAuth.instance.currentUser?.displayName!);
//   return FirebaseAuth.instance.currentUser?.displayName!;
// }

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    // ToGetCurrentUser.refreshUser();
    ToGetCurrentUser.getUsername();
    setState(() {});
    super.initState();
  }

  String? username = ToGetCurrentUser.getUsername();
  int lvlOfUser = 0;

  // // FIREBASE REAL TIME DATABASE INSTANCES:
  // FirebaseDatabase database = FirebaseDatabase.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref("users/profile-info");
  //
  // writeToFirebase() async {
  //   await ref.set({"lvl": lvlOfUser, "tribe": "No tribe"});
  // }

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
                                  lvlOfUser.toString(),
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
                          const Center(
                            // TODO: Get Tribe of user on this Text Widget
                            child: Text(
                              'GORILLAS',
                              style: TextStyle(
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
                              style: TextStyle(color: Colors.red, fontSize: 30.0),
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

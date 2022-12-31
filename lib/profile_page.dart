import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String? getUsername() {
  // return FirebaseAuth.instance.currentUser?.displayName!;
  User user = FirebaseAuth.instance.currentUser!;
  return user.displayName;
}

class _ProfilePageState extends State<ProfilePage> {
  String? username = getUsername();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 660.0,
                width: 350,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200.0,
                          width: 360.0,
                          color: Colors.white,
                          child: const Center(
                            child: Text('Background image goes here'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                username!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        // TODO: Make the person set the image and store it here in this CircleAvatar Widget
                        // const CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //       'https://img.freepik.com/free-photo/cat-white-background_155003-15381.jpg?w=2000'),
                        //   radius: 80,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Center(
                        //   child: Text(
                        //     username!,
                        //     style: const TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // const Center(
                        //   // TODO: Get Tribe of user on this Text Widget
                        //   child: Text(
                        //     'GORILLAS',
                        //     style: TextStyle(
                        //         color: Colors.red, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // const Center(
                        //   // TODO: Get Tribe ROLE of user on this Text Widget
                        //   child: Text(
                        //     'Warrior',
                        //     style: TextStyle(
                        //         color: Colors.orange, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        // TODO: IMPLEMENT TROPHIES HERE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            // SizedBox(
                            //   height: 40.0,
                            //   child: Image(
                            //     image: AssetImage('assets/cup1.png'),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15.0,
                            // ),
                            // SizedBox(
                            //   height: 40.0,
                            //   child: Image(
                            //     image: AssetImage('assets/cup2.png'),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15.0,
                            // ),
                            // SizedBox(
                            //   height: 40.0,
                            //   child: Image(
                            //     image: AssetImage('assets/cup3.png'),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15.0,
                            // ),
                            // SizedBox(
                            //   height: 40.0,
                            //   child: Image(
                            //     image: AssetImage('assets/cup4.png'),
                            //   ),
                            // ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Text(
                        //   'SKILLS:',
                        //   style: TextStyle(
                        //       fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                        // ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(right: 218.0),
                        //   child: Text('MEDITATION:', style: TextStyle( color: Colors.white),),
                        // ),
                        // const SizedBox(
                        //   height: 5.0,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: LinearPercentIndicator(
                        //     animation: true,
                        //     animationDuration: 1000,
                        //     width: 320.0,
                        //     lineHeight: 14.0,
                        //     percent: 0.1,
                        //     backgroundColor: Colors.orange,
                        //     progressColor: Colors.red,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(right: 257.0),
                        //   child: Text('STUDY:', style: TextStyle( color: Colors.white),),
                        // ),
                        // const SizedBox(
                        //   height: 5.0,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: LinearPercentIndicator(
                        //     animation: true,
                        //     animationDuration: 1000,
                        //     width: 320.0,
                        //     lineHeight: 14.0,
                        //     percent: 0.2,
                        //     backgroundColor: Colors.orange,
                        //     progressColor: Colors.red,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(right: 263.0),
                        //   child: Text('READ:', style: TextStyle( color: Colors.white),),
                        // ),
                        // const SizedBox(
                        //   height: 5.0,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: LinearPercentIndicator(
                        //     animation: true,
                        //     animationDuration: 1000,
                        //     width: 320.0,
                        //     lineHeight: 14.0,
                        //     percent: 0.3,
                        //     backgroundColor: Colors.orange,
                        //     progressColor: Colors.red,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15.0,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.only(right: 240.0),
                        //   child: Text('EXERCISE:', style: TextStyle( color: Colors.white),),
                        // ),
                        // const SizedBox(
                        //   height: 5.0,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: LinearPercentIndicator(
                        //     animation: true,
                        //     animationDuration: 1000,
                        //     width: 320.0,
                        //     lineHeight: 14.0,
                        //     percent: 0.4,
                        //     backgroundColor: Colors.orange,
                        //     progressColor: Colors.red,
                        //   ),
                        // ),
                      ],
                    ),
                    const Positioned(
                      top: 150.0,
                      // (background container size) - (circle height / 2)
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/cat-white-background_155003-15381.jpg?w=2000'),
                        radius: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

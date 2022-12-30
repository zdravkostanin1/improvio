import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String? getUsername()  {
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
                height: 350.0,
                width: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      // TODO: Make the person set the image and store it here in this CircleAvatar Widget
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/cat-white-background_155003-15381.jpg?w=2000'),
                        radius: 80,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          username!,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        // TODO: Get Tribe of user on this Text Widget
                        child: Text(
                          'Tribe',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // TODO: IMPLEMENT TROPHIES HERE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 40.0,
                            child: Image(
                              image: AssetImage('assets/cup1.png'),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: 40.0,
                            child: Image(
                              image: AssetImage('assets/cup2.png'),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: 40.0,
                            child: Image(
                              image: AssetImage('assets/cup3.png'),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: 40.0,
                            child: Image(
                              image: AssetImage('assets/cup4.png'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

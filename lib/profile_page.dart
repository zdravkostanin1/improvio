import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String getProfilePicUrl = "";
  String finalProfilePicUrl = "";
  String getBackgroundPicUrl = "";
  String finalBackGroundUrl = "";

  // SELECT A PROFILE PICTURE AND UPLOAD IT TO FIREBASE STORAGE:
  void pickAndUploadProfilePic() async {
    // TODO: Handle the CASE if user did NOT CHOOSE A PHOTO - after clicking the button .. - it throws a null exception now - 01.20.23
    final ImagePicker picker = ImagePicker();
    // TODO: MAYBE THINK ABOUT ADDING AN OPTION TO TAKE A PHOTO - WITH CAMERA .. - AT A LATER STAGE OF THE DEVELOPMENT. (or an update later on)
    final image = await picker.pickImage(
        // TO TAKE OPTION WITH CAMERA - ImageSource.camera
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        // IMAGE QUALITY :
        imageQuality: 75);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Profile Pictures/$currentNode/profile_pic.jpg');
    await ref.putFile(File(image!.path));
    // value variable is our URL to the image
    await ref.getDownloadURL().then((value) {
      // print(value);
      setState(() {
        getProfilePicUrl = value;
        // UPDATE THE URL IN DB:
        updateProfilePicUrlInDb(getProfilePicUrl);
      });
    });
  }

  // SELECT A BACKGROUND PICTURE AND UPLOAD IT TO FIREBASE STORAGE:
  void pickAndUploadBackgroundPic() async {
    // TODO: Handle the CASE if user did NOT CHOOSE A PHOTO - after clicking the button .. - it throws a null exception now - 01.20.23
    final ImagePicker picker = ImagePicker();
    // TODO: MAYBE THINK ABOUT ADDING AN OPTION TO TAKE A PHOTO - WITH CAMERA .. - AT A LATER STAGE OF THE DEVELOPMENT. (or an update later on)
    final image = await picker.pickImage(
        // TO TAKE OPTION WITH CAMERA - ImageSource.camera
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        // IMAGE QUALITY :
        imageQuality: 95);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Background Pictures/$currentNode/background_pic.jpg');
    await ref.putFile(File(image!.path));
    // value variable is our URL to the image
    await ref.getDownloadURL().then((value) {
      // print(value);
      setState(() {
        getBackgroundPicUrl = value;
        // UPDATE THE URL IN DB:
        updateBackgroundPicUrlInDB(getBackgroundPicUrl);
      });
    });
  }

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
              getUserData(snap.key, 'profilePicUrl'),
              getUserData(snap.key, 'backgroundPicUrl'),
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
      } else if (data == 'profilePicUrl') {
        saveCurrentUserProfilePic(event.snapshot.value as String);
      } else if (data == 'backgroundPicUrl') {
        saveCurrentUserBackgroundPic(event.snapshot.value as String);
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

  saveCurrentUserProfilePic(String profilePicUrl) =>
      finalProfilePicUrl = profilePicUrl;

  saveCurrentUserBackgroundPic(String backgroundPicUrl) =>
      finalBackGroundUrl = backgroundPicUrl;

  updateProfilePicUrlInDb(String url) async {
    // get the url of profile pic
    getProfilePicUrl = url;
    // save profilePicUrl to current user of firebase realtime database:
    if (currentNode != null && getProfilePicUrl != "") {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("Users/$currentNode");
      // Only update the profilePicUrl, leave the other things!
      await ref.update({
        "profilePicUrl": getProfilePicUrl,
      });
      setState(() {});
    }
  }

  updateBackgroundPicUrlInDB(String url) async {
    // get the url of profile pic
    getBackgroundPicUrl = url;
    // save profilePicUrl to current user of firebase realtime database:
    if (currentNode != null && getBackgroundPicUrl != "") {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("Users/$currentNode");
      // Only update the profilePicUrl, leave the other things!
      await ref.update({
        "backgroundPicUrl": getBackgroundPicUrl,
      });
      setState(() {});
    }
  }

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
                          Center(
                            child: Container(
                              color: Colors.white,
                              child: SizedBox(
                                width: 420,
                                height: 200,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        child: finalBackGroundUrl == ""
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 365, top: 143.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.red,
                                                  size: 180,
                                                  // profilePicUrl
                                                ),
                                              )
                                            : SizedBox(
                                                width: 2200,
                                                height: 1200,
                                                child: Image.network(
                                                  finalBackGroundUrl,
                                                  fit: BoxFit.fitWidth,
                                                  // TO SHOW CIRCULAR ANIMATION OF LOADING IMAGE:
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          loadingProgress) {
                                                    if (loadingProgress == null) {
                                                      return child;
                                                    }
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.grey,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                        // Functionality:
                                        onTap: () {
                                          pickAndUploadBackgroundPic();
                                        },
                                      ),
                                    ],
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
                        top: 124.0,
                        // (background container size) - (circle height / 2)
                        // WE USE A STACK WIDGET, SO WE CAN STACK THE PHOTO AND THE "IMPORT PHOTO" button on top of it
                        child: Stack(
                          children: [
                            CircleAvatar(
                              // maybe change the BORDER Of THE IMAGE TO BE BLACK
                              // WE SET A DEFAULT IMAGE - BEFORE THE USER HAS SELECTED ANY IMAGE.
                              backgroundImage:
                                  const AssetImage('assets/defaultUserPic.png'),
                              backgroundColor: Colors.white,
                              radius: 55.0,
                              // ADD PROFILE PIC BUTTON
                              child: Container(
                                alignment: const Alignment(1.0, 1.0),
                                child: GestureDetector(
                                  // profilePicUrl
                                  child: finalProfilePicUrl == ""
                                      ? const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 33,
                                          // profilePicUrl
                                        )
                                      : Image.network(
                                          finalProfilePicUrl,
                                          // TO SHOW CIRCULAR ANIMATION OF LOADING IMAGE:
                                          loadingBuilder: (BuildContext context,
                                              Widget child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                  // Functionality:
                                  onTap: () {
                                    pickAndUploadProfilePic();
                                    // setState(() {});
                                  },
                                ),
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

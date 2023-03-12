import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

// TO GET THE CURRENT USER'S USERNAME
String? getUsername() {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.displayName!;
}

void saveDeadline(DateTime? selectedDate) {}

class _ChallengesPageState extends State<ChallengesPage> {
  String? username = getUsername();
  String? currentUserUID = "";

  // GOAL DETAILS VARS:
  String goalName = "";
  bool selectedDeadline = false;
  DateTime currentDate = DateTime.now();
  String chooseDifficultyDropDown = "Choose Difficulty";
  String longTermOrShortTermGoal = "";

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
              saveUserUID(snap.key)
              // We call these methods to save the current key of the current USER node, and SELECT WHICH DATA WE WANT TO RETRIEVE
              // getUserData(snap.key, 'tribe'),
              // getUserData(snap.key, 'lvl'),
              // getUserData(snap.key, 'profilePicUrl'),
              // getUserData(snap.key, 'backgroundPicUrl'),
            }
        });
  }

  saveUserUID(String? node) {
    currentUserUID = node;
  }

  addGoalsToDB(String goalName, String difficulty) async {
    // TODO: FIGURE OUT HOW TO DETERMINE IF GOAL IS LONG-TERM OR SHORT-TERM
    if (currentUserUID == "") {
      // USER UID IS EMPTY ...
    } else {
      // ---> IF USER WANTS TO ADD A SHOR-TERM E.G. CLICKED ON SHORT-TERM "ADD" BUTTON
      if (longTermOrShortTermGoal == "short-term") {
        DatabaseReference ref = FirebaseDatabase.instance
            .ref("Users")
            .child("$currentUserUID")
            .child("Goals")
            .child("short-term")
            .child(goalName);
        Map<String, dynamic> userInfo = {
          "deadline":
              "${currentDate.day}/${currentDate.month}/${currentDate.year}",
          "difficulty": difficulty,
        };
        ref.set(userInfo);
      } else if (longTermOrShortTermGoal == "long-term") {
        // ---> USER WANTS TO ADD A LONG-TERM GOAL..
        DatabaseReference ref = FirebaseDatabase.instance
            .ref("Users")
            .child("$currentUserUID")
            .child("Goals")
            .child("long-term")
            .child(goalName);
        Map<String, dynamic> userInfo = {
          "deadline":
              "${currentDate.day}/${currentDate.month}/${currentDate.year}",
          "difficulty": difficulty,
        };
        ref.set(userInfo);
      } else {
        // USER HASN'T SELECTED A GOAL TO ADD.
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TO GET CURRENT USER UID IN FIREBASE REALTIME DATABASE:
    getNodeOfUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // "YOUR DAILY TODOS, INSERT NAME HERE" - for todo page
          title: Text(
            'Your GOALS, $username',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 55.0, left: 15.0, right: 15.0),
                child: SizedBox(
                  height: 200.0,
                  child: Card(
                    child: Column(
                      children: [
                        // const Padding(
                        //   padding: EdgeInsets.only(left: 20.0, top: 50.0),
                        //   child: Text(
                        //     'GOALS',
                        //     style: TextStyle(
                        //         color: Colors.red,
                        //         fontSize: 55.0,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 1.0, top: 25.0, right: 188.0),
                          child: Text(
                            'SHORT-TERM:',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // const ListTile(
                                    //   leading: Icon(Icons.album),
                                    //   title: Text('The Enchanted Nightingale'),
                                    //   subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                                    // ),
                                    Row(
                                      children: const [],
                                    ),
                                  ],
                                ),
                              ),
                              ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: [
                                  Card(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Meditate 20 times'),
                                            // TextButton(
                                            //   child: const Text('BUY TICKETS'),
                                            //   onPressed: () {/* ... */},
                                            // ),
                                            const SizedBox(width: 8),
                                            TextButton(
                                              child: const Text('ACHIEVE'),
                                              onPressed: () {/* ... */},
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // TODO: USE THIS CARD WIDGET FOR THE GOALS TO SHOW THEM IN UI:
                              // Card(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       // const ListTile(
                              //       //   leading: Icon(Icons.album),
                              //       //   title: Text('The Enchanted Nightingale'),
                              //       //   subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                              //       // ),
                              //       Row(
                              //         children: [
                              //           Text('Meditate 20 times'),
                              //           // TextButton(
                              //           //   child: const Text('BUY TICKETS'),
                              //           //   onPressed: () {/* ... */},
                              //           // ),
                              //           const SizedBox(width: 8),
                              //           TextButton(
                              //             child: const Text('ACHIEVE'),
                              //             onPressed: () {/* ... */},
                              //           ),
                              //           const SizedBox(width: 8),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Card(
                                color: Colors.black,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // const ListTile(
                                    //   leading: Icon(Icons.album),
                                    //   title: Text('The Enchanted Nightingale'),
                                    //   subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                                    // ),
                                    Row(
                                      children: [
                                        // Text('Add Goal ... '),
                                        // TextButton(
                                        //   child: const Text('BUY TICKETS'),
                                        //   onPressed: () {/* ... */},
                                        // ),
                                        // TEXT WAS "Add Goal .. : below code of TextButton:
                                        TextButton(
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 30),
                                          ),
                                          onPressed: () {
                                            // --> USER HAS SELECTED TO ADD A SHORT-TERM GOAL:
                                            longTermOrShortTermGoal =
                                                "short-term";
                                            // SHOW DIALOG IN WHICH USER INPUTS GOAL DATA:
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (context, setState) =>
                                                    AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  title: const Text(
                                                    'Goal Details',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        TextField(
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Goal Name',
                                                          ),
                                                          // TODO: MAYBE ADD A TEXT CONTROLLER TO REPLACE THIS:
                                                          // SAVE GOAL NAME TO LATER PASS IT TO A FUNCTION TO BE SAVED IN DB:
                                                          onChanged:
                                                              (nameOfGoal) {
                                                            goalName =
                                                                nameOfGoal;
                                                          },
                                                        ),
                                                        // DIFFICULTY DROPDOWN:
                                                        DropdownButtonFormField(
                                                            items: <String>[
                                                              'Choose Difficulty',
                                                              'Easy',
                                                              'Medium',
                                                              'Hard'
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                  value,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                chooseDifficultyDropDown =
                                                                    newValue!;
                                                              });
                                                            },
                                                            value:
                                                                chooseDifficultyDropDown),
                                                        // DEADLINE - DATE PICKER WIDGET HERE:
                                                        TextButton(
                                                          onPressed: () async {
                                                            // SHOWS A CALENDAR WIDGET ON THE TAP OF THE CHOOSE DEADLINE TEXTBUTTON:
                                                            // TODO: Continue implementation of DATE PICKER:
                                                            DateTime?
                                                                selectedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        currentDate,
                                                                    firstDate:
                                                                        currentDate,
                                                                    lastDate:
                                                                        DateTime(
                                                                            2123));
                                                            if (selectedDate ==
                                                                null) {
                                                              return;
                                                            }
                                                            setState(() {
                                                              // save the selected deadline in date var
                                                              currentDate =
                                                                  selectedDate;
                                                              // if the user has selected a deadline - set this var to true
                                                              selectedDeadline =
                                                                  true;
                                                            });
                                                            // getNodeOfUser();
                                                          },
                                                          // IF THE USER HAS SELECTED A DEADLINE - DISPLAY DEADLINE.. :
                                                          child: selectedDeadline
                                                              ? Text(
                                                                  'Deadline: ${currentDate.day}/${currentDate.month}/${currentDate.year}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )
                                                              // IF THE USER HASN'T SELECTED A DEADLINE... DISPLAY CHOOSE A DEADLINE TEXT .. :
                                                              : const Text(
                                                                  'Choose a deadline for this goal',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17.5,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    // "Finish" button on Alert Dialog - to finish ur goal setting
                                                    Center(
                                                      child: TextButton(
                                                        child: const Text(
                                                            "Finish"),
                                                        onPressed: () {
                                                          addGoalsToDB(goalName,
                                                              chooseDifficultyDropDown);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                            /* ... */
                                          },
                                        ),
                                        const SizedBox(width: 112),
                                        // TextButton(
                                        //   child: const Text('Add Goal ... '),
                                        //   onPressed: () {/* ... */},
                                        // ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // TODO: MAYBE USE THIS FOR THE TODO'S - PAGE. OR - HABITS
                        // Padding(
                        //   padding: const EdgeInsets.all(25.0),
                        //   child: Center(
                        //     child: Container(
                        //       padding: const EdgeInsets.only(left: 24.0, top: 24.0, bottom: 24.0, right: 210.0),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //       child: const Text("Meditate 3 times"),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              // "LONG-TERM" STARTS HERE
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: SizedBox(
                  height: 200.0,
                  child: Card(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 1.0, top: 25.0, right: 188.0),
                          child: Text(
                            'LONG-TERM:',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: const [],
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.black,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 30),
                                          ),
                                          onPressed: () {
                                            // --> USER HAS SELECTED TO ADD A LONG-TERM GOAL:
                                            longTermOrShortTermGoal =
                                                "long-term";
                                            // SHOW DIALOG IN WHICH USER INPUTS GOAL DATA:
                                            // TODO: INSTEAD OF RE-USING THE CODE ABOVE FROM THE SHORT-TERM - put in some function and organize it in future.
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (context, setState) =>
                                                    AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  title: const Text(
                                                    'Goal Details',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        TextField(
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Goal Name',
                                                          ),
                                                          // TODO: MAYBE ADD A TEXT CONTROLLER TO REPLACE THIS:
                                                          // SAVE GOAL NAME TO LATER PASS IT TO A FUNCTION TO BE SAVED IN DB:
                                                          onChanged:
                                                              (nameOfGoal) {
                                                            goalName =
                                                                nameOfGoal;
                                                          },
                                                        ),
                                                        // DIFFICULTY DROPDOWN:
                                                        DropdownButtonFormField(
                                                            items: <String>[
                                                              'Choose Difficulty',
                                                              'Easy',
                                                              'Medium',
                                                              'Hard'
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                  value,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                chooseDifficultyDropDown =
                                                                    newValue!;
                                                              });
                                                            },
                                                            value:
                                                                chooseDifficultyDropDown),
                                                        // DEADLINE - DATE PICKER WIDGET HERE:
                                                        TextButton(
                                                          onPressed: () async {
                                                            // SHOWS A CALENDAR WIDGET ON THE TAP OF THE CHOOSE DEADLINE TEXTBUTTON:
                                                            // TODO: Continue implementation of DATE PICKER:
                                                            DateTime?
                                                                selectedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        currentDate,
                                                                    firstDate:
                                                                        currentDate,
                                                                    lastDate:
                                                                        DateTime(
                                                                            2123));
                                                            if (selectedDate ==
                                                                null) {
                                                              return;
                                                            }
                                                            setState(() {
                                                              // save the selected deadline in date var
                                                              currentDate =
                                                                  selectedDate;
                                                              // if the user has selected a deadline - set this var to true
                                                              selectedDeadline =
                                                                  true;
                                                            });
                                                            // getNodeOfUser();
                                                          },
                                                          // IF THE USER HAS SELECTED A DEADLINE - DISPLAY DEADLINE.. :
                                                          child: selectedDeadline
                                                              ? Text(
                                                                  'Deadline: ${currentDate.day}/${currentDate.month}/${currentDate.year}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )
                                                              // IF THE USER HASN'T SELECTED A DEADLINE... DISPLAY CHOOSE A DEADLINE TEXT .. :
                                                              : const Text(
                                                                  'Choose a deadline for this goal',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17.5,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    // "Finish" button on Alert Dialog - to finish ur goal setting
                                                    Center(
                                                      child: TextButton(
                                                        child: const Text(
                                                            "Finish"),
                                                        onPressed: () {
                                                          addGoalsToDB(goalName,
                                                              chooseDifficultyDropDown);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                            /* ... */
                                          },
                                        ),
                                        const SizedBox(width: 112),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

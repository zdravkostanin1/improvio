import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

// TO GET THE CURRENT MONTH:
String getMonth() {
  final dateObject = DateTime.now();
  // GET THE CURRENT MONTH:
  return DateFormat.MMMM().format(dateObject);
}

// TO GET THE CURRENT USER'S USERNAME
String? getUsername() {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.displayName!;
}

class _ChallengesPageState extends State<ChallengesPage> {
  String? username = getUsername();
  String currentMonth = getMonth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMonth();
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
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55.0, left: 15.0, right: 15.0),
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
                        padding: EdgeInsets.only(left: 1.0, top: 25.0, right: 188.0),
                        child: Text(
                          'SHORT-TERM:',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // GOALS FOR THAT THE USER MAY HAVE FOR THE CURRENT MONTH:
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 13.5, top: 13.0, right: 160.0),
                      //   child: Text(
                      //     'Goals for: $currentMonth',
                      //     style: const TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 20.0,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                        child: const Text('+', style: TextStyle(color: Colors.greenAccent, fontSize: 30),),
                                        onPressed: () {
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
                            // OTHER SHORT TERM GOALS THAT USER MAY WANT TO ADD:
                            // Row(
                            //   children: const [
                            //     Padding(
                            //       padding: EdgeInsets.only(left: 0, top: 20.0, right: 4.0),
                            //       child: Text(
                            //         'Other goals:',
                            //         style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 20.0,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10.0,
                            //     ),
                            //     // TODO: IMPLEMENT DROP-DOWN IN WHICH USER CHOOSES A MONTH:
                            //     Padding(
                            //       padding: EdgeInsets.only(top: 24.0),
                            //       child: Text(
                            //         'Click to choose a month',
                            //         style: TextStyle(
                            //             decoration: TextDecoration.underline,
                            //             color: Colors.red,
                            //             fontSize: 16.0,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text(
                      //     'Click to add a goal',
                      //     style: TextStyle(
                      //         fontSize: 19.0,
                      //         color: Colors.white,
                      //         decoration: TextDecoration.underline),
                      //   ),
                      // )
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
              padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: SizedBox(
                height: 200.0,
                child: Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 1.0, top: 25.0, right: 188.0),
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
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                        child: const Text('+', style: TextStyle(color: Colors.greenAccent, fontSize: 30),),
                                        onPressed: () {
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
    );
  }
}

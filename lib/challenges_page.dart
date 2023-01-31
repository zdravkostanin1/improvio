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

class _ChallengesPageState extends State<ChallengesPage> {
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
          title: Text('Your GOALS, {insert name here}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        ),
        backgroundColor: Colors.black,
        body: Column(
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
              padding: EdgeInsets.only(left: 1.0, top: 25.0, right: 182.0),
              child: Text(
                'SHORT-TERM:',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.5, top: 13.0, right: 160.0),
              child: Text(
                'Goals for: $currentMonth',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0),
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
                          children: [
                            Text('Meditate 3 times'),
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
                            TextButton(
                              child: const Text('Add Goal ... '),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 200),
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
            )
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
    );
  }
}

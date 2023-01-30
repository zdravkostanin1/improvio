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
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 50.0),
              child: Text(
                'GOALS',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 1.0, top: 10.0, right: 19.0),
              child: Text(
                'SHORT-TERM:',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.5, top: 13.0, right: 0.0),
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
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("Meditate 3 times"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

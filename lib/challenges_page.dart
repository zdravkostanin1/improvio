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
  String month = getMonth();

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
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.5, top: 10.0, right: 0.0),
              child: Text(
                'Goals for: $month',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

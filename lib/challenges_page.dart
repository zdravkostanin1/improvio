import 'package:flutter/material.dart';


class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text(
          'Challenges', style: TextStyle(color: Colors.white),
        ),),
      )
    );
  }
}

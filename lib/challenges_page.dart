import 'package:flutter/material.dart';


class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: const [
          Scaffold(
            body: Center(
              child: Text('ADDDD'),
            ),
          ),
        ],
      ),
    );
  }
}

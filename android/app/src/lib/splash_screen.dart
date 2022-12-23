// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Splash Screen',
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: AnimatedTextKit(
//               animatedTexts: [
//                 TypewriterAnimatedText(
//                   'We are what we repeatedly do. Excellence then is not an act but a habit. - Will Durant',
//                   textAlign: TextAlign.center,
//                   textStyle: const TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Schyler',
//                       color: Color(0xfffa3333),
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//               isRepeatingAnimation: false,
//               onFinished: () => print('asd')
//             // onFinished: () async {
//             //   setState(() async {
//             //     await Future.delayed(const Duration(seconds: 3), () {
//             //       Navigator.push(
//             //           context,
//             //           MaterialPageRoute(
//             //               builder: (context) => const TakeActionPage()));
//             //     });
//             //   });
//             // }
//           ),
//         ),
//       ),
//     );
//   }
// }

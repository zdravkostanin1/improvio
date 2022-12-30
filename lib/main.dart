import 'package:flutter/material.dart';
import 'package:improvio/home_page.dart';
import 'package:improvio/sign_in.dart';
import 'package:improvio/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'sign_up.dart';

Future<void> main() async {
  // runApp(const HomePage());
  // INITIALIZE FIREBASE WITH THESE COMMANDS
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HomePage());
}

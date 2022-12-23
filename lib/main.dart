import 'package:flutter/material.dart';
import 'package:improvio/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'sign_up.dart';

void main() async {
  // INITIALIZE FIREBASE WITH THIS COMMAND
  runApp(const SignUp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

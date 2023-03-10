import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:improvio/sign_up.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'home_page.dart';
import 'package:email_validator/email_validator.dart';


// SMALL LOADING BUTTON - WHEN USER CLICKS SIGN IN
Widget loadingButton (bool isDone) {
  return Container(
    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
    child: const Center(child: CircularProgressIndicator(color: Colors.black,)),
  );
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class UserMethods {
  static void signInUser(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static bool checkUserStatus() {
    bool signedIn = false;
    if (FirebaseAuth.instance.currentUser != null) {
      signedIn = true;
      return signedIn;
    } else {
      signedIn = false;
      return signedIn;
    }
  }
}

// STATES OF LOADING OUR SMALL BUTTON - WHICH REPRESENTS LOADING INDICATOR WHEN USER CLICKS SIGN UP
enum ButtonState { init, loading}

class _SignInState extends State<SignIn> {
  // bool termsAndConditions = false;
  String username = '';
  String emailAddress = '';
  String password = '';
  bool obscureText = true;
  int forPasswordVisibilityToggle = 0;
  final passwordTextController = TextEditingController();
  ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {
    bool signUpButtonStretched = state == ButtonState.init;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   unselectedWidgetColor: Colors.red, // <-- your color
      // ),
      title: 'Sign In Page',
      home: Scaffold(
        // for renderflex problem, we set the bottomInset to false
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0B0A0A),
        body: Builder(builder: (BuildContext context) {
          return SafeArea(
            // WE USE A SingleChildScrollView - to kill this problem with rendering:
            // https://stackoverflow.com/questions/49480051/flutter-dart-exceptions-caused-by-rendering-a-renderflex-overflowed
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 750.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/sign-in.png'),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 200.0,
                          ),
                          // TODO: Figure out a way to store username when registering..
                          SizedBox(
                            height: 55.0,
                            width: 340,
                            child: TextField(
                              decoration: InputDecoration(
                                // maxlines property: (if you need, add it)
                                filled: true,
                                fillColor: const Color(0xffE8E8E8),
                                // fillColor: const Color(0xff89CFF0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'e-mail',
                                // icon: Icon(Icons.email),
                                prefixIcon: const Icon(Icons.email),
                                // suffixIcon: Icon(Icons.park),
                              ),
                              onChanged: (String email) {
                                setState(() {
                                  emailAddress = email;
                                });
                                print(emailAddress);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          SizedBox(
                            height: 55.0,
                            width: 340,
                            child: TextField(
                              controller: passwordTextController,
                              decoration: InputDecoration(
                                // maxlines property: (if you need, add it)
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      // we use a counter to diffrentiate when the icon to show password is clicked
                                      // and when it is not..
                                      forPasswordVisibilityToggle++;
                                      if (forPasswordVisibilityToggle == 1) {
                                        obscureText = false;
                                      } else {
                                        obscureText = true;
                                        forPasswordVisibilityToggle = 0;
                                      }
                                    });
                                  },
                                ),
                                fillColor: const Color(0xffE8E8E8),
                                // fillColor: const Color(0xff89CFF0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'password',
                                prefixIcon: const Icon(Icons.password),
                                // suffixIcon: Icon(Icons.park),
                              ),
                              // TODO: implement toggle of obscure text
                              // TODO: this may help: https://stackoverflow.com/questions/52111853/how-to-add-a-password-input-type-in-flutter-makes-the-password-user-input-is-not
                              obscureText: obscureText,
                              enableSuggestions: false,
                              autocorrect: false,
                              // TODO: make a specific class for checking password requirements, or a function perhaps.
                              // SPECIAL CHARACTERS, ETC.. numbers..
                              // look into textController.. if needed
                              onChanged: (String passwordSetted) {
                                print(passwordTextController.text);
                                // password = textFieldController.text;
                                setState(() {
                                  password = passwordTextController.text;
                                  if (validatePassword(passwordSetted) ==
                                      true) {
                                    password = passwordSetted;
                                    print(password);
                                  } else {
                                    print('Password is too weak.');
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            height: 50,
                            width: 340,
                            child: signUpButtonStretched ? TextButton(
                              onPressed: () {
                                if (emailAddress.isEmpty) {
                                  toastMessage('Your email field is empty');
                                } else if (password.isEmpty) {
                                  toastMessage('Your password field is empty');
                                } else if (EmailValidator.validate(
                                        emailAddress) !=
                                    true) {
                                  toastMessage('Invalid e-mail');
                                } else {
                                  // MAYBE ADD CIRCULAR ANIMATION .. BUT YOU DO NOT NEED IT.
                                  UserMethods.signInUser(
                                      emailAddress, password);
                                  // SET THE STATE TO LOADING - TO LOAD ANIMATION OF PRESSING SING-UP BUTTON - CIRCULAR MOTION
                                  setState(() => state = ButtonState.loading);
                                  // USING FUTURE.DELAYED - TO WAIT FOR THE SIGN - IN TO FINISH SIGNING IN AND
                                  // TO DISPLAY NAME OF THE USER.
                                  Future.delayed(const Duration(seconds: 3), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const HomePage()));
                                  });
                                }
                                // to check if the user has signed in..
                                // UserMethods.checkUserStatus();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffe3e36c),
                                ),
                              ),
                              child: const Text(
                                'SIGN-IN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ) : loadingButton(true),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xffE8E8E8),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 200);
                                  // Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp()));
                                  // });
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const SignUp()));
                                },
                                child: const Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:improvio/home_page.dart';
import 'package:improvio/profile_page.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class CreateUser {
  // late String username;
  // late String emailAddress;
  // late String password;
  //
  // CreateUser(this.username, this.emailAddress, this.password);

  static void signUpUser(
      String username, String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
        // username: username,
      );
      await credential.user?.updateDisplayName(username);
      // print(credential.user?.displayName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      // print(e);
    }
  }

  // static bool checkUserStatus() {
  //   bool signedIn = false;
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     signedIn = true;
  //     // print('signed in.');
  //     return signedIn;
  //   } else {
  //     signedIn = false;
  //     // print('not signed in');
  //     return signedIn;
  //   }
  // }

  // static void signInUser(String emailAddress, String password) async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailAddress,
  //         password: password
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  static void addProfileInfoToDatabase(int lvlOfUser, String username, String tribeStatus)  {
    // ADD USER DETAILS TO FIREBASE REAL TIME DATABASE:
    // FIREBASE REAL TIME DATABASE INSTANCES:
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('Users');
    Map<String, dynamic> userInfo = {
      "lvl": lvlOfUser,
      "tribe": tribeStatus,
      "username": username
    };
    databaseRef.push().set(userInfo);
    // await ref.set({"lvl": lvlOfUser, "tribe": "No tribe"});
  }

  // static String? getUserName() {
  //   return FirebaseAuth.instance.currentUser!.displayName;
  //   // User user = FirebaseAuth.instance.currentUser!;
  //   // user.reload();
  //   // return user.displayName;
  // }
}

// TODO: CONTINUE IMPLEMENTATION , AND ADD TOAST MESSAGES IF PASS DOESN'T MEET REQUIREMENTS, ETC...
bool validatePassword(String password, [int minLength = 7]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

Future toastMessage(String message) async {
  await Fluttertoast.showToast(
    msg: message,
    textColor: Colors.black,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.white,
  );
}

class _SignUpState extends State<SignUp> {
  // maybe add late modifier to the variables in future.. think about which decisicon is best:
  // keep them like this or add modifier..
  bool termsAndConditions = false;
  String username = '';
  String emailAddress = '';
  String password = '';
  bool obscureText = true;
  int forPasswordVisibilityToggle = 0;
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   unselectedWidgetColor: Colors.red, // <-- your color
      // ),
      title: 'Sign Up Page',
      home: Scaffold(
        // for renderflex problem, we set the bottomInset to false
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0B0A0A),
        body: Builder(builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 750.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/baaaaack.png'),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 310.0,
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
                              hintText: 'username',
                              // icon: Icon(Icons.email),
                              prefixIcon: const Icon(Icons.person),
                              // suffixIcon: Icon(Icons.park),
                            ),
                            onChanged: (String displayName) {
                              setState(() {
                                username = displayName;
                              });
                              print(username);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
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
                              // TODO: make a specific class for checking emails requirements, or a function perhaps.
                              setState(() {
                                if (email.contains('@') &&
                                    email.contains('.')) {
                                  emailAddress = email;
                                  print(emailAddress);
                                }
                              });
                            },
                          ),
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
                              // icon: Icon(Icons.email),
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
                              // TODO: CONTINUE THE IMPLEMENTATION OF TEXT CONTROLLER:..
                              print(passwordTextController.text);
                              // password = textFieldController.text;
                              setState(() {
                                password = passwordTextController.text;
                                if (validatePassword(passwordSetted) == true) {
                                  password = passwordSetted;
                                  print(password);
                                } else {
                                  print('Password is too weak.');
                                }

                                // if (passwordSetted.length >= 8) {
                                //   password = passwordSetted;
                                //   print(password);
                                // }
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 370,
                          // height: 50,
                          // theme widget to set checkbox border color.
                          child: Theme(
                            data: ThemeData(
                              // primarySwatch: Colors.blue,
                              unselectedWidgetColor: Colors.white, // Your color
                            ),
                            //TODO: Implement half of text to be clickable with this link:
                            //TODO: https://stackoverflow.com/questions/58145606/make-specific-parts-of-a-text-clickable-in-flutter
                            child: CheckboxListTile(
                              activeColor: Colors.transparent,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text(
                                "I have read, and agree to the Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xffE8E8E8),
                                ),
                              ),
                              //    <-- label
                              value: termsAndConditions,
                              enabled: true,
                              checkColor: const Color(0xffE8E8E8),
                              onChanged: (newValue) {
                                setState(() {
                                  termsAndConditions = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 50,
                          width: 340,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                print(emailAddress);
                                print(password);
                                print(username);
                                if (termsAndConditions != true) {
                                  // REMOVE THE FLUTTER ICON THAT'S SHOWN WHEN THE MESSAGE POPS.. maybe leave it for later.
                                  toastMessage(
                                      'You haven\'t read and agreed to the Terms & Conditions.');
                                } else if (username.isEmpty) {
                                  toastMessage('Your username is empty');
                                } else if (password.isEmpty) {
                                  toastMessage('Your password field is empty');
                                } else if (emailAddress.isEmpty) {
                                  toastMessage('Your email field is empty');
                                } else if (EmailValidator.validate(
                                        emailAddress) !=
                                    true) {
                                  toastMessage('Invalid e-mail');
                                } else {
                                  CreateUser.signUpUser(
                                      username, emailAddress, password);
                                  CreateUser.addProfileInfoToDatabase(0, username, "N\/A");
                                  // print(username);
                                  // CreateUser.signInUser(emailAddress, password);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                                const HomePage()));
                                  // CreateUser.checkUserStatus();
                                }
                                // get the current user details with this line:
                                // print(FirebaseAuth.instance.currentUser);
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xffe3e36c),
                              ),
                            ),
                            child: const Text(
                              'SIGN-UP',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()));
                              },
                              child: const Text(
                                'Sign-In',
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
          );
        }),
      ),
    );
  }
}

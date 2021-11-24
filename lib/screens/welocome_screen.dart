import 'package:fashion_store/screens/product_screen.dart';
import 'package:fashion_store/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fashion_store/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late final FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();

    _auth = FirebaseAuth.instance;

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      appBar: AppBar(
        //title: Text('App Bar!'),
        flexibleSpace: Image(
          image: AssetImage('images/pink-cover-page-2.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/pink-logo.jpg'),
                  height: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.pinkAccent,
              text: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.pink,
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: FloatingActionButton.extended(
                icon: Image.asset(
                  'images/google-logo.jpg',
                  width: 32,
                  height: 32,
                ),
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleSignInAccount =
                        await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication
                        googleSignInAuthentication =
                        await googleSignInAccount!.authentication;
                    final AuthCredential credential =
                        GoogleAuthProvider.credential(
                      accessToken: googleSignInAuthentication.accessToken,
                      idToken: googleSignInAuthentication.idToken,
                    );
                    final User = await _auth.signInWithCredential(credential);

                    if (User != null) {
                      Navigator.pushNamed(context, ProductScreen.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e.message);
                  }
                },
                label: Text("Sign in with Google"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

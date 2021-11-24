import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_store/screens/welocome_screen.dart';
import 'package:fashion_store/widgetDescription.dart';
import 'package:fashion_store/widgetPageViewHeader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatefulWidget {
  static const String id = 'product_screen';
  int SelectIndex = 0;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WidgetPageViewHeader(
            notifyParent: (int index) {
              setState(() {
                widget.SelectIndex = index;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: WidgetDescription(
              index: widget.SelectIndex,
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      bool gsn = await _googleSignIn.isSignedIn();

                      if (gsn) _googleSignIn.signOut();

                      _auth.signOut();

                      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                    },
                    icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.shopping_basket,
                          color: Colors.white,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rise_flutter/model/user.dart' as model;
import 'package:rise_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getUserDetails() async {
    User currentUser = _auth.currentUser!;

    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(currentUser.uid).get();
      print("id:${snap.exists}");
      return model.User.fromSnap(snap);
    } catch (e) {
      print(e);
    }
  }

// sign up user
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occered";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

// adding image
        String photUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        // adding user to database
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photUrl);

        _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        // anaother way
        // await _firestore.collection("users").add({
        //   "username": username,
        //   "uid": cred.user!.uid,
        //   "email": email,
        //   "bio": bio,
        //   "followers": [],
        //   "following": [],
        // });
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == "invalid-email") {
    //     res = "This email is badly formated";
    //   } else if (err.code == "weak-password") {
    //     res = 'Your password should be at least 6 characters';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

// logging the user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    print('logout');
    await _auth.signOut();
  }
}

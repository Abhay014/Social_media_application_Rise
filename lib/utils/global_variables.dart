import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rise_flutter/screens/add_post_screen.dart';
import 'package:rise_flutter/screens/feed_screen.dart';
import 'package:rise_flutter/screens/search_screen.dart';

import '../screens/profile_screen.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
const webScreenSize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("notif"),
  ProfileScreen(
    uid: uid,
  ),
];

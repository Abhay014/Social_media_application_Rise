import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rise_flutter/screens/profile_screen.dart';
import 'package:rise_flutter/utils/colors.dart';
import 'package:rise_flutter/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // String username = "";

  int _page = 0;
  late PageController pageController;

  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    print(page);
  }

  void onPagedChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUsername();
  // }

  // void getUsername() async {
  // DocumentSnapshot snap = await FirebaseFirestore.instance
  //     .collection('user')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .get();

  //   print(snap.data());
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        // physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPagedChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // unselectedItemColor: Colors.blueGrey,
        // selectedItemColor: Colors.cyan,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0
                  ? Colors.amber
                  : Color.fromARGB(255, 236, 218, 150),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1
                  ? Colors.amber
                  : Color.fromARGB(255, 236, 218, 150),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2
                  ? Colors.amber
                  : Color.fromARGB(255, 236, 218, 150),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3
                  ? Colors.amber
                  : Color.fromARGB(255, 236, 218, 150),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4
                  ? Colors.amber
                  : Color.fromARGB(255, 236, 218, 150),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}

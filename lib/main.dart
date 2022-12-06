import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rise_flutter/provider/user_provider.dart';
import 'package:rise_flutter/responsive/mobileScreenLayout.dart';
import 'package:rise_flutter/responsive/webScreenLayout.dart';
import 'package:rise_flutter/screens/login_screen.dart';
import 'package:rise_flutter/screens/signup_screen.dart';
import 'package:rise_flutter/utils/colors.dart';

import 'responsive/responsive_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBb1aVCiOICzCwA7qfCrMwi2vhWH5I7VFI',
        appId: "1:637266390687:web:390f356491a7265fefbcaa",
        messagingSenderId: "637266390687",
        projectId: "rise-social-media",
        storageBucket: "rise-social-media.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rise',
        theme: ThemeData.light().copyWith(
            //scaffoldBackgroundColor: mobileBackgroundColor,
            ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasData) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: primaryColor,
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

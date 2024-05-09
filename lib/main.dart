import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
// import 'package:instagram_flutter/responsive/responsive_layout.dart';
// import 'package:instagram_flutter/responsive/web_screen_layout.dart';
// import 'package:instagram_flutter/screens/login.dart';
import 'package:instagram_flutter/screens/signup.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAGHvb99TlMFo_kbb7tsBNYvcQqeR63Ja8",
        // authDomain: "instagram-clone-5163d.firebaseapp.com",
        projectId: "instagram-clone-5163d",
        storageBucket: "instagram-clone-5163d.appspot.com",
        messagingSenderId: "862598133232",
        appId: "1:862598133232:web:4c2d9c69b064eb37ead935",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: const SignUpScreen(),
    );
  }
}

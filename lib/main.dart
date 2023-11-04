import 'package:flutter/material.dart';
import 'package:marestoku/pages/menu_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCedz-uO0ql74PDHxwI3FrEWmyHo_WvHCY",
        authDomain: "marestoku.firebaseapp.com",
        databaseURL: "https://marestoku-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "marestoku",
        storageBucket: "marestoku.appspot.com",
        messagingSenderId: "225202683902",
        appId: "1:225202683902:web:bfc3afc78be77ba410caaf",
        measurementId: "G-30E9XSM8L3"
    ),
  );


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MenuPage(),
    );
  }
}
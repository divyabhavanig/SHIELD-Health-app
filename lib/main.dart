import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shieldhealth/auth/login_or_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shieldhealth/database/food_database.dart';

import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FoodDatabase.initialize();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyApySS5hszNHl9X0pbivmPU8YAMMjO6QdU",
      appId: "1:767842763075:android:944639fc8e58af4f286ff6",
      messagingSenderId: "767842763075",
      projectId: "health-56d97",
      storageBucket: "health-56d97.appspot.com",
      databaseURL: "https://health-56d97-default-rtdb.firebaseio.com/",
    ),
  );
  runApp(MultiProvider(
    providers: [
      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      //nutri tracker provider

      ChangeNotifierProvider(create: (context) => FoodDatabase()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

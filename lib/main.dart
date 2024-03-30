import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Theme/MyTheme.dart';
import 'package:movies_app/pages/home/home_page.dart';
import 'package:movies_app/pages/movie_details.dart';
import 'data/database_utils/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        MovieDetails.routeName: (context) => MovieDetails(),
      },
      title: 'Movies',
      theme: MyTheme.Themes,
    );
  }
}

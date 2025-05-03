import 'package:flutter/material.dart';
import 'package:forcen/pages/addeventpage.dart';
import 'package:forcen/pages/event_page.dart';
import 'package:forcen/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  //pour assurer tout est initialier avant de lancer l'application
  WidgetsFlutterBinding.ensureInitialized();

  //initialisation de firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentPage = 0;

  setCurrentPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //pour enlever le mode debug
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: [
              Text("Accueil",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),),
              Text("Formulaire",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28
                ),),
              Text("Liste des formations",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28
                ),)
            ][_currentPage],
          ),
          body: [
            HomePage(),
            AddEventPage(),
            EventPage()
          ][_currentPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPage,
            backgroundColor: Colors.white,
            onTap: (page) => setCurrentPage(page),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.blue,
            iconSize: 32,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Accueil"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Ajout"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "planning")
            ],
          )

      ),
    );
  }
}
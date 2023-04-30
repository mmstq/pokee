import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokee/screen/Name_Pages/home.dart';
import 'package:pokee/screen/profile.dart';
import 'package:pokee/screen/welcome_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void selectIndex(int i) {
    setState(() {
      currentIndex = i++;
    });
  }

  final titles = ['Home', 'Add Friend', 'Favorites', 'Profile'];

  final pages = [
    const FakeTabScreen(
      color: Colors.teal,
    ),
    const FakeTabScreen(
      color: Colors.orangeAccent,
    ),
    const FakeTabScreen(
      color: Colors.blueAccent,
    ),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.withOpacity(0.5),

        elevation: 0,
        title: Text(
          titles[currentIndex],
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        iconSize: 32,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (i) {
          selectIndex(i);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_alt), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

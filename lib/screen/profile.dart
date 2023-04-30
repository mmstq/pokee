import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokee/screen/Name_Pages/profile_provider.dart';
import 'package:pokee/screen/welcome_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) => ProfileProvider(),
      child: Scaffold(
        body: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
          if (profileProvider.state == States.loading) {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (profileProvider.model == null) {
              return const Center(
                child: Text(
                  'No User Details Found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              );
            } else {
              return Stack(
                children: [
                  SizedBox(
                    height: mq.height * .8,
                    child: Image.asset(
                      'assets/profile.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      right: 12,
                      bottom: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        radius: 25,
                        child: IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => const Welcome()),
                                    (Route<dynamic> route) => false);
                              });
                            },
                            icon: const Icon(Icons.logout)),
                      )),
                  Positioned(
                    bottom: 16,
                    left: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileProvider.model!.displayName!,
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('@${profileProvider.model!.userName!}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              );
            }
          }
        }),
      ),
    );
  }
} /**/

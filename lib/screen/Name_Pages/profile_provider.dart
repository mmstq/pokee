import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:pokee/screen/api/api.dart';
import 'package:pokee/screen/api/user_model.dart';

enum States { loading, loaded }

class ProfileProvider extends ChangeNotifier {
  Api? api;
  FirebaseAuth? auth;
  UserModel? model;
  States state = States.loading;

  ProfileProvider() {
    auth = FirebaseAuth.instance;
    api = Api();
    getUserDetails();
  }

  getUserDetails() async {
    if (auth!.currentUser != null) {
      final response = await api!.getUser(auth!.currentUser!.uid);
      if (response.statusCode == 200) {
        model = UserModel.fromJson(jsonDecode(response.body));
      }
    }
    state = States.loaded;
    notifyListeners();
  }
}

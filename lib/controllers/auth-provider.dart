

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/controllers/local-storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/user-model.dart';
import '../router/routes-name.dart';
import '../screens/login/login.dart';
import '../widgets/progress-dialog.dart';

class AuthProvider extends ChangeNotifier {


  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  bool isLoggedIn = false;

  setIsLoggedIn(bool isLog){
    isLoggedIn = isLog;
    notifyListeners();
  }

  bool get getIsLoggedIn => isLoggedIn;


register(UserModel userModel, BuildContext context) async {
  try {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating, Please wait...",
          );
        });



    UserCredential userCredential =
    await _auth.createUserWithEmailAndPassword(
        email: userModel.email.toString(), password: userModel.password.toString());
    user = userCredential.user;

    userModel.docID = user!.uid;



    await user!.updateDisplayName(userModel.firstName);
    await user!.updatePhotoURL(userModel.imageUrl);


    await user!.reload();
    user = _auth.currentUser;

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('table-user')
        .where('email', isEqualTo: userModel.email.toString())
        .get();
    final List<DocumentSnapshot> document = result.docs;

    if (document.isEmpty) {
      await FirebaseFirestore.instance
          .collection("table-user")
          .doc(user!.uid)
          .set(userModel.toMap())
          .then((uid) async {


        UserModel userData = UserModel(
            docID: userModel.docID,
            firstName: userModel.firstName,
            lastName: userModel.lastName,
            address: userModel.address,
            phoneNumber: userModel.phoneNumber,
            email: userModel.email,
            password: userModel.password,
            gender: userModel.gender,
            birthDate: userModel.birthDate,
            userType: userModel.userType,
            imageUrl: userModel.imageUrl);



        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', userModel.email.toString());

        Navigator.of(context).pushNamed(RoutesName.HOME_URL);

        Fluttertoast.showToast(
          msg: "Account created successfully :) ",
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.CENTER_RIGHT,
        );
      });
    }
    notifyListeners();
  } on FirebaseAuthException catch (error) {
    Navigator.of(context).pop();
    switch (error.code) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "email-already-in-use":
        errorMessage = "The account already exists for that email.";
        break;

      case "weak-password":
        errorMessage = "Weak Password.";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "Check Your Internet Access.";
    }

    Fluttertoast.showToast(
      timeInSecForIosWeb: 3,
      msg: errorMessage!,
      gravity: ToastGravity.CENTER,
    );
    print(error.code);
  }
}







  login(String email, String password, BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Authenticating, Please wait...",
            );
          });

      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('table-user')
          .where('email', isEqualTo: email)
          .get();
      final List<DocumentSnapshot> document = result.docs;

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((id) async {
        if (document.isNotEmpty) {


          DocumentSnapshot documentSnapshot = document[0];
          UserModel userData = UserModel.fromMap(documentSnapshot);

          // await FirebaseFirestore.instance
          //     .collection("table-user")
          //     .doc(userData.docID)
          //     .update({'token': token});
          // NavigateRoute.gotoPage(context, Home());

          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString('email', email);
          Navigator.of(context).pushNamed(RoutesName.HOME_URL);
          //Navigator.pushNamed(context, '/home');

          context.read<AuthProvider>().setIsLoggedIn(true);

          LocalStorageHelper.saveValue('isLoggedIn', 'true');
          //context.read< LocalStorageHelper>().saveValue('isLoggedIn', 'true');

          //Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName(RoutesName.HOME_URL));

        }


        Fluttertoast.showToast(
          msg: "Welcome, You are now logged in !!! :) ",
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.CENTER_RIGHT,
        );
      });

      isLoggedIn = true;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be invalid.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "Check Your Internet Access.";
      }

      Fluttertoast.showToast(
        msg: errorMessage!,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER_RIGHT,
      );
      print(error.code);
    }
  }

// the logout function
  static Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
  }

}

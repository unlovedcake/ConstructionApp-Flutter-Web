import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/customer-model.dart';
import 'controller.dart';

class ServiceAPI {

  static Future<List< CustomerModel>> retrieveEmployees(int limit) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await  FirebaseFirestore.instance
        .collection("table-customer").limit(limit).get();
    return snapshot.docs
        .map((docSnapshot) =>  CustomerModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }


  // static bool isLoggedIn(){
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user!.email == "") {
  //     return false;
  //   }else{
  //     return true;
  //   }
  // }

  static Future<String?> isLoggedIn()async{
    //bool isLoggedIn =   Provider.of<AuthProvider>(context, listen: false).getIsLoggedIn;
    String? email;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? null;
    return email;
  }
}
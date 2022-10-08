import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  int indexContentPage = 0;
  bool isLoggedIn = false;


  setIndexContentPage(int index){
    indexContentPage = index;
    notifyListeners();
  }
  setIsLoggedIn(bool isSelect){
    isLoggedIn =  isSelect;
    notifyListeners();
  }

  bool get getIsLoggedIn => isLoggedIn;

  int get getIndexContentPage => indexContentPage;

  Stream<QuerySnapshot> getCustomers() {
    notifyListeners();
    return FirebaseFirestore.instance
        .collection("table-customer")
        .snapshots();

  }





  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}

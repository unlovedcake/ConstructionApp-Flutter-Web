import 'dart:html';

import 'package:flutter/cupertino.dart';

class LocalStorageHelper{

  static Storage localStorage = window.localStorage;

 static saveValue(String key, String value){
      localStorage[key] = value;


  }
  static getValue(String key){
    return localStorage[key];

  }

  static removeValue(String key){
    return localStorage.remove(key);

  }
}
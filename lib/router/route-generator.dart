import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/controllers/service.dart';
import 'package:responsive_admin_dashboard/router/routes-name.dart';
import 'package:responsive_admin_dashboard/screens/customer/customer-ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../controllers/auth-provider.dart';
import '../controllers/controller.dart';
import '../controllers/local-storage.dart';
import '../screens/dash_board_screen.dart';
import '../screens/login/login.dart';
import '../screens/register/register.dart';
import 'generate-page-route.dart';


class RouteGenerator {

  static String? email;




  static Widget _errorRoute() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: NittivTheme().lightTheme,
      home: Scaffold(
        body: Center(
          child: Text("Unauthenticated Error"),
        ),
      ),
    );
  }

  static Route<dynamic>? generateRoutes(RouteSettings settings) {


    switch (settings.name) {
      case RoutesName.LOGIN_URL:
        return GeneratePageRoute(widget: const Login(), routeName: settings.name);

      default:
        print("LOGIN PAGEZ");
        return GeneratePageRoute(widget:const Login(), routeName: '/login');
    }
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final  widget = settings.arguments;
    final currentIndex = settings.arguments;


    // if(LocalStorageHelper.getValue('isLoggedIn') != 'true' && settings.name == '/home'){
    //   print("LOGIN PAGEZZ");
    //   return GeneratePageRoute(widget: const Login(), routeName: settings.name);
    // }

    switch (settings.name) {


      case RoutesName.CUSTOMER_URL:

        if(LocalStorageHelper.getValue('isLoggedIn') != 'true' ){
          print("LOGIN PAGE");
          return GeneratePageRoute(widget: const Login(), routeName: settings.name);
        }else{
          print("Customer Page");
          return GeneratePageRoute(widget:  CustomerUI(), routeName: '/customer');

        }

      case RoutesName.LOGIN_URL:


        if(LocalStorageHelper.getValue('isLoggedIn') != 'true' ){
          print("LOGIN PAGEZZ");
          return GeneratePageRoute(widget: const Login(), routeName: settings.name);
        }else{
          print("HOME PAGEZZSSS");
          return GeneratePageRoute(widget:  DashBoardScreen(), routeName: '/home');

        }




      case RoutesName.REGISTER_URL:

        return GeneratePageRoute(widget: const Register(), routeName: settings.name);


      case RoutesName.HOME_URL:


        if(LocalStorageHelper.getValue('isLoggedIn') != 'true'){
          print("LOGIN PAGEZZ");
          return GeneratePageRoute(widget: const Login(), routeName: '/login');
        }else{
          print("HOME PAGEZZ");
          return GeneratePageRoute(widget:  DashBoardScreen(), routeName: settings.name);
        }

      // case RoutesName.PROFILE_URL:
      //   return GeneratePageRoute(widget:  ProfilePage(), routeName: settings.name);
      //
      // case RoutesName.INBOX_URL:
      //   return GeneratePageRoute(widget:  InboxPage(), routeName: settings.name);
      //
      // case RoutesName.UPDATE_URL:
      //   return GeneratePageRoute(widget:  UpdatePage(), routeName: settings.name);



    // case RoutesName.REGISTER_OPERATOR_URL:
    //   return GeneratePageRoute(
    //       widget: OperatorRegisterationForm(), routeName: settings.name);
    //
    // case RoutesName.REGISTER_TRAVELER_URL:
    //   return GeneratePageRoute(
    //       widget: TravelerRegisterationForm(), routeName: settings.name);

    // case RoutesName.REGISTER_OPERATOR_URL:
    //   if (userType is Object) {
    //     return GeneratePageRoute(
    //         widget: RegistrationPage(userType: userType as NittivUserType),
    //         routeName: settings.name);
    //   }
    //   break;
    //
    // case RoutesName.REGISTER_TRAVELER_URL:
    //   if (userType is Object) {
    //     return GeneratePageRoute(
    //         widget: RegistrationSequence(userType: userType as NittivUserType),
    //         routeName: settings.name);
    //   }
    //   break;

    // return GeneratePageRoute(
    //     widget: const RegistrationSequence(userType: userType),
    //     routeName: settings.name);

      default:
        return GeneratePageRoute(widget: _errorRoute(), routeName: settings.name);
    }
  }
}
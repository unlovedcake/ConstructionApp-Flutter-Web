import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/controllers/auth-provider.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/controllers/customer-provider.dart';
import 'package:responsive_admin_dashboard/router/route-generator.dart';
import 'package:responsive_admin_dashboard/router/routes-name.dart';
import 'package:responsive_admin_dashboard/screens/dash_board_screen.dart';
import 'package:responsive_admin_dashboard/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants/constants.dart';
import 'controllers/local-storage.dart';
import 'models/user-model.dart';


String? email;
String? isLoggedIn;

Future<void> main() async {



  WidgetsFlutterBinding.ensureInitialized();
   setPathUrlStrategy();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email') ?? "";

  await Firebase.initializeApp(

    options: const FirebaseOptions(
      apiKey:  "AIzaSyCcbT293eE59ZaTXQEwq2Q0ZxBLS4FKTjU",
      appId: "1:252515632807:web:4fa3e10e797e4f32113d82",
      authDomain: "construction-app-fdb46.firebaseapp.com",
      messagingSenderId: "252515632807",
      projectId: "construction-app-fdb46",
      storageBucket: "construction-app-fdb46.appspot.com", measurementId: "G-PS9PED9GL9"
    ),
  );

  //
  // if(kIsWeb) {
  //   final String defaultRouteName = WidgetsBinding.instance.window.defaultRouteName;
  //   if (!(defaultRouteName == 'login' || defaultRouteName == '/'  && email == null ||
  //       email == "")) {
  //     SystemNavigator.routeUpdated(
  //         routeName: '/login',
  //         previousRouteName:'/login',
  //     );
  //   }
  // }




  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
        //ChangeNotifierProvider(create: (_) => LocalStorageHelper()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),

      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  bool? isLog;
  var userss;





 @override
  void initState() {

  setState(() {
   // isLoggedIn = Provider.of<LocalStorageHelper>(context,listen: false).getValue('isLoggedIn') ?? 'false';

  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('MAIN');
    print(LocalStorageHelper.getValue('isLoggedIn'));
    return MaterialApp(
      title: 'Construction App',
      debugShowCheckedModeBanner: false,
      //theme: NittivTheme().lightTheme,
      home:   Login() ,

      onGenerateRoute:  RouteGenerator.generateRoute,
      initialRoute: RoutesName.LOGIN_URL,
    //   initialRoute: '/login',
    //   routes: {
    //
    //     "/login": (context) => Login(),
    //     "/home": (context) => DashBoardScreen(),
    //   },
    //   builder:  (context, child) {
    // return Consumer<AuthProvider>(
    // child: child,
    // builder: (context, provider, child) {
    //   bool value = provider.isLoggedIn;
    //   if (value == false) {
    //     print("LOGINPAGE");
    //     return Navigator(
    //       onGenerateRoute: RouteGenerator.generateRoutes,
    //       // onGenerateRoute: (settings) => MaterialPageRoute(
    //       //     settings: settings, builder: (context) => Login()),
    //     );
    //
    //   }else{
    //
    //     print("HOMEPAGEs");
    //     return Navigator(
    //         onGenerateRoute: RouteGenerator.generateRoute,
    //       // onGenerateRoute: (settings) => MaterialPageRoute(
    //       //     settings: settings, builder: (context) => DashBoardScreen()),
    //     );
    //   }
    //
    //
    // });
    //   },

    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth-provider.dart';
import '../../controllers/local-storage.dart';
import '../../router/routes-name.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: 400, width: 1000),
        child: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) {
              // if the screen width >= 480 i.e Wide Screen
              if (constraints.maxWidth >= 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    constraints.maxWidth >= 1000 ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login You Personal Account',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Colors.blue, letterSpacing: .5,fontSize: 18),
                          ),),
                        Container(
                          width: 400,

                          child: SvgPicture.asset(
                            'assets/images/login-bg-image.svg',

                          ),
                        ),
                      ],
                    ) : SizedBox.shrink(),
                    containerTextField(context),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: containerTextField(context),
                );
              }
            }),


      ),);
  }
  Container containerTextField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50,bottom: 50),
      width: 600,
      height: 450,

      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 100,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 50,),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.green,
                  maximumSize: const Size.fromHeight(150),
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  context.read<AuthProvider>().login(emailController.text,passwordController.text, context);
                  LocalStorageHelper.saveValue('isLoggedIn', 'true');
                 // context.read<LocalStorageHelper>().saveValue('isLoggedIn', 'true');
                },
                child: Text("LOGIN")),

            SizedBox(height: 50,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Dont have an account?'),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamed(RoutesName.REGISTER_URL);
              }, child: Text('Sign up here...',
                  style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
              ),),),
            ],)
          ],
        ),
      ),
    );
  }
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Login"),
    //     ),
    //     body: Container(
    //       color: Colors.grey[300],
    //       margin: EdgeInsets.only(left: 400,right: 400,top: 50,bottom: 50),
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //
    //           TextField(
    //             controller: emailController,
    //             decoration: InputDecoration(
    //               hintText: 'Email',
    //               filled: true,
    //               fillColor: Colors.grey[100],
    //               border: OutlineInputBorder(
    //                   borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
    //             ),
    //           ),
    //           TextField(
    //             controller: passwordController,
    //             decoration: InputDecoration(
    //               hintText: 'Password',
    //               filled: true,
    //               fillColor: Colors.grey[100],
    //               border: OutlineInputBorder(
    //                   borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
    //             ),
    //           ),
    //           OutlinedButton(
    //               onPressed: () {
    //
    //                 context.read<AuthProvider>().login(emailController.text,passwordController.text, context);
    //               },
    //               child: Text("LOGIN")),
    //
    //
    //           OutlinedButton(
    //               onPressed: () {
    //
    //                 Navigator.of(context).pushNamed(RoutesName.REGISTER_URL);
    //               },
    //               child: Text("REGISTER")),
    //         ],
    //       ),
    //     ));
  }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth-provider.dart';
import '../../models/user-model.dart';
import '../../router/routes-name.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: 600, width: 1000),
          child : LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {

        // if the screen width >= 480 i.e Wide Screen
        if (constraints.maxWidth >= 800) {

          return   Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              constraints.maxWidth >= 1000  ? Container(
                width: 400,

                child:   SvgPicture.asset(
                  'assets/images/register-bg-image.svg',

                ),
              ) : SizedBox.shrink(),
              containerTextField(context),
            ],
          );
        }else{
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: containerTextField(context),
          );
        }}),


      ),
    );
  }

  Container containerTextField(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: 50,bottom: 50),
              width: 600,

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
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'First Name',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Last Name',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: 20,),
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
                          UserModel userModel = UserModel()
                            ..firstName = firstNameController.text
                            ..lastName = lastNameController.text
                            ..email = emailController.text
                            ..password = passwordController.text
                            ..birthDate = ""
                            ..gender = ""
                            ..imageUrl =
                                "https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8="
                            ..userType = "Admin"
                            ..geoLocation = {
                              'latitude': "",
                              'longitude': "",
                            };

                          context.read<AuthProvider>().register(userModel, context);
                        },
                        child: Text("REGISTER")),

                    SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(onPressed: (){
                          Navigator.of(context).pushNamed(RoutesName.LOGIN_URL);
                        }, child: Text('Login here...',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
                          ),),),
                      ],)
                  ],
                ),
              ),
            );
  }
}

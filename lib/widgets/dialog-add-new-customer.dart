

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller.dart';
import '../controllers/customer-provider.dart';
import '../controllers/service.dart';
import '../models/customer-model.dart';
import '../screens/customer/customer-ui.dart';

class ShowDialogAddCustomer {

  static Future<void> showInformationDialog(BuildContext context) async {


    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController contact = TextEditingController();



    return await showDialog(
        context: context,
        builder: (context) {

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: 600,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        TextFormField(
                          controller: firstName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "First Name",labelText: 'Customer Name',hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: lastName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Last Name",labelText: 'Last Name',hintStyle: TextStyle(fontSize: 12)),
                        ),

                        TextFormField(
                          controller: address,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Address",labelText: 'Address',hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: contact,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Contact",labelText: 'Contact',hintStyle: TextStyle(fontSize: 12)),
                        ),



                      ],
                    )),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Add New Project'),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),)
                ],
              ),
              actions: <Widget>[

                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.green,
                      maximumSize: const Size.fromHeight(150),
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        CustomerModel userModel = CustomerModel()
                          ..firstName = firstName.text
                          ..lastName = lastName.text
                          ..address = address.text
                          ..phoneNumber = contact.text
                          ..birthDate = ""
                          ..gender = ""
                          ..imageUrl =
                              "https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8="
                          ..userType = "Admin"
                          ..geoLocation = {
                            'latitude': "",
                            'longitude': "",
                          };

                        context.read<CustomerProvider>().addNewCustomer(userModel, context);
                        context.read<Controller>().setIndexContentPage(1);

                      }
                    },
                    child: Text("Add New Customer")),

              ],
            );
          });
        });
  }
}
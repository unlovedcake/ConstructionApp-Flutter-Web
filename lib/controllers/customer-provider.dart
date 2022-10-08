

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/customer-model.dart';
import '../widgets/progress-dialog.dart';

class CustomerProvider extends ChangeNotifier {



  addNewCustomer(CustomerModel customerModel,BuildContext context)async{


    try{

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Processing...",
            );
          });

      await FirebaseFirestore.instance
          .collection("table-customer")
          .add(customerModel.toMap())
          .then((uid) async {


        CustomerModel userData = CustomerModel(
            docID: customerModel.docID,
            firstName: customerModel.firstName,
            lastName: customerModel.lastName,
            address: customerModel.address,
            phoneNumber: customerModel.phoneNumber,
            email: customerModel.email,
            password: customerModel.password,
            gender: customerModel.gender,
            birthDate: customerModel.birthDate,
            userType: customerModel.userType,
            imageUrl: customerModel.imageUrl);




        //Navigator.of(context).pushNamed(RoutesName.HOME_URL);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "New Customer Added Successfully. ",
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.CENTER_RIGHT,
        );
      });
      notifyListeners();
    }catch(e){

    }

  }

}
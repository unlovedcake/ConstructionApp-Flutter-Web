import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller.dart';
import '../controllers/customer-provider.dart';
import '../controllers/service.dart';
import '../models/customer-model.dart';
import '../screens/customer/customer-ui.dart';
import 'loading-dialog.dart';

class DialogUpdateCustomer {
  static Future<void> showInformationDialog(
      BuildContext context, CustomerModel customer) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController firstName =
        TextEditingController(text: customer.firstName);
    final TextEditingController lastName =
        TextEditingController(text: customer.lastName);
    final TextEditingController address =
        TextEditingController(text: customer.address);
    final TextEditingController contact =
        TextEditingController(text: customer.phoneNumber);

    FilePickerResult? result;
    Uint8List? file;
    FirebaseStorage storage = FirebaseStorage.instance;

    double progress = 0.0;

    String? imageUrlPost;

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


                        // Image.network(
                        //   customer.imageUrl.toString(),
                        //   width: 60,
                        //   height: 60,
                        // ),
                      file != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.memory(
                            file!,
                            fit: BoxFit.cover,
                            width: 60.0,
                            height: 60.0,
                          ),
                        )
                            : CachedNetworkImage(
                          imageUrl: customer.imageUrl.toString(),
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),

                        TextButton(
                            onPressed: () async {
                              result = await FilePicker.platform.pickFiles();
                              setState((){
                                file = result?.files.first.bytes;
                              });
                            },
                            child: Text("Upload Image")),
                        TextFormField(
                          controller: firstName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration: InputDecoration(
                              hintText: "First Name",
                              labelText: 'Customer Name',
                              hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: lastName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration: InputDecoration(
                              hintText: "Last Name",
                              labelText: 'Last Name',
                              hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: address,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration: InputDecoration(
                              hintText: "Address",
                              labelText: 'Address',
                              hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: contact,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration: InputDecoration(
                              hintText: "Contact",
                              labelText: 'Contact',
                              hintStyle: TextStyle(fontSize: 12)),
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
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  )
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (result != null) {

                          String fileName = result?.files.first.name ?? "";

                          try {
                            Reference ref =
                                storage.ref().child('Post-Images/$fileName');

                            UploadTask? uploadTask = ref.putData(
                              file!,
                              SettableMetadata(contentType: 'image/png'),
                            );

                            await uploadTask.then((_) async {
                              imageUrlPost = await ref.getDownloadURL();
                            });
                            // TaskSnapshot upload = await FirebaseStorage.instance
                            //     .ref(
                            //     'Post-Images/$fileName')
                            //     .putData(
                            //   file!,
                            //   SettableMetadata(contentType: 'image/png'),
                            // );
                            //
                            //
                            //
                            // imageUrlPost = await upload.ref.getDownloadURL();

                            print(imageUrlPost);
                          } catch (e) {}

                          // UploadTask task = FirebaseStorage.instance
                          //     .ref()
                          //     .child("files/$fileName")
                          //     .putData(file!);
                          //
                          // task.snapshotEvents.listen((event) {
                          //   setState(() {
                          //     progress = ((event.bytesTransferred.toDouble() /
                          //         event.totalBytes.toDouble()) *
                          //         100)
                          //         .roundToDouble();
                          //
                          //     if (progress == 100) {
                          //       event.ref
                          //           .getDownloadURL()
                          //           .then((downloadUrl){
                          //         print(downloadUrl);
                          //       });
                          //     }
                          //
                          //
                          //   });
                          // });
                        }

                        CustomerModel userModel = CustomerModel()
                          ..docID = customer.docID
                          ..firstName = firstName.text
                          ..lastName = lastName.text
                          ..address = address.text
                          ..phoneNumber = contact.text
                          ..birthDate = ""
                          ..gender = ""
                          ..imageUrl = imageUrlPost ?? customer.imageUrl
                          ..userType = "Admin"
                          ..geoLocation = {
                            'latitude': "",
                            'longitude': "",
                          };

                        context
                            .read<CustomerProvider>()
                            .updateCustomer(userModel, context);

                        LoadingDialog.isLoading(context);
                        context.read<Controller>().setIndexContentPage(1);
                      }
                    },
                    child: Text("Update Customer")),
              ],
            );
          });
        });
  }
}

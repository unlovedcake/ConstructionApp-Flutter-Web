

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/customer-provider.dart';
import '../models/customer-model.dart';

class ShowDialogAddNewProject {

  static Future<void> showInformationDialog(BuildContext context) async {


    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController projectName = TextEditingController();
    final TextEditingController customerName = TextEditingController();
    final TextEditingController location = TextEditingController();
    final TextEditingController contractCost = TextEditingController();
    final TextEditingController downPayment = TextEditingController();
    final TextEditingController retention = TextEditingController();
    final TextEditingController dateStart = TextEditingController();
    final TextEditingController dateFinish = TextEditingController();

    double totalAmountPercent = 0.0;
    double totalRetentionPercent = 0.0;
    var formatter = NumberFormat('#,###');

    Row showCalendar(String label,BuildContext context, StateSetter setState,TextEditingController controller, bool isStart) {
      return Row(children: [
        SizedBox(
          width: 200,
          child: TextField(
              controller: controller, //editing controller of this TextField
              decoration:  InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: label //label text of field
              ),
              readOnly: true,  // when true user cannot edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );

                if(pickedDate != null ){
                  print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  print(formattedDate); //formatted date output using intl package =>  2022-07-04
                  //You can format date as per your need

                  var formatter = new DateFormat('MMM - dd - yyyy');
                  String formatted = formatter.format(pickedDate);

                  setState(() {
                    if(isStart) {
                      dateStart.text = formatted;
                    }else{
                      dateFinish.text = formatted;
                    }//set foratted date to TextField value.
                  });
                }else{
                  print("Date is not selected");
                }
              }
          ),
        )
      ],);
    }


    return await showDialog(
        context: context,
        builder: (context) {
          bool? isChecked = false;
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
                          controller: projectName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Project Name",labelText: 'Project Name',hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: projectName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Customer Name",labelText: 'Customer Name',hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: projectName,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Location",labelText: 'Location',hintStyle: TextStyle(fontSize: 12)),
                        ),
                        TextFormField(
                          controller: contractCost,
                          validator: (value) {
                            return value!.isNotEmpty ? null : "Enter any text";
                          },
                          decoration:
                          InputDecoration(hintText: "Contract Cost"),
                        ),
                        Row(

                          children: [
                            SizedBox(
                              width: 260,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: downPayment,
                                validator: (value) {
                                  return value!.isNotEmpty ? null : "Enter any text";
                                },
                                onChanged: (value){

                                  double paymentPercent =  double.parse(value);
                                  double contractCosts =  double.parse(contractCost.text);

                                  setState(() {
                                    totalAmountPercent = contractCosts.toDouble() / 100 * paymentPercent.toDouble();
                                  });
                                  print(value);
                                },
                                decoration:
                                InputDecoration(hintText: "Enter Down Payment %"),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                                width: 110,
                                //child: Text('$totalAmountPercent'),
                                child: Text('${formatter.format(totalAmountPercent.toInt())}'.replaceAll(' ',', '))
                            ),
                          ],
                        ),

                        Row(

                          children: [
                            SizedBox(
                              width: 260,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: retention,
                                validator: (value) {
                                  return value!.isNotEmpty ? null : "Enter any text";
                                },
                                onChanged: (value){

                                  double retentionPercent =  double.parse(value);
                                  double contractCosts =  double.parse(contractCost.text);

                                  setState(() {
                                    totalRetentionPercent = contractCosts.toDouble() / 100 * retentionPercent.toDouble();
                                  });
                                  print(value);
                                },
                                decoration:
                                InputDecoration(hintText: "Retention %"),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                                width: 110,
                                //child: Text('$totalAmountPercent'),
                                child: Text('${formatter.format(totalRetentionPercent.toInt())}'.replaceAll(' ',', '))
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            showCalendar('Date Start',context, setState,dateStart,true),
                            showCalendar('Date Finish',context, setState,dateFinish,false),
                          ],
                        ),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Choice Box"),
                            Checkbox(
                                value: isChecked,
                                onChanged: (checked) {
                                  setState(() {
                                    isChecked = checked;
                                  });
                                })
                          ],
                        )
                      ],
                    )),
              ),
              title: Text('Add New Project'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

}
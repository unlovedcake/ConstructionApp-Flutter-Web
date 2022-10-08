import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/models/customer-model.dart';

import '../../controllers/service.dart';
import '../../widgets/dialog-add-new-customer.dart';

class CustomerUIDESIGN extends StatefulWidget {
  CustomerUIDESIGN({Key? key}) : super(key: key);

  @override
  State<CustomerUIDESIGN> createState() => _CustomerUIDESIGNState();
}

class _CustomerUIDESIGNState extends State<CustomerUIDESIGN> {
  late Stream<QuerySnapshot> getData;

  List customer = [];

  // StreamSubscription<QuerySnapshot<Map<String, dynamic>>> getCustomers() {
  //   return FirebaseFirestore.instance
  //       .collection("table-customer")
  //       .snapshots()
  //       .listen((result) {
  //     result.docs.forEach((doc) {
  //       CustomerModel customerModel = CustomerModel(
  //           firstName: doc.data()['firstName'],
  //           address: doc.data()['address'],
  //           phoneNumber: doc.data()['phoneNumber']);
  //
  //       customer.add(customerModel.toMap());
  //     });
  //   });
  // }
  CustomerModel customerModel = CustomerModel();

  QuerySnapshot? querySnapshot;

  Future<QuerySnapshot> getCustomersList() {

    return FirebaseFirestore.instance
        .collection("table-customer")
        .get();


  }
  Future<List<CustomerModel>>? employeeList;
  List<CustomerModel>? retrievedEmployeeList;



  @override
  void initState() {
    getCustomersList();
    _initRetrieval();
    super.initState();
  }

  Future<void> _initRetrieval() async {
    employeeList = ServiceAPI.retrieveEmployees(5);
    retrievedEmployeeList = await ServiceAPI.retrieveEmployees(5);
    print(employeeList.toString());

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Customer List",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              OutlinedButton(
                onPressed: () {
                  ShowDialogAddCustomer.showInformationDialog(context);
                },
                child: Text('Add New Customer'),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Column(

              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 250,),
                    Text(
                      "Address",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 250,),
                    Text(
                      "Contact",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 250,),
                    Text(
                      "Action",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  //   child:  ListView.builder(
                  // itemCount: customer.length,
                  //   itemBuilder: (_, index) {
                  //
                  //
                  //     return SizedBox(
                  //       child: Row(
                  //
                  //         children: [
                  //           Text(
                  //               customer[index]['firstName']),
                  //           Spacer(),
                  //           Text(
                  //               customer[index]['address']),
                  //           Spacer(),
                  //           Text(
                  //             customer[index]['phoneNumber'],textAlign: TextAlign.center,),
                  //           Spacer(),
                  //           OutlinedButton(onPressed: (){}, child: Text('Edit')),
                  //           OutlinedButton(onPressed: (){}, child: Text('Delete'))
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),

                  // child: StreamBuilder<QuerySnapshot>(
                  //   stream: context.watch<Controller>().getCustomers(),
                  //       //FirebaseFirestore.instance.collection("table-customer").snapshots(),
                  //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     switch (snapshot.connectionState) {
                  //       case ConnectionState.none:
                  //         return Text('No Data');
                  //       case ConnectionState.waiting:
                  //         return Center(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: <Widget>[
                  //               Text("Loading..."),
                  //               SizedBox(
                  //                 height: 50.0,
                  //               ),
                  //               CircularProgressIndicator()
                  //             ],
                  //           ),
                  //         );
                  //       case ConnectionState.active:
                  //         return ListView.builder(
                  //           itemCount: snapshot.data?.docs.length,
                  //           itemBuilder: (_, index) {
                  //             final data = snapshot.data!.docs[index];
                  //
                  //             return Column(
                  //                 children:<Widget>[
                  //
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Table(
                  //
                  //                       // textDirection: TextDirection.rtl,
                  //                       // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  //                       // border:TableBorder.all(width: 2.0,color: Colors.red),
                  //                       children: [
                  //                         TableRow(
                  //                             children: [
                  //                               Text(data['firstName'],textScaleFactor: 1.2,),
                  //                               Text(data['firstName'],textScaleFactor: 1.2),
                  //                               Text(data['firstName'],textScaleFactor: 1.2),
                  //
                  //                               Wrap(
                  //
                  //                                 children: [
                  //                                 OutlinedButton(onPressed: (){}, child: Text('Edit')),
                  //                                 OutlinedButton(onPressed: (){}, child: Text('Delete')),
                  //                               ],)
                  //                             ]
                  //                         ),
                  //
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ]
                  //             );
                  //           },
                  //         );
                  //
                  //       default:
                  //         return Container();
                  //     }
                  //
                  //     // if (snapshot.hasError) {
                  //     //   return new Text('Error: ${snapshot.error}');
                  //     // }
                  //     // if (snapshot.connectionState == ConnectionState.waiting) {
                  //     //   return Center(
                  //     //     child: Column(
                  //     //       mainAxisAlignment: MainAxisAlignment.center,
                  //     //       crossAxisAlignment: CrossAxisAlignment.center,
                  //     //       children: <Widget>[
                  //     //         Text("Loading..."),
                  //     //         SizedBox(
                  //     //           height: 50.0,
                  //     //         ),
                  //     //         CircularProgressIndicator()
                  //     //       ],
                  //     //     ),
                  //     //   );
                  //     // } else {
                  //     //   return ListView.builder(
                  //     //     itemCount: snapshot.data?.docs.length,
                  //     //     itemBuilder: (_, index) {
                  //     //
                  //     //       final data =  snapshot.data!.docs[index];
                  //     //       return SizedBox(
                  //     //         child: Row(
                  //     //
                  //     //           children: [
                  //     //             Text(
                  //     //                 data['firstName']),
                  //     //             Spacer(),
                  //     //             Text(
                  //     //                 data['address']),
                  //     //             Spacer(),
                  //     //             Text(
                  //     //                 data['phoneNumber'],textAlign: TextAlign.center,),
                  //     //             Spacer(),
                  //     //             OutlinedButton(onPressed: (){}, child: Text('Edit')),
                  //     //             OutlinedButton(onPressed: (){}, child: Text('Delete'))
                  //     //           ],
                  //     //         ),
                  //     //       );
                  //     //     },
                  //     //   );
                  //     // }
                  //   },
                  // ),


                  child: FutureBuilder(
                      future: employeeList,
                      builder:
                          (BuildContext context, AsyncSnapshot<List<CustomerModel>> snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {

                          return ListView.separated(
                              itemCount: retrievedEmployeeList!.length,
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Text(retrievedEmployeeList![index].firstName.toString());
                              });
                        } else if (snapshot.connectionState == ConnectionState.done &&
                            retrievedEmployeeList!.isEmpty) {
                          return Center(
                            child: ListView(
                              children: const <Widget>[
                                Align(alignment: AlignmentDirectional.center,
                                    child: Text('No data available')),
                              ],
                            ),
                          );
                        }else {
                          return const Center(child: CircularProgressIndicator());
                        }}),

                  // child:FutureBuilder(
                  //   future:  getCustomersList(),
                  //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.done) {
                  //       return ListView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: snapshot.data?.docs.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return Card(
                  //               child: ListTile(
                  //                 leading: Text('${snapshot.data?.docs[index]['firstName'].toString()}'),
                  //               ),
                  //             );
                  //           });
                  //     } else if (snapshot.connectionState == ConnectionState.none) {
                  //       return Text("No data");
                  //     }
                  //     return CircularProgressIndicator();
                  //   },
                  // ),
                ),
              ])
        ],
      ),
    );
  }

  Row displayListCustomers(QueryDocumentSnapshot<Object?> data) {
    return Row(
      children: [
        Container(
          width: 380,
          child: Text(data['firstName']),
        ),
        Container(
          width: 380,
          child: Text(data['address']),
        ),
        Container(
          width: 300,
          child: Text(
              'asdadadadada adasdadada adadasdadadsadadsa adada '),
        ),
        Spacer(),
        OutlinedButton(onPressed: () {}, child: Text('Edit')),
        OutlinedButton(onPressed: () {}, child: Text('Delete'))
      ],
    );
  }
}

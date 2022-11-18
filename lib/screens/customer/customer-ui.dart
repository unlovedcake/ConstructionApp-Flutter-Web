import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/controllers/customer-provider.dart';
import 'package:responsive_admin_dashboard/models/customer-model.dart';

import '../../controllers/service.dart';
import '../../widgets/dialog-add-new-customer.dart';
import '../../widgets/dialog-update-customer.dart';

class CustomerUI extends StatefulWidget {
  CustomerUI({Key? key}) : super(key: key);

  @override
  State<CustomerUI> createState() => _CustomerUIState();
}

class _CustomerUIState extends State<CustomerUI> {
  Future<List<CustomerModel>>? employeeList;
  List<CustomerModel>? retrievedEmployeeList;

  late ScrollController _controller;

  int _limit = 8;
  bool _hasNextPage = true;

  bool _isFirstLoadRunning = false;

  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  @override
  void initState() {
    super.initState();
    _initRetrieval();
    _controller = ScrollController()..addListener(_loadMore);
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      _limit = _limit + 5;

      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      try {
        if (retrievedEmployeeList!.length <= _limit) {
          employeeList = ServiceAPI.retrieveEmployees(_limit);
          retrievedEmployeeList = await ServiceAPI.retrieveEmployees(_limit);

          setState(() {});
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  Future<void> _initRetrieval() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      employeeList = ServiceAPI.retrieveEmployees(_limit);
      retrievedEmployeeList = await ServiceAPI.retrieveEmployees(_limit);
    } catch (e) {}

    print(employeeList.toString());
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('BUILD');
    _initRetrieval();
    return Container(
      height: 600,
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
          Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("table-customer").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: DataTable2(
                                  scrollController: _controller,
                                  columnSpacing: 12,
                                  horizontalMargin: 12,
                                  minWidth: 600,
                                  columns: [
                                    DataColumn(
                                      label: Text('Image'),

                                    ),
                                    DataColumn2(
                                      label: Text('Name'),
                                      size: ColumnSize.L,
                                    ),
                                    DataColumn(
                                      label: Text('Address'),
                                    ),
                                    DataColumn(
                                      label: Text('Contact'),
                                    ),
                                    DataColumn(
                                      label: Text('Action'),
                                    ),
                                  ],

                                  rows: List<DataRow>.generate(
                                      snapshot.data!.docs.length,
                                          (index) {

                                            final DocumentSnapshot data =
                                            snapshot.data!.docs[index];

                                            return DataRow(
                                          cells: [
                                            DataCell(Image.network(data.get('imageUrl')
                                                .toString())),
                                            DataCell(Text(data.get('firstName')
                                                .toString())),
                                            DataCell(Text(data.get('address')
                                                .toString())),
                                            DataCell(Text(data.get('phoneNumber')
                                                .toString())),
                                            DataCell(Row(
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {

                                                    DialogUpdateCustomer.showInformationDialog(context, retrievedEmployeeList![index]);
                                                  },
                                                  child: Text('Edit'),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {

                                                    context.read<CustomerProvider>().deleteCustomer( retrievedEmployeeList![index], context);
                                                    print('DELETE');
                                                  },
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            )),
                                          ]);})),
                            ),
                          ),


                        ],
                      );

                    } else if (snapshot.connectionState == ConnectionState.done &&
                        retrievedEmployeeList!.isEmpty) {
                      return Center(
                        child: ListView(
                          children: const <Widget>[
                            Align(
                                alignment: AlignmentDirectional.center,
                                child: Text('No data available')),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              // child: FutureBuilder(
              //     future: employeeList,
              //     builder: (BuildContext context,
              //         AsyncSnapshot<List<CustomerModel>> snapshot) {
              //       if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              //         return Column(
              //           children: [
              //             Expanded(
              //               child: Padding(
              //                 padding: const EdgeInsets.all(16),
              //                 child: DataTable2(
              //                   scrollController: _controller,
              //                     columnSpacing: 12,
              //                     horizontalMargin: 12,
              //                     minWidth: 600,
              //                     columns: [
              //                       DataColumn(
              //                         label: Text('Image'),
              //
              //                       ),
              //                       DataColumn2(
              //                         label: Text('Name'),
              //                         size: ColumnSize.L,
              //                       ),
              //                       DataColumn(
              //                         label: Text('Address'),
              //                       ),
              //                       DataColumn(
              //                         label: Text('Contact'),
              //                       ),
              //                       DataColumn(
              //                         label: Text('Action'),
              //                       ),
              //                     ],
              //
              //                     rows: List<DataRow>.generate(
              //                         retrievedEmployeeList!.length,
              //                         (index) => DataRow(
              //                             cells: [
              //                               DataCell(Image.network(retrievedEmployeeList![index]
              //                                   .imageUrl
              //                                   .toString())),
              //                               DataCell(Text(retrievedEmployeeList![index]
              //                                   .firstName
              //                                   .toString())),
              //                               DataCell(Text(retrievedEmployeeList![index]
              //                                   .address
              //                                   .toString())),
              //                               DataCell(Text(retrievedEmployeeList![index]
              //                                   .phoneNumber
              //                                   .toString())),
              //                               DataCell(Row(
              //                                 children: [
              //                                   OutlinedButton(
              //                                     onPressed: () {
              //
              //                                       DialogUpdateCustomer.showInformationDialog(context, retrievedEmployeeList![index]);
              //                                     },
              //                                     child: Text('Edit'),
              //                                   ),
              //                                   OutlinedButton(
              //                                     onPressed: () {
              //
              //                                       context.read<CustomerProvider>().deleteCustomer( retrievedEmployeeList![index], context);
              //                                       print('DELETE');
              //                                     },
              //                                     child: Text('Delete'),
              //                                   ),
              //                                 ],
              //                               )),
              //                             ]))),
              //               ),
              //             ),
              //             if (_isLoadMoreRunning == true)
              //               const Padding(
              //                 padding: EdgeInsets.only(top: 10, bottom: 40),
              //                 child: Center(
              //                   child: CircularProgressIndicator(),
              //                 ),
              //               ),
              //
              //             // When nothing else to load
              //             if (_hasNextPage == false)
              //               Container(
              //                 padding: const EdgeInsets.only(top: 30, bottom: 40),
              //                 color: Colors.amber,
              //                 child: const Center(
              //                   child: Text('You have fetched all of the content'),
              //                 ),
              //               ),
              //
              //           ],
              //         );
              //
              //
              //         // return !_isFirstLoadRunning
              //         //     ? const Center(
              //         //         child: const CircularProgressIndicator(),
              //         //       )
              //         //     : Column(
              //         //         children: [
              //         //           Expanded(
              //         //             child: ListView.builder(
              //         //               controller: _controller,
              //         //               itemCount: retrievedEmployeeList!.length,
              //         //               itemBuilder: (_, index) => Card(
              //         //                 margin: const EdgeInsets.symmetric(
              //         //                     vertical: 8, horizontal: 10),
              //         //                 child: ListTile(
              //         //                   title: Text(retrievedEmployeeList![index]
              //         //                       .firstName
              //         //                       .toString()),
              //         //                   subtitle: Text(retrievedEmployeeList![index]
              //         //                       .firstName
              //         //                       .toString()),
              //         //                 ),
              //         //               ),
              //         //             ),
              //         //           ),
              //         //
              //         //           // when the _loadMore function is running
              //         //           if (_isLoadMoreRunning == true)
              //         //             const Padding(
              //         //               padding: EdgeInsets.only(top: 10, bottom: 40),
              //         //               child: Center(
              //         //                 child: CircularProgressIndicator(),
              //         //               ),
              //         //             ),
              //         //
              //         //           // When nothing else to load
              //         //           if (_hasNextPage == false)
              //         //             Container(
              //         //               padding: const EdgeInsets.only(top: 30, bottom: 40),
              //         //               color: Colors.amber,
              //         //               child: const Center(
              //         //                 child: Text('You have fetched all of the content'),
              //         //               ),
              //         //             ),
              //         //         ],
              //         //       );
              //       } else if (snapshot.connectionState == ConnectionState.done &&
              //           retrievedEmployeeList!.isEmpty) {
              //         return Center(
              //           child: ListView(
              //             children: const <Widget>[
              //               Align(
              //                   alignment: AlignmentDirectional.center,
              //                   child: Text('No data available')),
              //             ],
              //           ),
              //         );
              //       } else {
              //         return const Center(child: CircularProgressIndicator());
              //       }
              //     }),
            ),
          ])
        ],
      ),
    );
  }
}

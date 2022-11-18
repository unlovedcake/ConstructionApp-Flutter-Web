import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/widgets/progress-dialog.dart';

class LoadingDialog {

  static void isLoading(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Processing...",
          );
        });
  }
}
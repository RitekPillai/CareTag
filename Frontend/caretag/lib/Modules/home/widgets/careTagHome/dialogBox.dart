import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/custom_alert_box.dart';
import 'package:caretag/Modules/home/widgets/report/report_alertBox.dart';
import 'package:caretag/main.dart';
import 'package:flutter/material.dart';

void showDialogBox(
  Permissionrequestmodel permissionRequestModel, [
  bool isReport = false,
]) {
  showDialog(
    context: navigatorKey
        .currentState!
        .overlay!
        .context, // navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return !isReport
          ? CustomAlertBox(permissionRequestModel: permissionRequestModel)
          : ReportAlertbox(permissionrequestmodel: permissionRequestModel);
    },
  );
}

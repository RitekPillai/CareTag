import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/watch/watchpairing.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetoothservice {
  Future<void> handlePermission(
    BuildContext context,
    PatientBloc paintentBloc,
  ) async {
    List<Permission> permission = [
      Permission.bluetoothConnect,
      Permission.bluetoothConnect,
      Permission.location,
    ];
    Map<Permission, PermissionStatus> status = await permission.request();

    bool allgranted = status.values.every((status) => status.isGranted);
    if (allgranted) {
      if (await FlutterBluePlus.adapterState.first ==
          BluetoothAdapterState.on) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            customRoute(Watchpairing(), paintentBloc),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please turn on Bluetooth")),
          );
        }
      }
    } else {
      // Permissions Denied
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Permissions Denied - Cannot find watch"),
          ),
        );
      }
    }
  }

  Future<void> startScanning() async {
    debugPrint("inside");
    // 1. Set up the listener first
    var subscription = FlutterBluePlus.onScanResults.listen((results) {
      for (ScanResult r in results) {
        // Some devices have empty names in the advertisement packet
        String name = r.advertisementData.advName.isEmpty
            ? "Unknown"
            : r.advertisementData.advName;
        print('${r.device.remoteId}: "$name" found!');
      }
    }, onError: (e) => print("Scan Error: $e"));

    // 2. NOW start the actual scan
    await FlutterBluePlus.startScan(
      timeout: Duration(seconds: 15),
      androidUsesFineLocation: true, // Specific for your Android 11 device
    );
  }
}

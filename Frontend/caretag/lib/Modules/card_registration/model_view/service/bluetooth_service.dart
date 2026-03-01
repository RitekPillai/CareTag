import 'dart:async';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/watch/watchpairing.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooothservice {
  static const String hrServiceUuid = "180d";
  static const String hrCharUuid = "2a37";

  Future<void> handlePermission(
    BuildContext context,
    PatientBloc paintentBloc,
  ) async {
    List<Permission> permissions = [
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ];
    Map<Permission, PermissionStatus> status = await permissions.request();

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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Permissions Denied - Cannot find watch"),
          ),
        );
      }
    }
  }

  Future<int> getSteps(String remoteId) async {
    BluetoothDevice device = BluetoothDevice.fromId(remoteId);
    int steps = 0;
    if (!device.isConnected) {
      await device
          .connect(autoConnect: false, license: License.free)
          .timeout(Duration(seconds: 5));
    }
    try {
      await device
          .connect(autoConnect: false, license: License.free)
          .timeout(Duration(seconds: 5));

      List<BluetoothService> services = await device.discoverServices();

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString().contains("ff01") ||
              characteristic.uuid.toString().contains("1814")) {
            List<int> value = await characteristic.read();

            steps = _convertBytesToInt(value);
          }
        }
      }
    } catch (e) {
      debugPrint("Step Fetch Error: $e");
    }
    return steps;
  }

  int _convertBytesToInt(List<int> value) {
    if (value.isEmpty) return 0;
    return value[0] + (value[1] << 8) + (value[2] << 16) + (value[3] << 24);
  }

  Stream<int> connectAndStreamHR(String remoteId) async* {
    BluetoothDevice device = BluetoothDevice.fromId(remoteId);

    try {
      // 1. Force a clean state: Disconnect first if stuck
      if (device.isConnected) {
        await device.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }

      debugPrint("Starting clean connection attempt...");

      // 2. The "Direct" connection
      await device.connect(
        autoConnect: false,
        timeout: const Duration(seconds: 10),
        license: License.free,
      );

      // 3. Wait for Android to stabilize the connection
      await Future.delayed(const Duration(seconds: 1));

      List<BluetoothService> services = await device.discoverServices();

      // 4. Find Service & Char (using standard UUIDs)
      var hrService = services.firstWhere(
        (s) => s.uuid.toString().contains("180d"),
      );
      var hrChar = hrService.characteristics.firstWhere(
        (c) => c.uuid.toString().contains("2a37"),
      );

      // 5. Wake up the stream
      await hrChar.setNotifyValue(true);

      yield* hrChar.onValueReceived.map((value) {
        if (value.isNotEmpty && value.length > 1) return value[1];
        return 0;
      });
    } catch (e) {
      debugPrint("CLEANUP ERROR: $e");
      // If we get 133, the stream effectively closes.
    }
  }

  Future<void> startScanning() async {
    debugPrint("Starting Scan...");
    // var subscription = FlutterBluePlus.onScanResults.listen((results) {
    //   for (ScanResult r in results) {
    //     String name = r.advertisementData.advName.isEmpty
    //         ? "Unknown"
    //         : r.advertisementData.advName;
    //     print('${r.device.remoteId}: "$name" found!');
    //   }
    // }, onError: (e) => print("Scan Error: $e"));

    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
      androidUsesFineLocation: true,
    );
  }
}

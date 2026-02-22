import 'dart:async';

import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/subscription/subscription_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/helpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class Watchpairing extends StatefulWidget {
  const Watchpairing({super.key});

  @override
  State<Watchpairing> createState() => _WatchpairingState();
}

class _WatchpairingState extends State<Watchpairing> {
  List<BluetoothDevice> systemDevices = [];
  List<ScanResult> scanResults = [];
  bool isScanning = false; // Track scanning state

  StreamSubscription? scanSubscription;
  StreamSubscription? isScanningSubscription;

  Storageservice storageservice = Storageservice();

  void _startScanProcces() async {
    setState(() {
      scanResults = [];
      systemDevices = [];
    });
    try {
      systemDevices = await FlutterBluePlus.systemDevices([
        Guid("180d"),
        Guid("180f"),
      ]);

      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
        androidUsesFineLocation: true,
      );

      scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        if (mounted) {
          setState(() {
            scanResults = results;
          });
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void startTheService() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    if (!isRunning) {
      // 2. Start the background service manually
      await service.startService();
      debugPrint("Background Service Started after Watch Registration");
    }
  }

  void connectToWatch(BluetoothDevice device) async {
    await FlutterBluePlus.stopScan();

    try {
      if (device.prevBondState != BluetoothConnectionState.connected) {
        await device.connect(
          license: License.free,
          autoConnect: false,
          timeout: const Duration(seconds: 15),
        );
      }

      await device.discoverServices();
      debugPrint("Watch Id: ${device.remoteId.str}");

      // --- FIX START ---
      // Check if box is open, if not, open it.
      Box box;
      if (Hive.isBoxOpen('health_vault')) {
        box = Hive.box('health_vault');
      } else {
        box = await Hive.openBox('health_vault');
      }

      await box.put('watchId', device.remoteId.str);
      // --- FIX END ---

      startTheService();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Connected to ${device.platformName.isEmpty ? 'Watch' : device.platformName}",
            ),
            backgroundColor: Colors.green,
          ),
        );

        _navigateToSubscription();
      }
    } catch (e) {
      debugPrint("Connection Error Details: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Storage Error: $e")));
      }
    }
  }

  void _navigateToSubscription() {
    try {
      Navigator.pushReplacement(
        context,
        customRoute(SubscriptionPage(), context.read<PatientBloc>()),
      );
    } catch (navError) {
      debugPrint("Navigation Error: $navError");
    }
  }

  @override
  void initState() {
    super.initState();

    isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      if (mounted) {
        setState(() {
          isScanning = state;
        });
      }
    });

    _startScanProcces();
  }

  @override
  void dispose() {
    scanSubscription?.cancel();
    isScanningSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(scanResults.length.toString());
    debugPrint(systemDevices.length.toString());
    bool showRetry =
        !isScanning && systemDevices.isEmpty && scanResults.isEmpty;

    return Scaffold(
      appBar: AppBar(actions: [help()]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Pairing with your device",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Please keep your smartwatch close and connected via Bluetooth.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColor.lightBlueTextColor2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          if (isScanning && systemDevices.isEmpty && scanResults.isEmpty)
            Expanded(
              child: Center(child: Lottie.asset("assets/videos/radar.json")),
            )
          else if (showRetry)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bluetooth_disabled,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No devices found",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  customElevatedButton(
                    50,
                    200,
                    "Retry Scan",
                    16,
                    FontWeight.bold,
                    _startScanProcces,
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView(
                children: [
                  if (systemDevices.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        "ALREADY PAIRED",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    ...systemDevices.map(
                      (d) => ListTile(
                        leading: const Icon(Icons.watch, color: Colors.blue),
                        title: Text(
                          d.platformName.isEmpty
                              ? "Connected Watch"
                              : d.platformName,
                        ),
                        trailing: customElevatedButton(
                          40,
                          100,
                          "Connect",
                          14,
                          FontWeight.w600,
                          () => connectToWatch(d),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                  if (scanResults.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        "AVAILABLE DEVICES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    ...scanResults.map(
                      (r) => ListTile(
                        leading: const Icon(Icons.bluetooth),
                        title: Text(
                          r.advertisementData.advName.isEmpty
                              ? "Unknown Device"
                              : r.advertisementData.advName,
                        ),
                        subtitle: Text(r.device.remoteId.toString()),

                        onTap: () => connectToWatch(r.device),
                      ),
                    ),
                  ],
                  if (isScanning)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

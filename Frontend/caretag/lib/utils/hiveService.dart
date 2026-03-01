import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/card_registration/data/model/registrationresponsemodel.dart';
import 'package:caretag/Modules/card_registration/model_view/service/bluetooth_service.dart';
import 'package:caretag/Modules/card_registration/model_view/service/cryptographyservice.dart';
import 'package:caretag/utils/storage_service.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@pragma('vm:entry-point')
class Hiveservice {
  final storageService = Storageservice();
  final cryptographyService = Cryptographyservice();
  Future<void> setupHive() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen('health_vault')) {
      await Hive.openBox('health_vault');
    }

    if (!Hive.isBoxOpen('decrypted_records')) {
      final encryptionKey = await storageService.getOrCreateLocalKey();
      await Hive.openBox(
        'decrypted_records',
        encryptionCipher: HiveAesCipher(encryptionKey),
      );
    }
    log("Hive Setup Complete");
  }

  Future<void> decryptAndSaveToHive(String jsonData) async {
    try {
      final box = Hive.box('decrypted_records');
      await box.put('latest_emergency_profile', jsonData);

      log(box.get('latest_emergency_profile'));

      log("Record successfully moved to secure local vault.");
    } catch (e) {
      log("Error:$e");
    }
  }

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'caretag_sync_channel',
      'CareTag Sync',
      description: 'Synchronizing health data',
      importance: Importance.low,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'caretag_sync_channel',
        initialNotificationTitle: 'CareTag Active',
        initialNotificationContent: 'Monitoring heart rate...',
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [AndroidForegroundType.connectedDevice],
      ),
      iosConfiguration: IosConfiguration(),
    );
  }

  static void _updateNotification(
    ServiceInstance service,
    dynamic hr,
    dynamic steps,
  ) {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "CareTag Live Sync",
        content: "Heart Rate: $hr BPM | Steps: $steps",
      );
    }
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    await Hive.initFlutter();

    final box = await Hive.openBox('health_vault');
    final bluetooth = Bluetooothservice();

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    String? savedId = box.get("watchId");

    if (savedId != null && savedId.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 2));

      bluetooth.connectAndStreamHR(savedId).listen((heartRate) {
        box.put('current_hr', heartRate);
        _updateNotification(
          service,
          heartRate,
          box.get('current_steps', defaultValue: 0),
        );
      });

      Timer.periodic(const Duration(minutes: 10), (timer) async {
        try {
          int steps = await bluetooth.getSteps(savedId);
          await box.put('current_steps', steps);

          _updateNotification(
            service,
            box.get('current_hr', defaultValue: 0),
            steps,
          );
        } catch (e) {
          log("Background Step Error: $e");
        }
      });
    }
  }
}

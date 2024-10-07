import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';

void main() {
  // app widgets binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // await native splash
   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const MyApp() // Wrap your app
      )
  );
}




import 'package:device_preview/device_preview.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:ecom/share/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nexus Shop',
      themeMode: ThemeMode.system,
      // device preview
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // end device preview
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      routeInformationProvider: CustomRoute.routes.routeInformationProvider,
      routeInformationParser: CustomRoute.routes.routeInformationParser,
      routerDelegate: CustomRoute.routes.routerDelegate,
    );
  }
}
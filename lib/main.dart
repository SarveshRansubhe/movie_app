import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config_main.dart';
import 'package:movie_app/src/presentation/routes/routes.dart';

void main() async {
  await configMain();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      routerConfig: RouteGenerator.router,
      theme: ThemeData(),
    );
  }
}

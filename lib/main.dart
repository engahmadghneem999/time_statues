import 'package:flutter/material.dart';
import 'package:time_status/core/service/service.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  MyServices();
  runApp(
    MyApp(),
  );
}

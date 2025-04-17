import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tocaantask/core/utils/constants/box_constants.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/presentation/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(HiveWeatherAdapter());
  await Hive.openBox<HiveWeather>(BoxConstants.weatherBox);

  setupGitItLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SafeArea(child: const MyHomePage()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';
import 'package:tocaantask/features/home/presentation/manger/location_cubit/location_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/get_user_location.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/home_body_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Delay entrance animation
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  String firstOpenAppLocation() {
    if (getit<Box<HiveWeather>>().get("weather")?.city == null) {
      return 'cairo';
    }
    return getit<Box<HiveWeather>>().get("weather")!.city;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  WeatherCubit(getit<WeatherRepo>())
                    ..getWeather(firstOpenAppLocation()),
        ),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => LocationCubit()),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              Assets.imagesHomeBackground,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            AnimatedSlide(
              duration: Duration(milliseconds: 900),
              offset: _isVisible ? Offset(0, 0.05) : Offset(0, 0.1),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _isVisible ? 1.0 : 0.0,
                child: SingleChildScrollView(child: Column(children: [HomeBodyState(), GetUserLocation()])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

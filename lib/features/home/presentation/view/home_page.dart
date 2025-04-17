import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/core/utils/theme/Styles.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit_state.dart';
import 'package:tocaantask/features/widgets/app_error_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              WeatherCubit(getit<WeatherRepo>())..getWeather('new york'),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              Assets.imagesHomeBackground,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 900),
              bottom: _isVisible ? 120 : 90,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _isVisible ? 1.0 : 0.0,
                child: HomeBodyState(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBodyState extends StatelessWidget {
  const HomeBodyState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Skeletonizer(child: HomeBodyData(weather: Weather.empty()));
        } else if (state is WeatherLoaded) {
          return HomeBodyData(weather: state.weather);
        } else if (state is WeatherError) {
          return Center(
            child: AppError(
              message: state.message,
              tryAgain: () => context.read<WeatherCubit>().getWeather('egypt'),
            ),
          );
        }
        return SizedBox(child: Text(state.toString()));
      },
    );
  }
}

class HomeBodyData extends StatelessWidget {
  final Weather weather;
  const HomeBodyData({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.imagesMap),
              const SizedBox(width: 20),
              Text(weather.city, style: Styles.textBold24()),
              const Spacer(),
              Icon(Icons.search),
            ],
          ),
          const SizedBox(height: 30),
          CachedNetworkImage(
            imageUrl: 'http:${weather.iconImage}',
            width: 141,
            height: 141,
            fit: BoxFit.cover,
            placeholder: (context, url) => Skeletonizer(child: SizedBox()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(weather.localTime, style: Styles.textRegular18()),
                  Text(
                    '  ${weather.temp.toInt()}°',
                    style: Styles.textSemiRegular100(),
                  ),
                  Text(weather.desc, style: Styles.textBold24()),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      SvgPicture.asset(Assets.imagesWindy),
                      Text('Wind', style: Styles.textRegular18()),
                      SizedBox(
                        height: 21,
                        child: VerticalDivider(width: 1, color: Colors.white),
                      ),
                      Text(
                        '${weather.wind.toInt()} km/hd',
                        style: Styles.textRegular18(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      SvgPicture.asset(Assets.imagesHum),
                      Text('Hum', style: Styles.textRegular18()),
                      SizedBox(
                        height: 21,
                        child: VerticalDivider(width: 1, color: Colors.white),
                      ),
                      Text(
                        '${weather.hum.toInt()} %',
                        style: Styles.textRegular18(),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

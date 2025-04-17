import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tocaantask/core/utils/helpers/custom_snack_bar.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';
import 'package:tocaantask/features/home/data/repo/weather_repo.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit_state.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/home_body_data.dart';
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
            AnimatedSlide(
              duration: Duration(milliseconds: 900),
              offset: _isVisible ? Offset(0, 0.05) : Offset(0, 0.1),
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
    return RefreshIndicator(
      onRefresh:
          () async => Future.delayed(
            Duration(milliseconds: 200),
          ).then((_) => context.read<WeatherCubit>().getWeather('egypt')),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Skeletonizer(
                child: HomeBodyData(weather: Weather.empty()),
              );
            } else if (state is WeatherLoaded) {
              return HomeBodyData(weather: state.weather);
            } else if (state is WeatherError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: AppError(
                    message: state.message,
                    tryAgain:
                        () => context.read<WeatherCubit>().getWeather('egypt'),
                  ),
                ),
              );
            }
            return SizedBox(child: Text(state.toString()));
          },
          listener: (BuildContext context, WeatherState state) {
            if (state is WeatherError) {
              showErrorSnackBar(
                context: context,
                message: '${state.message},a pull to refresh',
              );
            }
          },
        ),
      ),
    );
  }
}

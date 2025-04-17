import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tocaantask/core/utils/helpers/custom_snack_bar.dart';
import 'package:tocaantask/core/utils/helpers/getItLocator.dart';
import 'package:tocaantask/features/home/data/models/hive_weather/hive_weather.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';
import 'package:tocaantask/features/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit/weather_cubit_state.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/home_body_data.dart';
import 'package:tocaantask/features/widgets/app_error_widget.dart';

class HomeBodyState extends StatelessWidget {
  const HomeBodyState({super.key});

  @override
  Widget build(BuildContext context) {
    final search = context.watch<SearchCubit>().state;
    return RefreshIndicator(
      onRefresh:
          () async => Future.delayed(Duration(milliseconds: 200)).then(
            (_) => context.read<WeatherCubit>().getWeather(
              getit<Box<HiveWeather>>().get("weather")!.city,
            ),
          ),

      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Skeletonizer(
                child: HomeBodyData(weather: Weather.empty()),
              );
            } else if (state is WeatherSuccess) {
              return HomeBodyData(weather: state.weather);
            } else if (state is WeatherError) {
              if (state.weather != null) {
                return HomeBodyData(weather: state.weather!);
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: AppError(
                    message: state.message,
                    tryAgain:
                        () => context.read<WeatherCubit>().getWeather(search),
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
                message: '${state.message},and pull to refresh',
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tocaantask/constant.dart';
import 'package:tocaantask/core/utils/theme/Styles.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';
import 'package:tocaantask/features/home/presentation/manger/location_cubit/location_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/location_cubit/location_cubit_state.dart';
import 'package:tocaantask/features/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:tocaantask/features/widgets/custom_elevated_button.dart';

class GetUserLocation extends StatelessWidget {
  GetUserLocation({super.key});
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationLoading) {
          isLoading = true;
        }
        if (state is LocationSuccess) {
          isLoading = false;
          context.read<WeatherCubit>().getWeather(
            '${state.position.latitude},${state.position.longitude}',
          );
        }
        if (state is LocationLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location is loaded already")),
          );
        }
        if (state is LocationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder:
          (context, state) => CustomElevatedButton(
            onPressed: () async {
              final search = context.read<SearchCubit>().state;
              context.read<LocationCubit>().getLocation(search.isNotEmpty || search == 'error');
              context.read<SearchCubit>().clearSearch();
            },
            width: 300,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 50,
                  offset: Offset(-4, 8),
                  spreadRadius: 4,
                ),
              ],
            ),
            buttonTextStyle: Styles.textRegular18().copyWith(
              color: primaryColor,
            ),
            text: 'Get your current location',
            isLoading: isLoading,
            rightIcon: SvgPicture.asset(Assets.imagesMap, color: Colors.black),
          ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tocaantask/core/utils/helpers/time_formater.dart';
import 'package:tocaantask/core/utils/theme/Styles.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/custom_app_bart.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/wind_and_hum_section.dart';

class HomeBodyData extends StatelessWidget {
  final Weather weather;
  const HomeBodyData({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomAppBart(weather: weather),
          const SizedBox(height: 30),
          CachedNetworkImage(
            imageUrl: 'http:${weather.iconImage}',
            width: 141,
            height: 141,
            fit: BoxFit.cover,
            placeholder: (context, url) => Skeletonizer(child: SizedBox()),
            errorWidget:
                (context, url, error) =>
                    Icon(Icons.wifi_off, size: 70, color: Colors.white),
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
                  Text(
                    formatDateTime(weather.localTime),
                    style: Styles.textRegular18(),
                  ),
                  Text(
                    ' ${weather.temp.toInt()}°',
                    style: Styles.textSemiRegular100(),
                  ),
                  Text(weather.desc, style: Styles.textBold24()),
                  const SizedBox(height: 30),
                  WindAndHumSection(weather: weather),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

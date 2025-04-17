import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tocaantask/core/utils/theme/Styles.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';

class WindAndHumSection extends StatelessWidget {
  const WindAndHumSection({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        children: [
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
              SizedBox(
                width: 100,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('${1200} km/hd', style: Styles.textRegular18()),
                ),
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
              SizedBox(
                width: 95,
                child: Text(
                  '${weather.hum.toInt()} %',
                  style: Styles.textRegular18(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tocaantask/core/utils/theme/Styles.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';
import 'package:tocaantask/features/home/data/models/intites/weather.dart';
import 'package:tocaantask/features/home/presentation/view/widgets/custom_search_bar.dart';

class CustomAppBart extends StatefulWidget {
  const CustomAppBart({super.key, required this.weather});

  final Weather weather;

  @override
  State<CustomAppBart> createState() => _CustomAppBartState();
}

class _CustomAppBartState extends State<CustomAppBart> {
  bool showCity = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showCity) ...[
          SvgPicture.asset(Assets.imagesMap),
          const SizedBox(width: 20),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(widget.weather.city, style: Styles.textBold24()),
          ),
        ],
        const Spacer(),

        CustomSearchBar(
          ontap: () {
            // delay for animation
            showCity == true
                ? setState(() {
                  showCity = false;
                })
                : Future.delayed(Duration(milliseconds: 300), () {
                  setState(() {
                    showCity = true;
                  });
                });
          },
        ),
      ],
    );
  }
}

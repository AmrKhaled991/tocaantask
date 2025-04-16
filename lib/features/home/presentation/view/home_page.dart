import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tocaantask/core/utils/theme/Styles.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';

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
    return Scaffold(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.imagesMap),
                        const SizedBox(width: 20),
                        Text("Semarang", style: Styles.textBold24()),
                        const Spacer(),
                        Icon(Icons.search),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Image.asset(Assets.imagesTestimage),
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
                              'Today, 12 September',
                              style: Styles.textRegular18(),
                            ),
                            Text('  29°', style: Styles.textSemiRegular100()),
                            Text('Cloudy', style: Styles.textBold24()),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 20,
                              children: [
                                SvgPicture.asset(Assets.imagesWindy),
                                Text('Wind', style: Styles.textRegular18()),
                                SizedBox(
                                  height: 21,
                                  child: VerticalDivider(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                Text('10 km/hd', style: Styles.textRegular18()),
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
                                  child: VerticalDivider(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                Text('54 %', style: Styles.textRegular18()),
                                SizedBox(width: 14),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

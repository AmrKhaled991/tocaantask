import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tocaantask/features/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:tocaantask/features/home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:tocaantask/features/widgets/animated_search_bar.dart';

class CustomSearchBar extends StatefulWidget {
  final VoidCallback ontap;
  const CustomSearchBar({super.key, required this.ontap});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController textController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSearchBar(
      width: MediaQuery.sizeOf(context).width - 40,
      height: 50,
      textController: textController,
      onSuffixTap: () {
        widget.ontap();
        setState(() {
          textController.clear();
        });
      },
      rtl: false,
      onSubmitted: (String search) {
        widget.ontap();
        if (search.trim().isEmpty) return;
        // delay for animation
        Future.delayed(Duration(milliseconds: 400)).then((value) {
          context.read<WeatherCubit>().getWeather(search);
          context.read<SearchCubit>().submitSearch(search);
        });
      },
      textInputAction: TextInputAction.search,
      searchBarOpen: (a) {
        widget.ontap();
        a = 0;
      },
    );
  }
}

//Usable component

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tocaantask/core/utils/theme/appAssets.dart';

class AnimatedSearchBar extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;
  const AnimatedSearchBar({
    super.key,
    required this.width,
    required this.searchBarOpen,
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",
    this.height = 60,
    this.color = Colors.white,
    this.textFieldColor = Colors.white,
    this.searchIconColor = Colors.black,
    this.textFieldIconColor = Colors.black,
    this.textInputAction = TextInputAction.done,
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,
    required this.onSubmitted,
    this.rtl = false,
    this.autoFocus = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
    this.boxShadow = true,
    this.inputFormatters,
  });

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  int toggle = 0;

  String textFieldValue = '';
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),

      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: widget.height,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: toggle == 1 ? widget.textFieldColor : widget.color,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow:
              !widget.boxShadow
                  ? null
                  : [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: -10.0,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 1.6,
                        child: widget,
                      );
                    },
                    animation: _con,
                    child: GestureDetector(
                      onTap: () {
                        try {
                          widget.onSuffixTap();

                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                            _con.reverse();
                          }
                          widget.textController.clear();
                          textFieldValue = '';
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child:
                          widget.suffixIcon ??
                          Icon(
                            Icons.close,
                            size: 20.0,
                            color: widget.textFieldIconColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,

              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    textInputAction: widget.textInputAction,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2.0,
                    onChanged: (value) {
                      textFieldValue = value;
                    },
                    onSubmitted:
                        (value) => {
                          widget.onSubmitted(value),
                          unfocusKeyboard(),
                          setState(() {
                            toggle = 0;
                          }),
                          widget.textController.clear(),
                        },
                    onEditingComplete: () {
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },

                    style: widget.style ?? TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Material(
              color: toggle == 0 ? widget.color : widget.textFieldColor,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,
                icon:
                    widget.prefixIcon != null
                        ? toggle == 1
                            ? Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: widget.textFieldIconColor,
                            )
                            : widget.prefixIcon!
                        : toggle == 1
                        ? Icon(
                          Icons.arrow_forward_ios_rounded,
                          color:
                              toggle == 0
                                  ? widget.searchIconColor
                                  : widget.textFieldIconColor,
                          size: 20.0,
                        )
                        : SvgPicture.asset(Assets.imagesSearch, width: 25),
                onPressed: () {
                  setState(() {
                    if (toggle == 0) {
                      toggle = 1;
                      setState(() {
                        if (widget.autoFocus)
                          FocusScope.of(context).requestFocus(focusNode);
                      });

                      _con.forward();
                    } else {
                      toggle = 0;

                      setState(() {
                        if (widget.autoFocus) unfocusKeyboard();
                      });

                      _con.reverse();
                    }
                  });
                  widget.searchBarOpen(toggle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

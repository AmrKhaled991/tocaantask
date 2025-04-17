import 'package:flutter/material.dart';

class Styles {
  static TextStyle textBold24() {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset(-2, 3),
          blurRadius: 1,
          color: Color(0xFF000000).withOpacity(0.10),
        ),
      ],
    );
  }
  static TextStyle textRegular18() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset(-2, 3),
          blurRadius: 1,
          color: Color(0xFF000000).withOpacity(0.10),
        ),
      ],
    );
  }

  static TextStyle textSemiRegular100() {
    return TextStyle(
      fontSize: 100,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset(-4, 8),

          color: Color(0xFF000000).withOpacity(0.10),
        ),
      ],
    );
  }
}

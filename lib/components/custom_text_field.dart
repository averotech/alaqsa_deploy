import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField {
  static TextFieldWithTitle(
      {controller, title, hintText, obscureText, borderColor, margin}) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'SansArabicLight',
                color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 9),
            height: 48,
            child: TextField(
              obscureText: obscureText,
              controller: controller,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SansArabicLight',
                  color: Colors.white),
              decoration: InputDecoration(
                hintText: "$hintText",
                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SansArabicLight',
                    color: Colors.white.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white)),
                contentPadding: EdgeInsets.only(left: 16, right: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  static TextFieldWithIcon(
      {controller,
      hintText,
      obscureText,
      margin,
      icon,
      colorHintText,
      textColor,
      fontSize = 14.0,
      keyboardType}) {
    return Container(
      margin: margin,
      height: 42,
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType ?? TextInputType.text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: 'SansArabicLight',
            color: textColor ?? Color(0xffB7B7B7)),
        decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                fontFamily: 'SansArabicLight',
                color: colorHintText ?? Colors.white.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffCFE9FF)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Color(0xffCFE9FF))),
            prefixIcon: Container(
              width: 24,
              height: 24,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: 6),
              child: SvgPicture.asset("$icon"),
            ),
            contentPadding: EdgeInsets.only(left: 6, right: 6),
            prefixIconConstraints: BoxConstraints(maxWidth: 120, minWidth: 40)),
        controller: controller,
      ),
    );
  }

  static TextFieldWithTitleAndBorder(
      {width,
      controller,
      onChanged,
      title,
      hintText,
      obscureText,
      margin,
      textAlign,
      keyboardType}) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          Container(
            width: width,
            child: Text(
              "$title",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SansArabicLight',
                  color: Color(0xffB7B7B7),
                  height: 1.5),
              textAlign: textAlign != null ? textAlign : TextAlign.end,
            ),
          ),
          Container(
            height: 42,
            margin: EdgeInsets.only(top: 8),
            child: TextField(
              obscureText: obscureText,
              keyboardType: keyboardType ?? TextInputType.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SansArabicLight',
                  color: Color(0xff101426)),
              textAlign: textAlign != null ? textAlign : TextAlign.end,
              decoration: InputDecoration(
                hintText: "$hintText",
                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SansArabicLight',
                    color: Colors.white.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xffCFE9FF)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Color(0xffCFE9FF))),
                contentPadding: EdgeInsets.only(left: 16, right: 16),
              ),
              controller: controller,
              onChanged: (text) {
                if (onChanged != null) {
                  onChanged(text);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    cursorColor: AppColors.primaryColor,
    accentColor: AppColors.primaryColor,
    fontFamily: 'Shruti',
    focusColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
IconThemeData selectednavigationRailIconTheme(){
  return IconThemeData(
     color: AppColors.primaryColor,
     size: 45
  );
}
IconThemeData unselectednavigationRailIconTheme(){
  return IconThemeData(
     color: AppColors.darkGreyColor,
  );
}

class AppColors {
  static const primaryColor = Color(0xFF2a2f81);
  static const driverprimaryColor = Color(0xff2A2F81);
  static const brownColor = Color(0xFF282C35);
  static const textFeildcolor = Color(0xFF819ffd);
  static const greyColor = Color(0xFF999999);
  static const textFeildBg = Color(0xfff9f9f9);
  static const buttonBg = Color(0xFF6F8679);
  static const talibhebuttonbg = Color(0xFFADB37D);
  static const buttonBorder = Color(0xFF78A58C);
  static const lightGreyColor = Color(0xFFcacaca);
  static const mediumGreyColor = Color(0xFFB4B4B4);
  static const darkColor = Color(0xFF000000);
  static const whiteColor = Color(0xFFFFFFFF);
  static const appBarColor = Color(0xFF294423);
  static const talibheappbarColor = Color(0xFF919D42);
  static const lightGreenColor = Color(0xFFC0C9C4);
  static const lightestGreyColor = Color(0xFFD6D5D5);
  static const darkGreyColor = Color(0xFF555555);
  static const mediumGreenColor = Color(0xFF325438);
  static const lightestGreenColor = Color(0xFFCED6D1);
  static const orangeColor = Color(0xFFFD9B00);
  static const lightOrangeColor = Color(0xFFfda418);
  static const orangeButton = Color(0xFFE5AA17);
  static const greenColor = Color(0xFF55BD16);
  static const mediumtitleGreenColor = Color(0xFF3F7557);
  static const bgGreenColor = Color(0xffd2ebc6);
  static const bgtable = Color(0xffd1dfd8);
  static const talibhenavbar_bg = Color(0xffd7dac2);
  static const talibhenavbarText = Color(0xFF6B6567);
  static const blueColor = Color(0XFF045890);
  static const darkblue = Color(0XFF1C6290);
  static const lightblue = Color(0XFFC2DDF0) ;
  static const normalBrown = Color(0xFF954535);
  static const lightbrown = Color(0xffc2b280);
  static const darkGreen = Color(0xFF355e3b);
  static const lightOrange = Color(0xffffae42);
}

class AppStyles {
  static const navbarInactiveTextStyle = TextStyle(
    color: AppColors.lightGreyColor,
    fontSize: 9,
  );
  static const navbarActiveTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 17,
    fontWeight: FontWeight.w500
  );
  static const greenTextStyle = TextStyle(
    color: AppColors.buttonBg,
    fontSize: 16,
  );
   static const blueTextStyle = TextStyle(
    color: AppColors.darkblue,
    fontSize: 16,
  );
  static const whiteTextStyle =
      TextStyle(color: AppColors.whiteColor, fontSize: 22,fontWeight: FontWeight.w400);
  
  static const textFieldTextStyle =
      TextStyle(color: AppColors.whiteColor, fontSize: 18,);

  static const blackTextStyle =
      TextStyle(color: AppColors.darkColor, fontSize: 18);

  static const greyTextStyle = TextStyle(
    color: AppColors.darkGreyColor,
    fontSize: 17,
  );
  static const mediumtitleTextStyle = TextStyle(
    color: AppColors.mediumtitleGreenColor,
    fontSize: 17,
    fontWeight: FontWeight.w500
  );
  static const primaryTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 16,
  );
  static const defaultHintTextStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 14,
  );
  static const tabLabelStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
}

InputDecoration hintTextDecoration(String text) {
  return InputDecoration(
    hintText: text,
//    border: InputBorder.none,
    labelStyle: AppStyles.defaultHintTextStyle,
    hintStyle: AppStyles.defaultHintTextStyle,
  );
}

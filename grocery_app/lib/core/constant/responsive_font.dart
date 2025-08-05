import 'package:flutter/material.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';

class ResponsiveTextStyles {
  static double _scale(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / 375; // 375 = iPhone X width
  }

  /// splash screen
  static TextStyle splashTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 50 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.green,
    );
  }

  /// auth screen
  static TextStyle authTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 40 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.blackGray,
    );
  }

  static TextStyle authDescription(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.blackGray,
    );
  }

  static TextStyle labelTextBox(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 20 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.blackGray,
    );
  }

  static TextStyle authValueTextBox(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 20 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.blackGray,
    );
  }

  static TextStyle authNormalText(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.blackGray,
    );
  }

  // navigate
  static TextStyle labelNavBarSelected(BuildContext context){
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 14 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.green,
    );
  }

  static TextStyle labelNavBarUnSelected(BuildContext context){
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.black,
    );
  }

  // home screen
  static TextStyle appBarTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.black,
    );
  }

  static TextStyle categoryTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.w400,
      color: GColor.black,
    );
  }

  static TextStyle seeAllLabel(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  static TextStyle seeAllText(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.green,
    );
  }

  static TextStyle productTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: Colors.black,
      overflow: TextOverflow.ellipsis
    );
  }

  static TextStyle productTitleDetail(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 25 * _scale(context),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle productPrice(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 19 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  static TextStyle productPriceOnDetail(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 22 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.red
    );
  }

  static TextStyle productDescription(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 16 * _scale(context),
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade800,
    );
  }

  static TextStyle productRate(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 17 * _scale(context),
      fontWeight: FontWeight.w600,
      color: GColor.black
    );
  }

  static TextStyle labelAddCart(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 18 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.white
    );
  }

  // favorite
  static TextStyle labelSearch(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.blackGray
    );
  }

  // profile
  static TextStyle labelUserName(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 20 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.blackGray
    );
  }

  static TextStyle labelEmail(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        color: GColor.blackGray
    );
  }

  // profile

  static TextStyle labelItemProfileTitle(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 20 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.black
    );
  }

  static TextStyle labelItemProfileList(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 18 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.black
    );
  }

  // filter
  static TextStyle labelFilterProduct(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 18 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.blackGray
    );
  }

  // edit profile
  static TextStyle labelEdit(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 25 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.blackGray
    );
  }

  // notification
  static TextStyle labelNotification(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 20 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.blackGray
    );
  }

  static TextStyle labelNotificationTitle(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 16 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.blackGray
    );
  }

  static TextStyle labelNotificationDate(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 12 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.green
    );
  }

  static TextStyle labelNotificationRead(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.red
    );
  }

  // history order
  static TextStyle orderNumber(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 16 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.black
    );
  }

  static TextStyle deliveryDateNumber(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        fontWeight: FontWeight.w600,
        color: GColor.green
    );
  }

  static TextStyle bottomLabel(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 20 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.black
    );
  }

  static TextStyle bottomDate(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        color: GColor.blackGray
    );
  }

  static TextStyle labelStatus(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 12 * _scale(context),
        color: GColor.green
    );
  }

  static TextStyle orderNumberDetail(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 23 * _scale(context),
        color: GColor.black
    );
  }

  static TextStyle itemName(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 18 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.black
    );
  }

  static TextStyle itemPrice(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.red
    );
  }

  // address
  static TextStyle labelAddress(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 16 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.black
    );
  }

  // cart
  static TextStyle nameItem(BuildContext context) {
    return TextStyle(
        fontFamily: 'BalooDa',
        fontSize: 15 * _scale(context),
        fontWeight: FontWeight.bold,
        color: GColor.black,
    );
  }

  static TextStyle priceItem(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  // checkout
  static TextStyle labelDetailCheckout(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  static TextStyle labelAddressCheckout(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  static TextStyle labelSubAmount(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.blackGray,
    );
  }

  static TextStyle labelTotalAmount(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 15 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  // payment
  static TextStyle labelPaymentCard(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }

  static TextStyle labelButtonPay(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.white,
    );
  }

  static TextStyle labelButtonBackHome(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.white,
    );
  }

  static TextStyle labelMessageOrderSuccess(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 25 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.blackGray,
    );
  }

  static TextStyle labelMessageOrder(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 18 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.blackGray,
    );
  }

  // order status
  static TextStyle labelMessageOrderStatus(BuildContext context) {
    return TextStyle(
      fontFamily: 'BalooDa',
      fontSize: 20 * _scale(context),
      fontWeight: FontWeight.bold,
      color: GColor.black,
    );
  }
}



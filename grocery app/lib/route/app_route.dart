import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/presentation/screens/address_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/address_update_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/cart_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/checkout_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/confirm_payment.dart';
import 'package:online_grocery_delivery_app/presentation/screens/edit_profile_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/favorite_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/home_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/login_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/navigate_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/notification_detail_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/notification_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/order_history_detail_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/order_history_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/order_status_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/product_detail_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/product_filter_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/profile_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/register_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/reset_password_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/search_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/send_email_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/splash_screen.dart';
import 'package:online_grocery_delivery_app/presentation/screens/verify_code_screen.dart';

class AppRoutes {
  static const splash = "/";
  static const login = "/login";
  static const register = "/register";
  static const sendEmail = "/send-email";
  static const verifyCode = "/verify-code";
  static const resetPassword = "/reset-password";
  static const navigate = "/navigate";
  static const home = "/home";
  static const favorite = "/favorite";
  static const search = "/search";
  static const profile = "/profile";
  static const productDetail = "/product-detail";
  static const productFilter = "/product-filter";
  static const editProfile = "/edit-profile";
  static const notification = "/notification";
  static const notificationDetail = "/notification-detail";
  static const orderHistory = "/order-history";
  static const orderHistoryDetail = "/order-history-detail";
  static const address = "/address";
  static const addressUpdate = "/address-update";
  static const cart = "/cart";
  static const checkout = "/checkout";
  static const confirmPayment = "/confirm-payment";
  static const orderPrepare = "/order-prepare";
  static const orderDelivery = "/order-delivery";
  static const orderDelivered = "/order-delivered";
  static const orderStatus = "/order-status";

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: sendEmail, page: () => const SendEmailScreen()),
    GetPage(name: verifyCode, page: () => const VerifyCodeScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: navigate, page: () => const NavigateScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: favorite, page: () => const FavoriteScreen()),
    GetPage(name: search, page: () => const SearchScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: productDetail, page: () => const ProductDetailScreen()),
    GetPage(
      name: productFilter,
      page: () => ProductFilterScreen(category: Get.arguments),
    ),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: notification, page: () => const NotificationScreen()),
    GetPage(name: notificationDetail, page: () => const NotificationDetailScreen()),
    GetPage(name: orderHistory, page: () => const OrderHistoryScreen()),
    GetPage(name: orderHistoryDetail, page: () => const OrderHistoryDetailScreen()),
    GetPage(name: address, page: () => const AddressScreen()),
    GetPage(name: addressUpdate, page: () => const AddressUpdateScreen()),
    GetPage(name: cart, page: () => const CartScreen()),
    GetPage(name: checkout, page: () => const CheckoutScreen()),
    GetPage(name: confirmPayment, page: () => const ConfirmPayment()),
    GetPage(name: orderStatus, page: () => const OrderStatusScreen()),
  ];
}
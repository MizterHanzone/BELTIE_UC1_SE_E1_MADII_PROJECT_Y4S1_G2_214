import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:one_hub_collection_app/presentation/screens/cart_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/favorite_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/home_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/login_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/navigate_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/product_detail_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/profile_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/register_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/reset_password_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/send_email_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/splash_screen.dart';
import 'package:one_hub_collection_app/presentation/screens/verify_code_screen.dart';

class AppRoutes {
  static const splash = "/";
  static const register = "/register";
  static const login = "/login";
  static const sendEmail = "/send-email";
  static const verifyCode = "/verify-code";
  static const resetPassword = "/reset-password";
  static const navigate = "/navigate";
  static const home = "/home";
  static const favorite = "/favorite";
  static const cart = "/cart";
  static const profile = "/profile";
  static const productFilter = "/product-filter";
  static const productDetail = "/product-detail";

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: sendEmail, page: () => SendEmailScreen()),
    GetPage(name: verifyCode, page: () => VerifyCodeScreen()),
    GetPage(name: resetPassword, page: () => ResetPasswordScreen()),
    GetPage(name: navigate, page: () => NavigateScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: favorite, page: () => FavoriteScreen()),
    GetPage(name: cart, page: () => CartScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: productDetail, page: () => ProductDetailScreen()),
  ];
}
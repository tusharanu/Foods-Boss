import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/pages/accepted_order.dart';
import 'src/pages/MyProducts/add-product.dart';
import 'src/pages/MyProducts/dashboard.dart';
import 'src/pages/MyProducts/my_products.dart';
import 'src/pages/choose_location.dart';
import 'src/pages/create_password.dart';
import 'src/pages/verify_otp.dart';
import 'src/models/route_argument.dart';
import 'src/pages/choose_language.dart';
import 'src/pages/details.dart';
import 'src/pages/forget_password.dart';
import 'src/pages/help.dart';
import 'src/pages/languages.dart';
import 'src/pages/login.dart';
import 'src/pages/notifications.dart';
import 'src/pages/order.dart';
import 'src/pages/order_edit.dart';
import 'src/pages/pages.dart';
import 'src/pages/settings.dart';
import 'src/pages/signup.dart';
import 'src/pages/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/AddProduct':
        return MaterialPageRoute(builder: (_) => AddProduct());
      case '/MyProducts':
        return MaterialPageRoute(builder: (_) => MyProducts());
      case '/Dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/ChooseLocation':
        return MaterialPageRoute(builder: (_) => ChooseLocation());
      case '/ChooseLanguage':
        return MaterialPageRoute(builder: (_) => ChooseLanguage());
      case '/CreatePassword':
        return MaterialPageRoute(builder: (_) => CreatePassword());
      case '/VerifyOtp':
        return MaterialPageRoute(builder: (_) => VerifyOtp());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification2':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case '/Pages':
        return MaterialPageRoute(
            builder: (_) => PagesTestWidget(currentTab: args));
      case '/Details':
        return MaterialPageRoute(
            builder: (_) => DetailsWidget(routeArgument: args));
      case '/OrderDetails':
        return MaterialPageRoute(
            builder: (_) => OrderWidget(routeArgument: args as RouteArgument));

      case '/OrderEdit':
        return MaterialPageRoute(
            builder: (_) =>
                OrderEditWidget(routeArgument: args as RouteArgument));
      case '/Notifications':
        return MaterialPageRoute(builder: (_) => NotificationsWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}

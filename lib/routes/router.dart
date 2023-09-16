import 'package:flutter/material.dart';
import '../UI/auth/login/login.ui.dart';
import '../UI/auth/register/register.ui.dart';
import '../UI/onboarding/main_onboarding.dart';
import '../UI/splash/spalsh_screen.dart';
import '../core/services/local_services/app-cache.dart';
import '../locator.dart';
import 'routes.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final cache = locator<AppCache>();
    final args = settings.arguments;
    switch (settings.name) {
    // case HomeRoute:
    //   return MaterialPageRoute(builder: (_) => const BottomNavPage());
    //   case walletHomeRoute:
    //     return MaterialPageRoute(builder: (_) => const WalletHome());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const WalletHome());
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    //   case resetPasswordRoute:
    //     return MaterialPageRoute(builder: (_) => const ResetPassword());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
    //   case bottomNavigationRoute:
    //     return MaterialPageRoute(builder: (_) => const BottomNavigationScreen());
    //   case loginWithPinRoute:
    //     return MaterialPageRoute(builder: (_) => const CheckPinScreen());
    //   case drawEntryPointRoute:
    //     return MaterialPageRoute(builder: (_) => const DrawEntryPointScreen());
    //   case createPinRouteOne:
    //     return MaterialPageRoute(builder: (_) => CreatePinScreen(
    //       user: cache.user,
    //     ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
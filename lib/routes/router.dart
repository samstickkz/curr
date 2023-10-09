import 'package:flutter/material.dart';
import '../UI/auth/biometric/biometric.ui.dart';
import '../UI/auth/forget_password/forget.password.ui.dart';
import '../UI/auth/forget_password/reset_password/reset.password.ui.dart';
import '../UI/auth/login/login.ui.dart';
import '../UI/auth/register/register.ui.dart';
import '../UI/home/bottom_navigation.ui.dart';
import '../UI/home/navigations/draw/draw_entry_point.dart';
import '../UI/home/navigations/home/coinpage_api/coinpage.dart';
import '../UI/home/navigations/profile/change_password/change_password.ui.dart';
import '../UI/home/navigations/profile/edit_profile/edit.profile.ui.dart';
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
      case walletHomeRoute:
        return MaterialPageRoute(builder: (_) => const WalletHome());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const WalletHome());
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen(email: cache.email,));
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case bottomNavigationRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavigationScreen());
      case buyBal:
        return MaterialPageRoute(builder: (_) => const Bbal());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case useBioRoute:
        return MaterialPageRoute(builder: (_) => const UseBiometricScreen());
      case drawEntryPointRoute:
        return MaterialPageRoute(builder: (_) => const DrawEntryPointScreen());
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
import 'package:curr/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:oktoast/oktoast.dart';

import 'core/services/local_services/initializer.dart';
import 'core/services/local_services/navigation_services.dart';
import 'locator.dart';
import 'routes/routes.dart';
import 'styles/app_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Use environment variable
  await dotenv.load(fileName: ".env");

  // set up locator services
  setupLocator();

  await locator<Initializer>().init();

  // Change status bar theme based on theme of app
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp()); // Pass the email to the MyApp widget
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key); // Use Key instead of super.key


  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(395, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: locator<NavigationService>().navigatorKey,
            scaffoldMessengerKey: locator<NavigationService>().snackBarKey,
            theme: Style.darkTheme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routers.generateRoute,
            initialRoute: splashScreenRoute,
            navigatorObservers: [FlutterSmartDialog.observer],
            // here
            builder: FlutterSmartDialog.init(),
          );
        },
      ),
    );
  }
}

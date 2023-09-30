import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/services/local_services/app-cache.dart';
import '../core/services/local_services/initializer.dart';
import '../core/services/local_services/navigation_services.dart';
import '../core/services/local_services/user.service.dart';
import '../locator.dart';

const String token = 'token';
const String userTypes = 'userTypes';
const String userTypeData = 'userTypeData';
const String accessToken = 'accessToken';
const String expiryDate = 'expiryDate';
const String isSecured = 'isSecure_text';
const String refreshToken = 'refreshToken';
const String currentUser = 'currentUser';
const String settings = 'settings';
const String imagePath = "assets/images/";
String get baseUrl => dotenv.env['BASE_URL']!;
String get publicKey => dotenv.env['PAYSTACK_PUBLIC_URL']!;
String get priceUrl => dotenv.env['CRYPTO_PRICE_URL']!;
Initializer initializer = locator<Initializer>();

NavigationService navigationService = locator<NavigationService>();
UserService userService = locator<UserService>();
AppCache cache = locator<AppCache>();
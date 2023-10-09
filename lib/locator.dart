import 'package:curr/UI/home/navigations/profile/change_password/change_password.vm.dart';
import 'package:get_it/get_it.dart';

import 'UI/auth/biometric/biometric.vm.dart';
import 'UI/auth/forget_password/forget.password.vm.dart';
import 'UI/auth/forget_password/reset_password/reset.password.vm.dart';
import 'UI/auth/login/login.vm.dart';
import 'UI/auth/register/register.vm.dart';
import 'UI/base.vm.dart';
import 'UI/home/bottom_navigation.vm.dart';
import 'UI/home/navigations/draw/draw_entry_point.vm.dart';
import 'UI/home/navigations/home/buy_token/buy.token.vm.dart';
import 'UI/home/navigations/home/drawer/drawer.vm.dart';
import 'UI/home/navigations/home/home.vm.dart';
import 'UI/home/navigations/profile/edit_profile/edit.profile.vm.dart';
import 'UI/home/navigations/profile/profile.home.vm.dart';
import 'core/cache/sharedpreferences.dart';
import 'core/repository/repository.dart';
import 'core/services/local_services/app-cache.dart';
import 'core/services/local_services/initializer.dart';
import 'core/services/local_services/navigation_services.dart';
import 'core/services/local_services/storage-service.dart';
import 'core/services/local_services/user-enrollment-service.dart';
import 'core/services/local_services/user.service.dart';
// import 'core/services/navigation_services.dart';
// import 'core/services/storage-service.dart';
// import 'core/services/user-enrollment-service.dart';
// import 'core/services/user.service.dart';
import 'core/services/web-services/auth.api.dart';
// import 'ui/auth/checkPin/check.pin.vm.dart';
// import 'ui/auth/login/login.vm.dart';
// import 'ui/auth/pin_code/create.pin.vm.dart';
// import 'ui/auth/pin_code/finish_pin.vm.dart';
// import 'ui/auth/register/register.vm.dart';
// import 'ui/base.vm.dart';
// import 'ui/home/bottom_navigation.vm.dart';
// import 'ui/home/navigations/draw/draw_entry_point.vm.dart';
// import 'ui/home/navigations/home/buy_token/buy.token.vm.dart';
// import 'ui/home/navigations/home/drawer/drawer.vm.dart';
// import 'ui/home/navigations/home/home.vm.dart';
// import 'ui/home/navigations/profile/profile.home.vm.dart';

GetIt locator = GetIt.I;

//
void setupLocator(){
  registerViewModels();
  registerServices();
}

void registerViewModels() {
  /* TODO Setup viewModels*/
  locator.registerFactory<BaseViewModel>(() => BaseViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<BottomNavigationViewModel>(() => BottomNavigationViewModel());
  locator.registerFactory<HomePageViewModel>(() => HomePageViewModel());
  locator.registerFactory<BuyTokenViewModel>(() => BuyTokenViewModel());
  locator.registerFactory<DrawerViewModel>(() => DrawerViewModel());
  locator.registerFactory<ProfileHomeViewModel>(() => ProfileHomeViewModel());
  locator.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel());
  locator.registerFactory<ResetPasswordViewModel>(() => ResetPasswordViewModel());
  locator.registerFactory<EditProfileViewModel>(() => EditProfileViewModel());
  locator.registerFactory<ChangePasswordViewModel>(() => ChangePasswordViewModel());
  locator.registerFactory<DrawEntryPointViewModel>(() => DrawEntryPointViewModel());
  locator.registerFactory<UseBiometricViewModel>(() => UseBiometricViewModel());


}

void registerServices(){
  /// Services
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton(() => Initializer());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => UserEnrollmentService());
  locator.registerLazySingleton(() => AppCache());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<SharedPreference>(() => SharedPreference());
  locator.registerLazySingleton<AuthenticationApiService>(() => AuthenticationApiService());
}
import 'package:curr/UI/base.vm.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_auth/local_auth.dart';

import '../../../routes/routes.dart';
import '../../../utils/snack_message.dart';

class UseBiometricViewModel extends BaseViewModel{

  late final LocalAuthentication localAuthentication = LocalAuthentication();
  bool spportState = false;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();


  Future<String> getAndroidVersion() async {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.version.release;
  }

  Future<void> authenticate() async {
    print("auth area");
    bool authenticated = false;
    try {
      authenticated = await localAuthentication.authenticate(
          localizedReason: 'Please authenticate to show account login',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ));
    } catch (e) {
      showCustomToast(e.toString());
      notifyListeners();
    }

    if (authenticated) {
      navigationService.navigateToAndRemoveUntil(bottomNavigationRoute);
      // do something after successful authentication
    } else {
      notifyListeners();
    }
  }

}
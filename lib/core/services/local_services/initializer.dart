import '../../../constants/constants.dart';
import '../../../locator.dart';
import 'storage-service.dart';
import 'user.service.dart';

class Initializer {
  UserService userService = locator<UserService>();
  StorageService storageService = locator<StorageService>();
  bool isLoggedIn = false;

  // Future initialCalls() async {
  //   try {
  //     String? value = await storageService.readItem(key: token);
  //     if (value != null && value.isNotEmpty) {
  //       await Future.wait(<Future>[
  //         await locator<UserService>().getLocalUser(),
  //         getUserCalls(),
  //       ]);
  //     }
  //   } on DioError catch (e) {
  //     return e.response.toString();
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  getUserCalls() async {
    await locator<UserService>().getLocalUser();
  }

  init() async {
    await checkForCachedUserData();
  }

  checkForCachedUserData() async {
    String? value = await storageService.readItem(key: accessToken);
    if (value != null && value.isNotEmpty) {
      isLoggedIn = true;
      await locator<UserService>().getLocalUser();
    }else{
      isLoggedIn = false;
    }
  }

  Future getRemoteSettings() async {
    // await getIt<UserApiService>().getSettings();
  }

  // Future getRemoteUserData() async {
  //   Future getUser = auth.getUser();
  //   FutureGroup futureGroup = FutureGroup();
  //   futureGroup.add(getUser);
  //   futureGroup.close();
  //   futureGroup.future
  //       .then((value) => null)
  //       .onError((error, stackTrace) => throw NetworkException());
  // }
}

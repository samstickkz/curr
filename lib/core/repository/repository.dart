import 'package:dartz/dartz.dart';

import '../../locator.dart';
import '../models/response_model.dart';
import '../services/local_services/app-cache.dart';
import '../services/local_services/initializer.dart';
import '../services/local_services/storage-service.dart';
import '../services/local_services/user.service.dart';
import '../services/web-services/auth.api.dart';

class Repository {
  UserService userService = locator<UserService>();
  AppCache appCache = locator<AppCache>();
  Initializer initializer = locator<Initializer>();
  AuthenticationApiService authApi = locator<AuthenticationApiService>();
  StorageService storageService = locator<StorageService>();


  Future<Either<ResModel, ResModel>> register({
    required String email, required String password, required String activationUrl, required bool acceptPolicy,
  }) async {
    return await authApi.register(email: email, password: password, activationUrl: activationUrl, acceptPolicy: acceptPolicy);
  }

  Future<Either<ResModel, ResModel>> login({required String email, required String password
  }) async {
    return await authApi.login(email: email, password: password);
  }

}
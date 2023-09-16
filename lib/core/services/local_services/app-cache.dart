import 'dart:io';

import '../../../locator.dart';
import 'storage-service.dart';

class AppCache {
  // AgentProfileResponse userCredentials = AgentProfileResponse();
  StorageService storageService = locator<StorageService>();

  clearRegisterData(){

  }

  bool? firstTimeKYC;

  
  String? dateOfBirth;
  File? userImage;

  String? rentCost;
  String? contractType;

}

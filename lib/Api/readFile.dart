import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'package:yahaal_task/model/userModel.dart';

import '../constant.dart';


Future<String> loadAsset() async {
  return await rootBundle.loadString(Constants.FILE_PATH);
}

Future<dynamic> mappingFileToUser() async {

  String data = await loadAsset();
  List<UserModel> usermodels = [];
  
  List<String> lines = data.split('\n');

  for (int i = 1; i < lines.length; i++) {
    usermodels.add(UserModel.fromFile(lines[i]));
  }
  return usermodels;
}

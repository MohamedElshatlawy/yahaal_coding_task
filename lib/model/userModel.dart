


import 'genderEnum.dart';

class UserModel {
  String id;
  String fName;
  String lName;
  Gender gender;
  double latitude;
  double longitude;

//0=>ID 1=>FNAME 2=>LNAME 3=>GENDER 4=>LAT 5=>LNG

  UserModel.fromFile(String userRow) {
    List<String> list = userRow.split(',');
   
    this.id = list[0];
    this.fName = list[1];
    this.lName = list[2];
    this.gender =
        (list[3].toLowerCase() == "female") ? Gender.female : Gender.male;
    this.latitude = double.parse(list[4]);
    this.longitude = double.parse(list[5]);
  }
  
}

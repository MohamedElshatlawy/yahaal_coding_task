import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Constants {
  static const FILE_PATH = "assets/mock.txt";
  static const MyColor=Color.fromRGBO(56, 74, 99, 1);
  static const Map<int, LatLng> mappingLocations = {
    0: LatLng(51.528308, -0.3817868), //London
    1: LatLng(48.8588377, 2.2770196), //Paris
    2: LatLng(39.0915837, -94.8559177) //Kansas
  };
}

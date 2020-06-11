import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yahaal_task/Api/distanceCalculator.dart';

import 'package:yahaal_task/model/constant.dart';
import 'package:yahaal_task/model/genderEnum.dart';
import 'package:yahaal_task/model/userModel.dart';
import 'package:yahaal_task/view/ModalBottom.dart';

class HomeScreen extends StatefulWidget {
  List<UserModel> users;
  HomeScreen({this.users});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> filteredList = [];
  void addMarkers() {
    markers.clear();
    filteredList.forEach((model) {
      if (model.gender == Gender.female) {
        femaleCount++;
      } else {
        maleCount++;
      }
      markers.add(Marker(
          markerId: MarkerId(model.id),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              (model.gender == Gender.female)
                  ? BitmapDescriptor.hueRose
                  : BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
              title: model.fName + " " + model.lName,
              snippet: (model.gender == Gender.female) ? "Female" : "Male"),
          position: LatLng(model.latitude, model.longitude)));
    });
    setState(() {});
  }

  void filterData({Gender gender, String namePeople, int distanceFilter}) {
    filteredList.clear();
    markers.clear();
    maleCount = 0;
    femaleCount = 0;

    //Filter Data with GENDER
    if (gender != null) {
      widget.users.forEach((item) {
        if (item.gender == gender) {
          if (item.gender == Gender.female) {
            femaleCount++;
          } else {
            maleCount++;
          }
          filteredList.add(item);
          markers.add(Marker(
              markerId: MarkerId(item.id),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  (item.gender == Gender.female)
                      ? BitmapDescriptor.hueRose
                      : BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(
                  title: item.fName + " " + item.lName,
                  snippet: (item.gender == Gender.female) ? "Female" : "Male"),
              position: LatLng(item.latitude, item.longitude)));
        }
      });
    }
    //////////////////////

    //Filter Data with PeopleName

    if (namePeople != null) {
      if (namePeople.isEmpty) {
        filteredList.addAll(widget.users);
        addMarkers();
      } else {
        widget.users.forEach((item) {
          String fullName =
              item.fName.toLowerCase() + " " + item.lName.toLowerCase();
          if (fullName.contains(namePeople)) {
            if (item.gender == Gender.female) {
              femaleCount++;
            } else {
              maleCount++;
            }

            filteredList.add(item);
            markers.add(Marker(
                markerId: MarkerId(item.id),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    (item.gender == Gender.female)
                        ? BitmapDescriptor.hueRose
                        : BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                    title: item.fName + " " + item.lName,
                    snippet:
                        (item.gender == Gender.female) ? "Female" : "Male"),
                position: LatLng(item.latitude, item.longitude)));
          }
        });
      }
    }
    /////////////////////

    //Filter Data with distance
    if (distanceFilter != null) {
      var cityLocation = Constants.mappingLocations[distanceFilter];
      widget.users.forEach((item) {
        double distance = calculateDistance(cityLocation.latitude,
            cityLocation.longitude, item.latitude, item.longitude);
        if (distance <= 2000.0) {
          filteredList.add(item);

          markers.add(Marker(
              markerId: MarkerId(item.id),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  (item.gender == Gender.female)
                      ? BitmapDescriptor.hueRose
                      : BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(
                  title: item.fName + " " + item.lName,
                  snippet: (item.gender == Gender.female) ? "Female" : "Male"),
              position: LatLng(item.latitude, item.longitude)));

          if (item.gender == Gender.female) {
            femaleCount++;
          } else {
            maleCount++;
          }
        }
      });
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredList.addAll(widget.users);
    addMarkers();
  }

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [];
  int maleCount = 0;
  int femaleCount = 0;

  @override
  Widget build(BuildContext context) {
   // print('ListLengh:${filteredList.length}');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await showModalBottomSheet(
              context: context,
              builder: (ctx) => CustomModalBottom(),
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)));

          int radioVal = result[0];
          switch (radioVal) {
            case 0:
              filterData(gender: Gender.male);
              break;
            case 1:
              filterData(gender: Gender.female);
              break;
            case 2:
              filterData(namePeople: result[1]);
              break;

            default:
              filterData(distanceFilter: result[2]);
          }
        },
        child: Icon(
          Icons.tune,
          color:Constants.MyColor,
        ),
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
        backgroundColor: Constants.MyColor,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            markers: Set.from(markers),
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.users[0].latitude,
                widget.users[0].longitude,
              ),
            ),
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Males',
                          style: TextStyle(color: Constants.MyColor, fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('/'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          maleCount.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Females',
                          style: TextStyle(color: Constants.MyColor, fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('/'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          femaleCount.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

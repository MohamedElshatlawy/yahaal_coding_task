import 'package:flutter/material.dart';

import '../constant.dart';

class CustomModalBottom extends StatefulWidget {
  @override
  _CustomModalBottomState createState() => _CustomModalBottomState();
}

class _CustomModalBottomState extends State<CustomModalBottom> {
  int radioValue = 0;
  int radioLocations = 0;
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Choose Your Filter',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                  color: Constants.MyColor
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            RadioListTile(
              value: 0,
              groupValue: radioValue,
              activeColor: Constants.MyColor,
              onChanged: (v) {
                setState(() {
                  radioValue = v;
                });
              },
              title: Text('Male'),
            ),
            RadioListTile(
              value: 1,
              groupValue: radioValue,
                 activeColor: Constants.MyColor,
              onChanged: (v) {
                setState(() {
                  radioValue = v;
                });
              },
              title: Text('Female'),
            ),
            RadioListTile(
              value: 2,
              groupValue: radioValue,
                 activeColor: Constants.MyColor,
              onChanged: (v) {
                setState(() {
                  radioValue = v;
                });
              },
              title: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'People Name',
                ),
              ),
            ),
            RadioListTile(
              value: 3,
             
              groupValue: radioValue,
                 activeColor: Constants.MyColor,
              onChanged: (v) {
                setState(() {
                  radioValue = v;
                });
              },
              title: Text('People living in a radius of max 2000KM'),
              isThreeLine: false,
              subtitle: (radioValue != 3)
                  ? Container(
                    child: Text('Based on locations'),
                  )
                  : Column(
                      children: <Widget>[
                        
                        RadioListTile(
                          value: 0,
                          activeColor: Colors.pink,
                          groupValue: radioLocations,
                          onChanged: (v) {
                            setState(() {
                              radioLocations = v;
                            });
                          },
                          title: Text('London'),
                        ),
                        RadioListTile(
                          value: 1,
                          activeColor: Colors.pink,
                          groupValue: radioLocations,
                          onChanged: (v) {
                            setState(() {
                              radioLocations = v;
                            });
                          },
                          title: Text('Paris'),
                        ),
                        RadioListTile(
                          value: 2,
                          activeColor: Colors.pink,
                          groupValue: radioLocations,
                          onChanged: (v) {
                            setState(() {
                              radioLocations = v;
                            });
                          },
                          title: Text('Kansas'),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 49,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, [radioValue, nameController.text,radioLocations]);
                },
                color:     Constants.MyColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textColor: Colors.white,
                child: Text('Confirm'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

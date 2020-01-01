import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name for th UI
  String time; //time in that location
  String flag; //url for the flag
  String url; //location url for api endpoint
  bool isDaytime; //true if its day, else false

  WorldTime({this.location, this.flag, this.url});

  Future <void> getTime() async{
    try {
      //make the request
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String hrOffset = data['utc_offset'].substring(1, 3);
      String minOffset = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(hrOffset), minutes: int.parse(minOffset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      //date is formatted using the jm method in intl package we added.

    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }

}
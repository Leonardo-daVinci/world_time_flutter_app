import 'package:http/http.dart';
import 'dart:convert';

class WorldTime{
  String location; //location name for th UI
  String time; //time in that location
  String flag; //url for the flag
  String url; //location url for api endpoint

  WorldTime({this.location, this.flag, this.url});

  Future <void> getTime() async{
    //make the request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    //get properties from data
    String datetime = data['datetime'];
    String hrOffset = data['utc_offset'].substring(1,3);
    String minOffset = data['utc_offset'].substring(4,6);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(hrOffset),minutes: int.parse(minOffset)));
    time = now.toString();

  }

}
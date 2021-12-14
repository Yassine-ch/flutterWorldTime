import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
class WorldTime{
  String location ;// location for the UI
  String time ;//the time in that location
String flag;//url to an asses flag icon
String url;//the location url for api endpoint
  bool isDaytime;//true if daytime or not


  WorldTime({this.location,this.flag,this.url});

 Future  <void> getTime() async {
   try {
     Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
     Map data =jsonDecode(response.body) ;
     //print(data);
     //Get properties from data
     String datetime = data ['datetime'];
     String offset = data['utc_offset'].substring(1,3);
     //print(datetime);
     // print(offset);
     //create DateTime object
     DateTime now = DateTime.parse(datetime);
     now =  now.add(Duration(hours:int.parse(offset) ));
     //set time property
     isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
     time = DateFormat.jm().format(now);
   }
   catch(e){
     print ('caught error : $e');
     time = 'could not get time data ';

   }
    // make a request


  }
}


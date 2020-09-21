import 'dart:convert';

import 'package:enlacessp/pages/logIng.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  const fiveSeconds = const Duration(seconds: 30);
  Timer.periodic(fiveSeconds, (Timer t) => _enviar());
  runApp(MyApp());
}

_enviar() async {
  Position position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//print("\n$position\n");
  var response = await post(
    //'http://192.168.1.65/API2/geo.php',
    'https://siegeest.app/API2/geo.php',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': "ASMR1",
      'latitud': "${position.latitude}",
      'longitud': "${position.longitude}",
    }),
  );
  print("\n${response.statusCode} ${response.body}\n\n");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enlace SSP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: logIn(),
    );
  }
}

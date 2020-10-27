import 'dart:convert';
import 'dart:math';

import 'package:enlacessp/pages/HomePageResources/animated_bootom_bar.dart';
import 'package:enlacessp/pages/indexPage.dart';
import 'package:enlacessp/pages/infraccionesPage.dart';
import 'package:enlacessp/pages/notificationPage.dart';
import 'package:enlacessp/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';


class HomePage extends StatefulWidget {
  String code;
  HomePage({this.code="007"});
  final List<BarItem> barItems = [
    BarItem(
      text: "Inicio",
      iconos: FontAwesomeIcons.home,
      color: Color.fromRGBO(30, 42, 82, 3),
    ),
    BarItem(
        text: "Infracciones",
        iconos: FontAwesomeIcons.fileAlt,
        color: Color.fromRGBO(126, 124, 127, 3)),
    BarItem(
        text: "Notificaciones",
        iconos: FontAwesomeIcons.bell,
        color: Color.fromRGBO(16, 127, 209, 3)),
    BarItem(
        text: "Mi Perfil",
        iconos: FontAwesomeIcons.user,
        color: Color.fromRGBO(66, 126, 188, 3)),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  initState(){
    super.initState();
    const fiveSeconds = const Duration(seconds: 5);
    Timer.periodic(fiveSeconds, (Timer t) => _enviar());
  }

  int selectedBarIndex = 0;

  //Paginas
  final IndexPage _paginaHome = IndexPage();
  final InfraccionesPage _infraccionPage = InfraccionesPage();
  final NotificacionesPage _paginaNotificaciones = NotificacionesPage();
  final PerfilPage _paginaPerfil = PerfilPage();

  Widget _showPage = new IndexPage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _paginaHome;
        break;
      case 1:
        return _infraccionPage;
        break;
      case 2:
        return _paginaNotificaciones;
        break;
      case 3:
        return _paginaPerfil;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        child: _showPage,
        duration: const Duration(milliseconds: 700),
      ),
      bottomNavigationBar: AnimatedBottomBar(
        barItems: widget.barItems,
        animationDuration: const Duration(milliseconds: 550),
        onBarTap: (index) {
          setState(() {
            _showPage = _pageChooser(index);
          });
        },
      ),
    );
  }
  _enviar() async {
  Position position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var response = await post(
    'https://siegeest.app/API2/geos.php',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': "${widget.code}",
      'latitud': "${position.latitude}",
      'longitud': "${position.longitude}",
      'tipo': "motocicleta",
    }),
  );
  print("\n${response.statusCode} ${response.body}\n\n");
}
}

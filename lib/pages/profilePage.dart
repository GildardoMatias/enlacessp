import 'package:enlacessp/pages/logIn.dart';
import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(66, 126, 188, .9),
          Color.fromRGBO(66, 126, 188, 3),
        ])),
        child: Container(
          margin: EdgeInsets.all(20.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ssptr.png'),
                  fit: BoxFit.fitWidth)),
        ),
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _getInfo() {
    return Positioned(
      top: 100,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 260,
        width: MediaQuery.of(context).size.width * 0.90,
        child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Perfil de Usuario",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Color.fromRGBO(23, 23, 25, 3),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage('assets/images/profileimage.png'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Policia"),
                    SizedBox(
                      width: 20,
                    ),
                    Text("SSP"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Correo:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "enlacessp@siegeest.com",
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userAdress() {
    return Positioned(
      top: 380,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.90,
        child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Información de Usuario",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Estado:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Michoacan"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ciudad:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Morelia"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Telefono:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("443 540 2470"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tipo:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Motocicleta"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cerrarSesion() {
    return Positioned(
      top: 600,
      child: Container(
        margin: EdgeInsets.all(20.0),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(66, 126, 188, 3),
              Color.fromRGBO(66, 126, 188, .9),
            ])),
        child: FlatButton(
          child: Text(
            "Cerrar Sesión",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LogIn(),
            ));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 244, 247, 3),
      body: Container(
        child: FadeAnimation(
          .7,
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              _greenColors(),
              _getInfo(),
              _userAdress(),
              _cerrarSesion(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:enlacessp/pages/Animation/FadeAnimation.dart';
import 'package:enlacessp/pages/indexPageResources/nuevaInfraccion.dart';
import 'package:flutter/material.dart';

import 'package:location_permissions/location_permissions.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      .7,
      Scaffold(
        backgroundColor: Color.fromRGBO(240, 244, 247, 3),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.43,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(58, 58, 58, 3),
                    Color.fromRGBO(29, 43, 82, 3),
                  ])),
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/ssptr.png'),
                            fit: BoxFit.fitWidth)),
                  ),
                )
              ],
            ),
            FadeAnimation(
              .7,
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Bienvenido!",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Buscar',
                                hintStyle: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      children: <Widget>[
                        categoryWidget('infraccion', "Registrar Infracción"),
                        categoryWidget2('info', "Información de usuario"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Card categoryWidget(String img, String title) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: InkWell(
        onTap: () async {
          //openProductPage('$img', '$title');
          PermissionStatus permission = await LocationPermissions().requestPermissions();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NuevaInfraccion(),
          ));
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/$img.png'),
                        fit: BoxFit.fitHeight)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Card categoryWidget2(String img, String title) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: InkWell(
        onTap: () {
          /*  //openProductPage('$img', '$title');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => completed2(),
              ));*/
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/$img.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '$title',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void openProductPage(String img, String title) {
    Navigator.pushNamed(context, '/productPage',
        arguments: {'image': '$img', 'title': '$title'});
  }
}

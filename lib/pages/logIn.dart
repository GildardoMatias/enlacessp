import 'package:enlacessp/pages/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 3),
      body: SingleChildScrollView(
        
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 380,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/backgroundssp.png'),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(29, 43, 82, .5),
                                  blurRadius: 8.0,
                                  offset: Offset(0, 5))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border()),
                              child: TextField(
                                controller: _code,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Usuario",
                                    suffixIcon: Icon(Icons.account_circle,
                                        color: Color.fromRGBO(29, 43, 82, 3)),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Contraseña",
                                    suffixIcon: Icon(Icons.lock,
                                        color: Color.fromRGBO(29, 43, 82, 3)),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(29, 43, 82, 3),
                                Color.fromRGBO(29, 43, 82, .9),
                              ])),
                          child: FlatButton(
                            child: Text(
                              "Ingresar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage(code: _code.text,),
                              ));
                            },
                          ),
                        )),
                    SizedBox(
                      height: 70,
                    ),
                    FadeAnimation(
                        1.5,
                        Text(
                          "¿Has olvidado tu contraseña?",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

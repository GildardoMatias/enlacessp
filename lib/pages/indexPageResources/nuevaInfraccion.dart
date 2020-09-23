import 'dart:io';

import 'package:enlacessp/pages/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart';
import 'dart:convert'; //to convert json to maps and vice versa
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class NuevaInfraccion extends StatefulWidget {
  @override
  _NuevaInfraccionState createState() => _NuevaInfraccionState();
}

// ignore: camel_case_types
class _NuevaInfraccionState extends State<NuevaInfraccion> {
  //Variables requeridas para el archivo de datos
  File jsonFile;
  Directory dir;
  String fileName = "myJSONFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  File _image;
  File _image2;
  File _image3;
  File _image4;
  File pickedImage;
  var curp = '';
  String validacionFinal = '';
  String validacionCurp = '';
  String completarInputs = '';

  @override
  void dispose() {
    // TODO: implement dispose
    _ciudad_evento.dispose();
    _direccion.dispose();
    _descripcion.dispose();
    _nombre_conductor.dispose();
    _primer_apellido.dispose();
    _segundo_apellido.dispose();
    _domicilio_conductor.dispose();
    _numero_licencia.dispose();
    _servicio_vehiculo.dispose();
    _numero_placa.dispose();
    _marca.dispose();
    _linea.dispose();
    _modelo.dispose();
    _garantia.dispose();
    _observaciones.dispose();
    super.dispose();
  }

  Future _getImage() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Foto de Infraccion 1',
              toolbarColor: Color.fromRGBO(30, 42, 82, 3),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      this.setState(() {
        _image = cropped;
      });
    } else {
      this.setState(() {});
    }
  }

  Future _getImage2() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Foto de Infraccion 2',
              toolbarColor: Color.fromRGBO(30, 42, 82, 3),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      this.setState(() {
        _image2 = cropped;
      });
    } else {
      this.setState(() {});
    }
  }

  Future _getImage3() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Foto de Placa',
              toolbarColor: Color.fromRGBO(30, 42, 82, 3),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      this.setState(() {
        _image3 = cropped;
      });
    } else {
      this.setState(() {});
    }
  }

  Future _getImage4() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Foto Licencia',
              toolbarColor: Color.fromRGBO(30, 42, 82, 3),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      this.setState(() {
        _image4 = cropped;
      });
    } else {
      this.setState(() {});
    }
  }

  List _myActivities;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    //Inicializacion del directorio de la app
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = jsonDecode(jsonFile.readAsStringSync()));
    });
  }

//================================Controladores=========================================
  TextEditingController _municipioTextFieldControoler =
      new TextEditingController();
  TextEditingController _localidadesTextFieldControoler =
      new TextEditingController();
  final formkey = GlobalKey<FormState>();
  TextEditingController _ciudad_evento = new TextEditingController();
  TextEditingController _direccion = new TextEditingController();
  TextEditingController _descripcion = new TextEditingController();
  TextEditingController _nombre_conductor = new TextEditingController();
  TextEditingController _primer_apellido = new TextEditingController();
  TextEditingController _segundo_apellido = new TextEditingController();
  TextEditingController _domicilio_conductor = new TextEditingController();
  TextEditingController _numero_licencia = new TextEditingController();
  TextEditingController _servicio_vehiculo = new TextEditingController();
  TextEditingController _numero_placa = new TextEditingController();
  TextEditingController _marca = new TextEditingController();
  TextEditingController _linea = new TextEditingController();
  TextEditingController _modelo = new TextEditingController();
  TextEditingController _garantia = new TextEditingController();
  TextEditingController _observaciones = new TextEditingController();
  String _claseVehiculo = "Clase1";
  String _tipoLicencia = "Licencia1";

  String _generoBeneficiairo;
  String _tipodebeneficiarioTEDC;
  String _tipodebeneficioTEDC;
  List _discapacidad;
//================================Controladores=========================================

  String _fecha = '';
  String _opcionSeleccionadaLicencia = 'Licencia1';

  String _opcionSeleccionadaTipoBeneficiario = 'Desempleado';
  String _opcionSeleccionadaTipoBeneficio = 'Alimenticio';
  String _opcionSeleccionadaClaseVehiculo = 'Clase1';
  List<String> _sexoBeneficiario = ['Masculino', 'Femenino'];
  List<String> _indigenaBeneficiario = ['NO', 'SI'];
  List<String> _tipodeLicencia = ['Licencia1', 'Licencia2', 'Licencia3'];
  List<String> _claseDeVehiculo = ['Clase1', 'Clase2', 'Clase3'];
  List<String> _tipoDeBeneficiario = [
    'Adulto Mayor',
    'Desempleado',
    'Mujer Embarazada',
    'Niño',
    'Persona con discapacidad',
    'Salud',
    'Otro'
  ];
  List<String> _tipoDeBeneficio = ['Alimenticio', 'Otro'];
  TextEditingController _inputFechaNacimiento = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 42, 82, 3),
        title: Text('Registrar Beneficiario'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: FadeAnimation(
              2,
              Column(
                children: <Widget>[
                  Divider(),
                  _ciudadEventoInput(),
                  Divider(),
                  _direccionInput(),
                  Divider(),
                  _labelFaltas(),
                  Divider(),
                  _descripccionHechos(),
                  Divider(),
                  _nombreConductor(),
                  Divider(),
                  _primerApellido(),
                  Divider(),
                  _segundoApellido(),
                  Divider(),
                  _domicilioConductor(),
                  Divider(),
                  _seleccionTipoLicencia(),
                  _tipodeLicenciaWidget(),
                  Divider(),
                  _numeroLicencia(),
                  Divider(),
                  _servcioVehiculo(),
                  Divider(),
                  _numeroPlaca(),
                  Divider(),
                  _marcaInput(),
                  Divider(),
                  _lineaInput(),
                  Divider(),
                  _modeloInput(),
                  Divider(),
                  _seleccionClaseCehiculo(),
                  _clasVehiculoInput(),
                  Divider(),
                  _garantiaInput(),
                  Divider(),
                  _observacionesInput(),
                  Divider(),
                  _labelFotos(),
                  _camaraInput(),
                  Divider(),
                  _labelSubmit(),
                  _submitInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ciudadEventoInput() {
    return Container(
      child: TextFormField(
        controller: _ciudad_evento,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Ciudad del Evento',
          labelText: 'Ciudad Evento',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.city,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese la Ciudad';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _direccionInput() {
    return Container(
      child: TextFormField(
        controller: _direccion,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Dirección',
          labelText: 'Dirección',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.mapMarked,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese la Ciudad';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _labelFaltas() {
    return Container(
      child: Text(
        "FALTAS",
        style: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      width: 300.0,
      height: 35.0,
    );
  }

  Widget _descripccionHechos() {
    return Container(
      child: TextFormField(
        controller: _descripcion,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Descripcción de los Hechos',
          labelText: 'Descripcción',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.clipboardList,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese la Ciudad';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _nombreConductor() {
    return Container(
      child: TextFormField(
        controller: _nombre_conductor,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Conductor',
          labelText: 'Nombre del conductor',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.userAlt,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el nombre del conductor';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _primerApellido() {
    return Container(
      child: TextFormField(
        controller: _primer_apellido,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Primer Apellido',
          labelText: 'Primer Apellido',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.userAlt,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el primer Apellido';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _segundoApellido() {
    return Container(
      child: TextFormField(
        controller: _segundo_apellido,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Segundo Apellido',
          labelText: 'Segundo Apellido',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.userAlt,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el segundo Apellido';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _domicilioConductor() {
    return Container(
      child: TextFormField(
        controller: _domicilio_conductor,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Domicilio del Conductor',
          labelText: 'Domicilio del Conductor',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.mapMarked,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el Domicilio del Conductor';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _seleccionTipoLicencia() {
    return Container(
      child: Text(
        "Seleccione Licencia",
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      width: 300.0,
      height: 35.0,
    );
  }

  Widget _tipodeLicenciaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.idCard,
          color: Color.fromRGBO(30, 42, 82, 3),
        ),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _opcionSeleccionadaLicencia,
                iconSize: 30.0,
                icon: (null),
                style: TextStyle(
                    color: Color.fromRGBO(30, 42, 82, 3),
                    fontWeight: FontWeight.bold),
                hint: Text("Selecciona una Opcion"),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionadaLicencia = opt;
                    _tipoLicencia = _opcionSeleccionadaLicencia;
                  });
                },
                items: getOpcionesLicencia(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesLicencia() {
    List<DropdownMenuItem<String>> lista = new List();
    _tipodeLicencia.forEach((licenia) {
      lista.add(DropdownMenuItem(
        child: Text(licenia),
        value: licenia,
      ));
    });
    return lista;
  }

  Widget _numeroLicencia() {
    return Container(
      child: TextFormField(
        controller: _numero_licencia,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Número de Licencia',
          labelText: 'Número de Licencia',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.idCard,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el Numero de Licencia';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _servcioVehiculo() {
    return Container(
      child: TextFormField(
        controller: _servicio_vehiculo,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Servicio Vehiculo',
          labelText: 'Servicio Vehiculo',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.servicestack,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el Servicio Vehiculo';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _numeroPlaca() {
    return Container(
      child: TextFormField(
        controller: _numero_placa,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Numero de Placa',
          labelText: 'Numero de Placa',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.servicestack,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el Numero de Placa';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _marcaInput() {
    return Container(
      child: TextFormField(
        controller: _marca,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Marca',
          labelText: 'Marca',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.servicestack,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese la Marca';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _lineaInput() {
    return Container(
      child: TextFormField(
        controller: _linea,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Linea',
          labelText: 'Linea',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.servicestack,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese la Linea';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _modeloInput() {
    return Container(
      child: TextFormField(
        controller: _modelo,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Modelo',
          labelText: 'Modelo',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.servicestack,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese el Modelo';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _seleccionClaseCehiculo() {
    return Container(
      child: Text(
        "Seleccione la Clase del Vehiculo",
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      width: 300.0,
      height: 35.0,
    );
  }

  Widget _clasVehiculoInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.idCard,
          color: Color.fromRGBO(30, 42, 82, 3),
        ),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _opcionSeleccionadaClaseVehiculo,
                iconSize: 30.0,
                icon: (null),
                style: TextStyle(
                    color: Color.fromRGBO(30, 42, 82, 3),
                    fontWeight: FontWeight.bold),
                hint: Text("Selecciona una Opcion"),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionadaClaseVehiculo = opt;
                    _claseVehiculo = _opcionSeleccionadaClaseVehiculo;
                  });
                },
                items: getOpcionesClaseVehiculo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesClaseVehiculo() {
    List<DropdownMenuItem<String>> lista = new List();
    _claseDeVehiculo.forEach((clase) {
      lista.add(DropdownMenuItem(
        child: Text(clase),
        value: clase,
      ));
    });
    return lista;
  }

  Widget _garantiaInput() {
    return Container(
      child: TextFormField(
        controller: _garantia,
        autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Garantia',
          labelText: 'Garantia',
          labelStyle: TextStyle(
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.servicestack,
            color: Color.fromRGBO(30, 42, 82, 3),
          ),
        ),
        validator: (value) {
          if (value.length < 3) {
            return 'Porfavor Ingrese la Garantia';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _observacionesInput() {
    return TextFormField(
      autofocus: false,
      controller: _observaciones,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[800], width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(30, 42, 82, 3), width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Observaciones del Beneficiario',
        labelText: 'Observaciones',
        labelStyle: TextStyle(color: Color.fromRGBO(30, 42, 82, 3)),
        suffixIcon: Icon(
          Icons.remove_red_eye,
          color: Color.fromRGBO(30, 42, 82, 3),
        ),
      ),
    );
  }

  Widget _labelSubmit() {
    return Container(
      alignment: Alignment.center,
      child: completarInputs == 'false'
          ? Text(
              'Porfavor completa los campos marcados',
              style: TextStyle(
                color: Colors.red,
              ),
            )
          : Text(
              "",
              style: TextStyle(
                  color: Color.fromRGBO(24, 122, 123, 3),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
      width: 300.0,
      height: 35.0,
    );
  }

  Widget _labelFotos() {
    return Container(
      width: 500.0,
      height: 60.0,
      child: Column(
        children: <Widget>[
          Icon(Icons.camera_alt, color: Color.fromRGBO(30, 42, 82, 3)),
          Text(
            'Fotografias de Evidencia',
            style: TextStyle(
                color: Color.fromRGBO(30, 42, 82, 3),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _camaraInput() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 350,
            child: Text(
              '1: Foto de infraccion 1',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 350,
            child: Text(
              '2: Foto de infraccion 2',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 350,
            child: Text(
              '3: Foto de Placa',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 350,
            child: Text(
              '4: Foto Licencia',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  color: Color.fromRGBO(30, 42, 82, 3),
                  child: _image == null
                      ? Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        )
                      : Image.file(_image),
                ),
              ),
              GestureDetector(
                onTap: _getImage2,
                child: Container(
                  color: Color.fromRGBO(30, 42, 82, 3),
                  child: _image2 == null
                      ? Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        )
                      : Image.file(_image2),
                ),
              ),
              GestureDetector(
                onTap: _getImage3,
                child: Container(
                  color: Color.fromRGBO(30, 42, 82, 3),
                  child: _image3 == null
                      ? Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        )
                      : Image.file(_image3),
                ),
              ),
              GestureDetector(
                onTap: _getImage4,
                child: Container(
                  color: Color.fromRGBO(30, 42, 82, 3),
                  child: _image4 == null
                      ? Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        )
                      : Image.file(_image4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _submitInput() {
    return Container(
      height: 50,
      width: 500,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(30, 42, 82, 3),
            Color.fromRGBO(30, 42, 82, .9),
          ])),
      child: FlatButton(
        child: Text(
          "Registrar Infracción",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: _submit,
      ),
    );
  }

  // bool validarCurp(String value) {
  //   Pattern pattern =
  //       r'([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0\d|1[0-2])(?:[0-2]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)';
  //   RegExp regex = new RegExp(pattern);

  //   return (!regex.hasMatch(value)) ? false : true;
  // }

  void _submit() async {
    if (!formKey.currentState.validate())  {
      setState(() {
        completarInputs = 'false';
        validacionFinal = "true";
      });
    } else {
      setState(() async {
        completarInputs = '';
        PermissionStatus permission = await LocationPermissions().requestPermissions();
        Position position = await getLastKnownPosition();
        writeToFile("${position.latitude}", "${position.longitude}");
        final String ruta = await _localPath;
        File(_image.path).copy("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-1.png");
        File(_image2.path).copy("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-2.png");
        File(_image3.path).copy("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-3.png");
        File(_image4.path).copy("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-4.png");
        /*
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
            subir("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-1.png");
            subir("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-2.png");
            subir("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-3.png");
            subir("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-3.png");
            subir("$ruta/$fileName");
            File("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-1.png").delete();
            File("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-2.png").delete();
            File("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-3.png").delete();
            File("$ruta/${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}-4.png").delete();
            File("$ruta/$fileName").delete();
          } else {
            checkNativeFile();
          }
        } on SocketException catch (_) {
          checkNativeFile();
          print('not connected');
          
        }*/
        checkNativeFile();
        Navigator.of(context).pop();
      });
    }
  }

  subir(String filename)async{
    //Subida de datos
    var request = http.MultipartRequest('POST', Uri.parse("https://siegeest.app/API2/file.php"));
    request.files.add(
    http.MultipartFile.fromBytes(
      'uploaded_file',
      File(filename).readAsBytesSync(),
      filename: filename.split("/").last
    )
  );
  var res = await request.send();
  print("\n\n${res.statusCode}\n");
  }

  /* Widget _leerCurp() {
    return ListTile(
        title: validacionFinal == 'true'
            ? Text(
                "Curp: ${_obtenercurp.text}  es Valida",
                style: TextStyle(color: Colors.green),
              )
            : validacionFinal == 'false'
                ? Text(
                    "Curp: ${_obtenercurp.text} no es Valida",
                    style: TextStyle(color: Colors.red),
                  )
                : Text(''));
  }*/

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    //final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  //Metodos para escribir en el fichero json
  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(String lat, String long) {
    print("Writing to file!");
    print("\n\n$dir\n\n");
    Map<String, dynamic> otro = {
      "${_nombre_conductor.text}${_numero_placa.text}": {
        "folio": "${_nombre_conductor.text.trim()}${_numero_placa.text.trim()}",
        "ciudad_evento": "${_ciudad_evento.text}",
        "direccion": "${_direccion.text}",
        "descripcion": "${_descripcion.text}",
        "nombre_conductor": "${_nombre_conductor.text}",
        "primer_apellido": "${_primer_apellido.text}",
        "segundo_apellido": "${_segundo_apellido.text}",
        "domicilio_conductor": "${_domicilio_conductor.text}",
        "licencia": "$_tipoLicencia",
        "numero_licencia": "${_numero_licencia.text}",
        "servicio_vehiculo": "${_servicio_vehiculo.text}",
        "numero_placa": "${_numero_placa.text}",
        "marca": "${_marca.text}",
        "linea": "${_linea.text}",
        "modelo": "${_modelo.text}",
        "clase_vehiculo": "$_claseVehiculo",
        "garantia": "${_garantia.text}",
        "observaciones": "${_observaciones.text}",
        "latitud": "$lat",
        "longitud": "$long"
      }
    };
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(otro);
      jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(otro, dir, fileName);
    }
    this.setState(() => fileContent = jsonDecode(jsonFile.readAsStringSync()));
    print(fileContent);
  }
  //Fin de Metodos para escribir en el fichero json
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  checkNativeFile() async {
    try {
      final bool result = await platform.invokeMethod('checkFile');
      Fluttertoast.showToast(msg: "Datos enviados");
    } on PlatformException catch (e) {
      print("Error al conectar methodChannel: '${e.message}'.");
    }
  }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

const IMAGE_KEY = 'IMAGE_KEY';

class ImageSharedPrefs {
  static Future<bool> saveImageToPrefs(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(IMAGE_KEY, value);
  }

  static Future<bool> emptyPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.clear();
  }

  static Future<String> loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(IMAGE_KEY);
  }

  // encodes bytes list as string
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // decode bytes from a string
  static imageFrom64BaseString(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del dark mode
  get oscuro {
    return _prefs.getBool('oscuro') ?? true;
  }

  set oscuro(bool value) {
    _prefs.setBool('oscuro', value);
    //print("oscuro $value");
  }

  // GET y SET del género
  get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  // GET y SET del nombre
  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  // GET y SET del nombre
  /* get imagepath {
    return _prefs.getString('imagepath') ?? '';
  }

  set imagepath(String value) {
    _prefs.setString('imagepath', value);
  } */

  // GET y SET del apellido
  get apellido {
    return _prefs.getString('apellido') ?? '';
  }

  set apellido(String value) {
    _prefs.setString('apellido', value);
  }

  // GET y SET de edad
  get edad {
    return _prefs.getString('edad') ?? '';
  }

  set edad(String value) {
    _prefs.setString('edad', value);
  }

  // GET y SET de imagePath
  get imagePath {
    return _prefs.getString('imagePath') ?? '';
  }

  set imagePath(String value) {
    _prefs.setString('imagePath', value);
  }

  // GET y SET del token
  /*  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
 */

  // GET y SET del token
  get documento {
    return _prefs.getString('documento') ?? '';
  }

  set documento(String value) {
    _prefs.setString('documento', value);
  }

  // GET y SET de la última página
  /*  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  } */

  // GET y SET del tomado
  /* get tomado1 {
    return _prefs.getBool('tomado1') ?? false;
  }

  set tomado1(bool value) {
    _prefs.setBool('tomado1', value);
  }
 */
  get prueba {
    return _prefs.getInt('prueba') ?? 0;
  }

  set prueba(int value) {
    _prefs.setInt('prueba', value);
  }

  get dateEmail {
    return _prefs.getString('dateEmail') ?? '';
  }

  set dateEmail(String value) {
    _prefs.setString('dateEmail', value);
  }

  get endayAnterior {
    return _prefs.getInt('endayAnterior') ?? 0;
  }

  set endayAnterior(int value) {
    _prefs.setInt('endayAnterior', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get conteo {
    return _prefs.getInt('conteo') ?? 0;
  }

  set conteo(int value) {
    _prefs.setInt('conteo', value);
  }

  get conteo1 {
    return _prefs.getInt('conteo1') ?? 0;
  }

  set conteo1(int value) {
    _prefs.setInt('conteo1', value);
  }

  get frecuencia {
    return _prefs.getInt('frecuencia') ?? 0;
  }

  set frecuencia(int value) {
    _prefs.setInt('frecuencia', value);
  }

  get bloodPressure {
    return _prefs.getString('bloodPressure') ?? '';
  }

  set bloodPressure(String value) {
    _prefs.setString('bloodPressure', value);
  }

  /////////////////////////PARA EL PESO//////////////////////////////////////////////////
  get pesoInicial {
    return _prefs.getDouble('pesoInicial') ?? 0.0;
  }

  set pesoInicial(double value) {
    _prefs.setDouble('pesoInicial', value);
  }

  get pesoActual {
    return _prefs.getDouble('pesoActual') ?? 0.0;
  }

  set pesoActual(double value) {
    _prefs.setDouble('pesoActual', value);
  }

  /* get pesoAnterior {
    return _prefs.getString('pesoAnterior') ?? '';
  }

  set pesoAnterior(String value) {
    _prefs.setString('pesoAnterior', value);
  } */

  get pesoAnterior3 {
    return _prefs.getDouble('pesoAnterior3') ?? 0.0;
  }

  set pesoAnterior3(double value) {
    _prefs.setDouble('pesoAnterior3', value);
  }

  get pesoAnterior4 {
    return _prefs.getDouble('pesoAnterior4') ?? 0.0;
  }

  set pesoAnterior4(double value) {
    _prefs.setDouble('pesoAnterior4', value);
  }

  get dayAnterior {
    return _prefs.getInt('dayAnterior') ?? 0;
  }

  set dayAnterior(int value) {
    _prefs.setInt('dayAnterior', value);
  }

  get dayAnterior1 {
    return _prefs.getInt('dayAnterior1') ?? 0;
  }

  set dayAnterior1(int value) {
    _prefs.setInt('dayAnterior1', value);
  }

  get dateAnterior {
    return _prefs.getString('dateAnterior') ?? '';
  }

  set dateAnterior(String value) {
    _prefs.setString('dateAnterior', value);
  }

  get check {
    return _prefs.getInt('check') ?? 0;
  }

  set check(int value) {
    _prefs.setInt('check', value);
  }

  get monthAnterior {
    return _prefs.getInt('monthAnterior') ?? 0;
  }

  set monthAnterior(int value) {
    _prefs.setInt('monthAnterior', value);
  }

  get yearAnterior {
    return _prefs.getString('yearAnterior') ?? '';
  }

  set yearAnterior(String value) {
    _prefs.setString('yearAnterior', value);
  }
  ////////////////////////////////////////////////////////////////////7

}

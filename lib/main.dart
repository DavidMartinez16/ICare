import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:video_chat1/preferencias_usuario.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final prefs = new PreferenciasUsuario();
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "Xs45We9I1ZaqwTu25lL8xQ1Mn3u");
  final subjectText = TextEditingController(text: "Reuniones Médicas");
  final nameText = TextEditingController(text: "Mi nombre");
  final emailText = TextEditingController(text: "miemail@email.com");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    //prefs.oscuro = true;
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
        onPictureInPictureTerminated: _onPictureInPictureTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: (prefs.oscuro) ? Colors.indigo[900] : Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                /* TextField(
                  controller: serverText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Servidor URL",
                      hintText: "Hint: Leave empty for meet.jitsi.si"),
                  style: TextStyle(color: Colors.white),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: (prefs.oscuro)
                          ? Icon(Icons.wb_sunny_rounded,
                              color:
                                  (prefs.oscuro) ? Colors.white : Colors.black,
                              size: 30)
                          : Icon(FontAwesomeIcons.moon,
                              color:
                                  (prefs.oscuro) ? Colors.white : Colors.black,
                              size: 25),
                      onPressed: () {
                        setState(() {
                          if (prefs.oscuro == true) {
                            prefs.oscuro = false;
                          } else {
                            prefs.oscuro = true;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: (prefs.oscuro)
                          ? Icon(Icons.info_rounded,
                              color:
                                  (prefs.oscuro) ? Colors.white : Colors.black,
                              size: 30)
                          : Icon(Icons.info_outline_rounded,
                              color:
                                  (prefs.oscuro) ? Colors.white : Colors.black,
                              size: 30),
                      onPressed: () {
                        mostrarInfo(context);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text('REUNIONES',
                    style: TextStyle(
                        color: (prefs.oscuro) ? Colors.white : Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: roomText,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: (prefs.oscuro)
                          ? Colors.deepPurple[900]
                          : Colors.white,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Reunión",
                      labelStyle: TextStyle(
                          color: (prefs.oscuro) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  style: TextStyle(
                    color: (prefs.oscuro) ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: subjectText,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: (prefs.oscuro)
                          ? Colors.deepPurple[900]
                          : Colors.white,
                      focusColor: (prefs.oscuro) ? Colors.white : Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Sujeto",
                      labelStyle: TextStyle(
                          color: (prefs.oscuro) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  style: TextStyle(
                    color: (prefs.oscuro) ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: nameText,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: (prefs.oscuro)
                          ? Colors.deepPurple[900]
                          : Colors.white,
                      focusColor: (prefs.oscuro) ? Colors.white : Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Nombre",
                      labelStyle: TextStyle(
                          color: (prefs.oscuro) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  style: TextStyle(
                    color: (prefs.oscuro) ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: emailText,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: (prefs.oscuro)
                          ? Colors.deepPurple[900]
                          : Colors.white,
                      focusColor: (prefs.oscuro) ? Colors.white : Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Correo Electrónico",
                      labelStyle: TextStyle(
                          color: (prefs.oscuro) ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  style: TextStyle(
                    color: (prefs.oscuro) ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  activeColor: Colors.cyan,
                  title: Text(
                    "Sonido Encendido",
                    style: TextStyle(
                        color: (prefs.oscuro) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  value: isAudioOnly,
                  onChanged: _onAudioOnlyChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  activeColor: Colors.cyan,
                  title: Text(
                    "Sonido Apagado",
                    style: TextStyle(
                        color: (prefs.oscuro) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  value: isAudioMuted,
                  onChanged: _onAudioMutedChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  activeColor: Colors.cyan,
                  title: Text(
                    "Video Apagado",
                    style: TextStyle(
                        color: (prefs.oscuro) ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  value: isVideoMuted,
                  onChanged: _onVideoMutedChanged,
                ),
                Divider(
                  height: 48.0,
                  thickness: 2.0,
                ),
                SizedBox(
                  height: 64.0,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _joinMeeting();
                    },
                    child: Text(
                      "Unirme a la Reunión",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlag.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlag.pipEnabled = false;
      }

      //uncomment to modify video resolution
      //featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlag = featureFlag;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: ({message}) {
          debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: ({message}) {
          debugPrint("${options.room} exited PIP mode with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  void _onPictureInPictureWillEnter({message}) {
    debugPrint(
        "_onPictureInPictureWillEnter broadcasted with message: $message");
  }

  void _onPictureInPictureTerminated({message}) {
    debugPrint(
        "_onPictureInPictureTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  void mostrarInfo(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Center(child: Text('Información Importante')),
            content: Container(
              height: 330.0,
              child: Column(
                children: [
                  //Container(child: Image.asset('assets/info.png')),
                  Center(
                    child: Text(
                        'El nombre de la sala está por defecto tanto para la aplicación del profesional de la salud como para la aplicación del paciente, si deseas cambiar el nombre de la reunión lo puedes hacer pero debes notificar al paciente para que este lo cambie igualmente.'),
                  ),
                  SizedBox(height: 10),
                  Text(
                      'El nombre de la sala debe ser poco común, ya que otras personas se pueden unir a la reunión únicamente con el nombre de la sala. Sin embargo, puedes añadir contraseña a la sala o permitir el acceso a los usuarios que desees con el fin de añadir más seguridad.')
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ))
            ],
          );
        });
  }
}

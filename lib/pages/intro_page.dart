import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../pages/survey_1_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  static const platform = const MethodChannel('graduados/changeOrientation');

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      try {
        platform.invokeMethod('defaultOrientations');
      } on PlatformException catch (error) {
        print(error);
      }
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        color: Color(0xFFBE0028),
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20, right: 15),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Hero(
                          tag: 'absalogo',
                          child: Image.asset(
                            'assets/img/Absa_Logo_White.png',
                            height: 60,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textColor: Colors.white,
                            color: Color(0xFFf15726),
                            child: Text('Continuar'),
                            onPressed: () => Navigator.pushNamed(
                                context, SurveyOnePage.routeName),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Bem-vindo\nao programa de graduados do Absa',
                      style: TextStyle(fontSize: 46, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/svg/intro.svg',
                  fit: BoxFit.cover,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

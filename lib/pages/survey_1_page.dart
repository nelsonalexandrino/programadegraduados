import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import '../pages/survey_2_page.dart';

class SurveyOnePage extends StatefulWidget {
  static String routeName = '/survey-1';
  @override
  _SurveyOnePageState createState() => _SurveyOnePageState();
}

class _SurveyOnePageState extends State<SurveyOnePage> {
  PageController _pageController;
  bool _isKeyboardVisible = false;
  bool _isLastPage = false;
  String dropdownValue;
  var _buttonWidthHalf;

  var _documents = ['Bilhete de Identidade', 'Passaporte', 'Talão'];
  var _provinces = [
    'Maputo',
    'Gaza',
    'Inhambane',
    'Manica',
    'Sofala',
    'Tete',
    'Zambézia',
    'Nampula',
    'Cabo delgado',
    'Niassa',
  ];

  var _years = ['2019', '2018', '2017', 'Outro'];
  var _hasCertificate = [false, false];
  var _willHaveCertificate = [false, false];
  var _canIShow = false;
  var _submit = false;

  var _englishLevelCompreensionSpeaking = [
    'Não compreende e não fala',
    'Compreende e fala pouco',
    'Compreende e fala de forma satisfatória',
    'Compreende e fala de forma fluente'
  ];

  var _englishLevelWriting = [
    'Não escreve',
    'Escreve o básico',
    'Escreve satisfatoriamente',
    'Escreve muito bem '
  ];
  static const platform = const MethodChannel('graduados/changeOrientation');

//Controlllers
  final _typeDocumentController = TextEditingController();
  final _provinceController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _documentNumberController = TextEditingController();
  final _yearFinishedController = TextEditingController();
  final _englishLevelCompreensionSpeakingController = TextEditingController();
  final _englishLevelWritingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      try {
        platform.invokeMethod('defaultOrientations');
      } on PlatformException catch (error) {
        print(error);
      }
      print('kjhjahachac');
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    _pageController = PageController();
    _isLastPage = false;
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        _isKeyboardVisible = visible;
      },
    );
  }

  LinearGradient _buildBackgroundGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xFFBE0028), const Color(0xFF2E071B)],
      tileMode: TileMode.clamp,
    );
  }

  @override
  Widget build(BuildContext context) {
    _buttonWidthHalf = MediaQuery.of(context).size.width / 2 - 15;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            //color: Color(0xFFBE0028),
            gradient: _buildBackgroundGradient()),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30),
                children: <Widget>[
                  Hero(
                    tag: 'absalogo',
                    child: Image.asset(
                      'assets/img/Absa_Logo_White.png',
                      height: 48,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        'assets/img/gestures/agile.png',
                        height: 20,
                      ),
                      Text(
                        'Olá! preencha este formulario inicial',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/img/gestures/agile2.png',
                        height: 40,
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.white),
                                controller: _nameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorStyle: TextStyle(color: Colors.white),
                                    labelText: 'Nome completo',
                                    labelStyle: TextStyle(
                                      color: Colors.white.withOpacity(.75),
                                      fontSize: 16,
                                    ),
                                    // prefixIcon: Icon(
                                    //   Icons.lock_outline,
                                    //   color: Colors.white.withOpacity(.75),
                                    // ),
                                    filled: true,
                                    fillColor: Colors.black26),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.white),
                                  labelText: 'Email',
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 16,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black26,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => Container(
                                            height: 120,
                                            child: CupertinoPicker(
                                              itemExtent: 40,
                                              onSelectedItemChanged: (index) {
                                                _typeDocumentController.text =
                                                    _documents[index];
                                              },
                                              children: _documents
                                                  .map<Text>(
                                                      (String document) =>
                                                          Text(document))
                                                  .toList(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: _typeDocumentController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white),
                                            labelText: 'Documento',
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(.75),
                                              fontSize: 16,
                                            ),
                                            filled: true,
                                            fillColor: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 13),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: _documentNumberController,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: 'Número do documento',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                          color: Colors.white.withOpacity(.75),
                                          fontSize: 16,
                                        ),
                                        filled: true,
                                        fillColor: Colors.black26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 200,
                                      child: CupertinoPicker(
                                        itemExtent: 35,
                                        onSelectedItemChanged: (index) {
                                          _provinceController.text =
                                              _provinces[index];
                                        },
                                        children: _provinces
                                            .map((String province) =>
                                                Text(province))
                                            .toList(),
                                      ),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _provinceController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'Provincia de residência',
                                      suffixIcon: Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(.75),
                                        fontSize: 16,
                                      ),
                                      filled: true,
                                      fillColor: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (date) {
                                          _birthdayController.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(date);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _birthdayController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'Data de nascimento',
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(.75),
                                        fontSize: 16,
                                      ),
                                      filled: true,
                                      fillColor: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 100,
                                      child: CupertinoPicker(
                                        itemExtent: 40,
                                        children: _years
                                            .map(
                                              (String year) => Text(year),
                                            )
                                            .toList(),
                                        onSelectedItemChanged: (index) {
                                          _yearFinishedController.text =
                                              _years[index];
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _yearFinishedController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'Quando terminou o curso?',
                                      suffixIcon: Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(.75),
                                        fontSize: 16,
                                      ),
                                      filled: true,
                                      fillColor: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tem certificado de \nconclusão do curso?',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.85),
                                    ),
                                  ),
                                  ToggleButtons(
                                    borderColor: Color(0xFFf15726),
                                    selectedBorderColor: Color(0xFFf15726),
                                    selectedColor: Colors.white,
                                    fillColor: Color(0xFFf15726),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    children: <Widget>[
                                      Container(
                                        width: 80,
                                        height: 35,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sim',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                    onPressed: (index) {
                                      setState(() {
                                        for (int buttonIndex = 0;
                                            buttonIndex <
                                                _hasCertificate.length;
                                            buttonIndex++) {
                                          if (buttonIndex == index) {
                                            _hasCertificate[buttonIndex] = true;
                                          } else {
                                            _hasCertificate[buttonIndex] =
                                                false;
                                          }
                                        }

                                        if (_hasCertificate[1]) {
                                          _canIShow = true;
                                        } else {
                                          _canIShow = false;
                                        }
                                      });
                                    },
                                    isSelected: _hasCertificate,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              if (_canIShow)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Terá o certificado \naté 10 de Dezembro?',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.85),
                                      ),
                                    ),
                                    ToggleButtons(
                                      borderColor: Color(0xFFf15726),
                                      selectedBorderColor: Color(0xFFf15726),
                                      selectedColor: Colors.white,
                                      fillColor: Color(0xFFf15726),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      children: <Widget>[
                                        Container(
                                          width: 80,
                                          height: 35,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Sim',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Não',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onPressed: (index) {
                                        setState(() {
                                          for (int buttonIndex = 0;
                                              buttonIndex <
                                                  _willHaveCertificate.length;
                                              buttonIndex++) {
                                            if (buttonIndex == index) {
                                              _willHaveCertificate[
                                                  buttonIndex] = true;
                                            } else {
                                              _willHaveCertificate[
                                                  buttonIndex] = false;
                                            }
                                          }
                                        });
                                      },
                                      isSelected: _willHaveCertificate,
                                    )
                                  ],
                                ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 150,
                                      child: CupertinoPicker(
                                        itemExtent: 40,
                                        children:
                                            _englishLevelCompreensionSpeaking
                                                .map(
                                                  (String level) => Text(level),
                                                )
                                                .toList(),
                                        onSelectedItemChanged: (index) {
                                          _englishLevelCompreensionSpeakingController
                                                  .text =
                                              _englishLevelCompreensionSpeaking[
                                                  index];
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller:
                                        _englishLevelCompreensionSpeakingController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                      labelText:
                                          'Nível de Inglês: Compreensão e fala',
                                      suffixIcon: Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(.75),
                                        fontSize: 16,
                                      ),
                                      filled: true,
                                      fillColor: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 150,
                                      child: CupertinoPicker(
                                        itemExtent: 40,
                                        children: _englishLevelWriting
                                            .map(
                                              (String level) => Text(level),
                                            )
                                            .toList(),
                                        onSelectedItemChanged: (index) {
                                          _englishLevelWritingController.text =
                                              _englishLevelWriting[index];
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _englishLevelWritingController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: Colors.white),
                                      labelText: 'Nível de Inglês: Escrita',
                                      suffixIcon: Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(.75),
                                        fontSize: 16,
                                      ),
                                      filled: true,
                                      fillColor: Colors.black26,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (!_isKeyboardVisible)
                AnimatedPositioned(
                  bottom: 7,
                  right: _buttonWidthHalf + 20,
                  left: 10,
                  height: 34,
                  duration: Duration(milliseconds: 200),
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Voltar'),
                    //color: Colors.white,
                    textColor: Color(0xFFf15726),

                    borderSide:
                        BorderSide(color: Color(0xFFf15726), width: 1.0),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                      setState(() {
                        _isLastPage = false;
                      });
                    },
                  ),
                ),
              if (!_isKeyboardVisible)
                AnimatedPositioned(
                  bottom: 0,
                  left: _isLastPage ? _buttonWidthHalf + 20 : 10,
                  right: 10,
                  curve: Curves.linearToEaseOut,
                  duration: Duration(
                    milliseconds: 300,
                  ),
                  child: FlatButton(
                    child: Text(_isLastPage ? 'Submeter' : 'Proximo'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color(0xFFf15726),
                    textColor: Colors.white,
                    onPressed: _isLastPage ? _submitForm : _nextPage,
                  ),
                ),
              if (_submit)
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                    tileMode: TileMode.clamp,
                  )),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    setState(() {
      _isLastPage = true;
    });
  }

  void _submitForm() {
    setState(() {
      _submit = true;
      Timer(Duration(seconds: 5), _showMyDialog);
    });
  }

  void _showMyDialog() {
    print('depois de 5 seconds');
    setState(() {
      _submit = false;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/img/gestures/agile.png',
              height: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Olá!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/img/gestures/agile2.png',
              height: 25,
            ),
          ],
        ),
        content: Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Obrigado pela tua inscrição no processo de selecção do Programa de Graduados Absa. Se fores seleccionado, receberás um e-mail com os próximos passos. Continua atento às nossas oportunidades futuras. \n\nEquipa Absa',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Color(0xFFf15726),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Ok',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    ).then((_) {
      Timer(Duration(seconds: 1), () {
        print('a caminho da proxima pagina');
        Navigator.pushNamed(context, DISCSurveyPage.routeName);
      });
    });
  }
}

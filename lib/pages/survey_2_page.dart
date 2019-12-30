import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DISCSurveyPage extends StatefulWidget {
  static String routeName = '/disc-survey';
  @override
  _DISCSurveyPageState createState() => _DISCSurveyPageState();
}

class _DISCSurveyPageState extends State<DISCSurveyPage>
    with TickerProviderStateMixin {
  static const platform = const MethodChannel('graduados/changeOrientation');
  PageController _pageController;
  AnimationController _animationController;
  int indexDisc = 0;
  var _menos = [false, false, false, false];
  var _mais = [false, false, false, false];
  var _phrases = [
    {
      'D': 'Esforço-me por atingir objectivos',
      'C': 'Quero fazer as coisas bem feitas',
      'S': 'Estou disposto a ajudar',
      'I': 'Gosto de estar com pessoas',
    }
  ];

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      print('heliosndsndsi');
      try {
        platform.invokeMethod('forceOrientation');
      } on PlatformException catch (error) {
        print(error);
      }
      print('kjhjahachac');
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    _animationController = AnimationController(
        duration: const Duration(seconds: 1),
        animationBehavior: AnimationBehavior.preserve,
        vsync: this)
      ..repeat();

    _pageController = PageController(initialPage: indexDisc);
  }

  @override
  dispose() {
    if (Platform.isIOS) {
      print('default kskjanja');
      platform.invokeMethod('defaultOrientations');
      print('default nnnnnanaananananana');
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    _animationController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    platform.invokeMethod('forceOrientation');
    final _animation =
        Tween(begin: 24.0, end: 30.0).animate(_animationController);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: _buildBackgroundGradient()),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10,
                top: 10,
                child: Hero(
                  tag: 'absalogo',
                  child: Image.asset(
                    'assets/img/Absa_Logo_White.png',
                    height: 38,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Text(
                  'Olá, Nelson!',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              Positioned(
                //left: 0,
                right: MediaQuery.of(context).size.width * .47,
                top: 0,

                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, _) {
                    return IconButton(
                      //color: Colors.red,
                      icon: Icon(
                        Icons.info,
                        size: _animation.value,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Container(
                            width: MediaQuery.of(context).size.width * .7,
                            child: AlertDialog(
                              title: Text('Regrás'),
                              content: Text(
                                  'Escolhe uma frase que mais te caracteriza e uma frase que menos te caracteriza. \nNão há respostas certas ou erradas. Terás aproximadamente 10 minutos para preencher. '),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 150,
                right: 150,
                child: Container(
                  //color: Colors.amber,
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        indexDisc = index;
                      });
                    },
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DiscPhrase(
                              phrase: 'Esforço-me por atingir objectivos',
                              menos: _menos,
                              mais: _mais,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                                phrase: 'Quero fazer as coisas bem feitas',
                                menos: _menos,
                                mais: _mais),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                              phrase: 'Estou disposto a ajudar',
                              menos: _menos,
                              mais: _mais,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                              phrase: 'Gosto de estar com pessoas',
                              menos: _menos,
                              mais: _mais,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DiscPhrase(
                              phrase: 'Acabo sempre o que começo',
                              menos: _menos,
                              mais: _mais,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                                phrase: 'Vejo as coisas de forma positiva',
                                menos: _menos,
                                mais: _mais),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                              phrase: 'Mantenho as minhas decisões',
                              menos: _menos,
                              mais: _mais,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                              phrase: 'Sou paciente com os outros',
                              menos: _menos,
                              mais: _mais,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DiscPhrase(
                              phrase: 'Gosto de ajudar os outros',
                              menos: _menos,
                              mais: _mais,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                                phrase: 'Estou quase sempre feliz',
                                menos: _menos,
                                mais: _mais),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                              phrase: 'Gosto de fazer as coisas com precisão',
                              menos: _menos,
                              mais: _mais,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DiscPhrase(
                              phrase: 'Vejo o que precisa de ser mudado',
                              menos: _menos,
                              mais: _mais,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          color: Color(0xFFf15726),
                        ),
                      ),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInBack,
                        );
                      },
                    ),
                    Text(
                      '${indexDisc + 1}/26',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 300),
                      crossFadeState: indexDisc == 2
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: Container(
                        width: 100,
                        child: FlatButton(
                          child: Text(
                            'Próximo',
                            style: TextStyle(
                              color: Color(0xFFf15726),
                            ),
                          ),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                      secondChild: Container(
                        //color: Colors.white,
                        width: 100,
                        child: FlatButton(
                          color: Color(0xFFf15726),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Submeter',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
}

class DiscPhrase extends StatelessWidget {
  final String phrase;
  final List<bool> menos, mais;
  DiscPhrase({this.phrase, this.menos, this.mais});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFFf15726),
              ),
            ),
            height: 30,
            width: 70,
            child: Text(
              'Menos',
              style: TextStyle(color: Colors.white),
            ),
            alignment: Alignment.center,
          ),
        ),
        Text(
          phrase,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFFf15726),
              ),
            ),
            child: Text(
              'Mais',
              style: TextStyle(color: Colors.white),
            ),
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}

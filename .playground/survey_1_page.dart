import 'package:flutter/material.dart';

class SurveyOnePage extends StatefulWidget {
  static String routeName = '/survey-1';
  @override
  _SurveyOnePageState createState() => _SurveyOnePageState();
}

class _SurveyOnePageState extends State<SurveyOnePage> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Form(
              child: PageView(
                controller: _pageController,
                //physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 66, bottom: 20),
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Nome completo',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Tipo de documento',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Número de documento',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Provincia de residência',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Data de nascimento',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 66, bottom: 20),
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Quando terminou o curso?',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Tem certificado de conclusão do curso?',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText:
                              'Terá o certificado de conclusão do curso até 10 de Dezembro?',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText:
                              'Compreensão e fala: Qual é o seu nivel de Inglês',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Escrita: Qual é o seu nivel de Inglês',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              //color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Color.fromRGBO(66, 0, 0, 0.3),
                //     offset: Offset(0, 1),
                //   ),
                // ],
              ),
              padding: EdgeInsets.symmetric(vertical: 7),
              //height: 56,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: 'absalogo',
                    child: Image.asset(
                      'assets/img/absa.png',
                      height: 48,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/img/gestures/agile.png',
                        height: 40,
                      ),
                      Text(
                        'Preencha este formulario inicial',
                      ),
                      Image.asset(
                        'assets/img/gestures/agile2.png',
                        height: 60,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

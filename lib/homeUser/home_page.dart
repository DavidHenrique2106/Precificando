import 'package:flutter/material.dart';
import 'package:flora/ingredientes/model/IngredientsPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;
  bool isFABOpen = false;
  bool isDarkened = false;

  void showFABMenu() {
    setState(() {
      isFABOpen = true;
      isDarkened = true;
    });
  }

  void closeFABMenu() {
    setState(() {
      isFABOpen = false;
      isDarkened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(114, 133, 202, 1),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(114, 133, 202, 1),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.7),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2 * 0.15,
                  bottom: MediaQuery.of(context).size.height * 0.2 * 0.2,
                  left: MediaQuery.of(context).size.width * 0.40 * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9 * 0.3,
                          height: MediaQuery.of(context).size.width * 0.9 * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flora Matos',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.8 *
                                    0.07,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.2 *
                                  0.01,
                            ),
                            Text(
                              'Conta Diamante',
                              style: TextStyle(
                                color: Color.fromRGBO(128, 111, 111, 1),
                                fontSize: MediaQuery.of(context).size.width *
                                    0.8 *
                                    0.048,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2 * 0.12,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8 * 0.6,
                        height: MediaQuery.of(context).size.height * 0.2 * 0.30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Olá, Mundo!',
                              style: TextStyle(
                                color: Color(0xfff8f8f8),
                                fontSize: MediaQuery.of(context).size.width *
                                    0.8 *
                                    0.065,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(114, 133, 202, 1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Color(0xffd4d4d4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.55,
              left: 1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    'Atividades Recentes             ------',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: isDarkened ? 0.7 : 0.0,
            duration: Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: closeFABMenu,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: isFABOpen,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.14,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IngredientListPage()),
                          );
                        },
                        backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                        child: Text(
                          "Ingredientes",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.14,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cardapio');
                        },
                        backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                        child: Text(
                          "Cardápio",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.022),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16,
              child: FloatingActionButton(
                onPressed: () {
                  if (!isFABOpen) {
                    showFABMenu();
                  } else {
                    closeFABMenu();
                  }
                },
                child: Icon(
                  isFABOpen ? Icons.close : Icons.add,
                  size: MediaQuery.of(context).size.width * 0.08,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.08),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.078,
            color: Color.fromRGBO(217, 217, 217, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: MediaQuery.of(context).size.width * 0.14,
                    color: Color.fromRGBO(77, 91, 174, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.14),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width * 0.14,
                    color: Color.fromRGBO(77, 91, 174, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

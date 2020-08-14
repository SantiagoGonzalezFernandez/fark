//Imports that are not mine
import 'package:fark/src/pages/home/trabajadores/trabajadores_page.dart';
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/pages/home/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final pages = [
    Center(child: Text('OFERTAS')),
    TrabajadoresPage(),
    Center(child: Text('CHATS')),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xff2AB7CA),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            title: Text(
              'Ofertas',
              style: TextStyle(
                fontFamily: 'ProductSans'
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text(
              'Trabajadores',
              style: TextStyle(
                fontFamily: 'ProductSans'
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text(
              'Chats',
              style: TextStyle(
                fontFamily: 'ProductSans'
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Perfil',
              style: TextStyle(
                fontFamily: 'ProductSans'
              ),
            )
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
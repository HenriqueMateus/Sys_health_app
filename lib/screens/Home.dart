import 'package:flutter/material.dart';
import 'package:sys_health_app/AppRoutes.dart';
import 'package:sys_health_app/screens/loginGestor/index.dart';
import 'package:sys_health_app/screens/loginMedico/index.dart';
import 'loginAtendente/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  PageController page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: page,
          children: [
            LoginAtendente(),
            LoginMedico(),
            LoginGestor()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,

          items: [


            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle
              ),
              label: "Atendente",
              backgroundColor: Colors.deepPurpleAccent,

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Médico",
              backgroundColor: Colors.deepPurpleAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: "Gestor",
              backgroundColor: Colors.deepPurpleAccent,

            ),

          ],
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
            page.jumpToPage(index);
          },
        ),
      );
  }
}

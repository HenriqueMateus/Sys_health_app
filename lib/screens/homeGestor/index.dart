import 'package:flutter/material.dart';
import 'package:sys_health_app/screens/listagemMedicos/index.dart';
import 'package:sys_health_app/screens/registerAlas/index.dart';

class HomeGestor extends StatefulWidget {
  const HomeGestor({Key? key}) : super(key: key);

  @override
  _HomeGestorState createState() => _HomeGestorState();
}

class _HomeGestorState extends State<HomeGestor> {
  int _indexAtual = 0;
  PageController pagina = PageController();
  var items = ['Working a lot harder', 'Being a lot smarter', 'Being a self-starter', 'Placed in charge of trading charter'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pagina,
        children: [
          RegisterAlas(),
          ListagemMedicos()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _indexAtual,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.medication),
              label: "Alas",
              backgroundColor: Colors.deepPurpleAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: "Medicos",
              backgroundColor: Colors.deepPurpleAccent),
        ],
        onTap: (index) {
          setState(() {
            _indexAtual = index;
          });
          pagina.jumpToPage(index);
        },
      ),
    );
  }
}

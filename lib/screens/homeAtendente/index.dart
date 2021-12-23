import 'package:flutter/material.dart';
import 'package:sys_health_app/screens/listagemAlas/index.dart';
import 'package:sys_health_app/screens/listagemMedicos/index.dart';
import 'package:sys_health_app/screens/listagemPacientes/index.dart';

class HomeAtendente extends StatefulWidget {
  const HomeAtendente({Key? key}) : super(key: key);

  @override
  _HomeAtendenteState createState() => _HomeAtendenteState();
}

class _HomeAtendenteState extends State<HomeAtendente> {
  int _indexAtual = 0;
  PageController pagina = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: PageView(
            controller: pagina,
            children: [
              ListagemPacientes(),
              ListagemAlas(),

            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _indexAtual,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: "Pacientes",
                  backgroundColor: Colors.deepPurpleAccent
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medication),
                  label: "Alas",
                  backgroundColor: Colors.deepPurpleAccent
              ),


            ],
            onTap: (index){
              setState(() {
                _indexAtual = index;
              });
              pagina.jumpToPage(index);
            },
          ),
        );
  }
}

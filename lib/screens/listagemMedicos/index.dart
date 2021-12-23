import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/AppRoutes.dart';
import 'package:sys_health_app/database/MedicoDao.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/Usuario.dart';
import 'package:sys_health_app/screens/registerMedicos/index.dart';

class ListagemMedicos extends StatefulWidget {
  const ListagemMedicos({Key? key}) : super(key: key);

  @override
  _ListagemMedicosState createState() => _ListagemMedicosState();
}

class _ListagemMedicosState extends State<ListagemMedicos> {

  final dbRef = MedicoDao().listar();

  List<Medico> _medicos = [];
  void _recuperarMedicos() async {
    await dbRef.once().then((DataSnapshot snapshot) {
      setState(() {
        _medicos = <Medico>[];
        if (snapshot.value != null) {
          var dbTask = Map<String, dynamic>.from(snapshot.value);
          dbTask.forEach((key, value) {
            Usuario usuario = Usuario(
              value['usuario']['email'], value['usuario']['senha']
            );
            _medicos.add(Medico.id(
                key,
                value['crm'],
                value['nome'],
                value['sobrenome'],
                value['dataNasc'],
                value['endereco'],
                value['sexo'],
                value['cpf'],
                value['rg'],
                usuario));
          });
        }
      });
    });
  }

  void excluirMedico(Medico medico){
    MedicoDao().remover(medico);
  }


  @override
  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 45), () {
      _recuperarMedicos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicos'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterMedicos()));
          }),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: _medicos.length > 0
                ? ListView.builder(
                    itemCount: _medicos.length,
                    itemBuilder: (context, index) {
                      Medico medico = _medicos[index];
                      String _nome = "Nome: ${medico.nome} ${medico.sobrenome}";
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Title(
                              color: Colors.black,
                              child: Text(_nome),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Editar'),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.FORMMEDICO, arguments: medico
                                    ).then((value) =>
                                        _recuperarMedicos()
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Excluir'),
                                  onPressed: () {
                                    excluirMedico(medico);
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Nenhum Médico Encontrado",
                      style: TextStyle(
                        color: Theme.of(context).bottomAppBarColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
          ))
        ],
      ),
    );
  }
}

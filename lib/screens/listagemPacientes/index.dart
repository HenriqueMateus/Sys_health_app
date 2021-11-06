import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/AppRoutes.dart';
import 'package:sys_health_app/database/PacienteDao.dart';
import 'package:sys_health_app/models/Paciente.dart';


class ListagemPacientes extends StatefulWidget {
  const ListagemPacientes({Key? key}) : super(key: key);

  @override
  _ListagemPacientesState createState() => _ListagemPacientesState();
}

class _ListagemPacientesState extends State<ListagemPacientes> {
  final dbRef = PacienteDao().listar();
  List<Paciente> pacientes = <Paciente>[];
  void _recuperPacientes() async {
    await dbRef.once().then((DataSnapshot snapshot) {

      setState(() {
        pacientes = <Paciente>[];

        if (snapshot.value != null) {
          var dbTasks = Map<String, dynamic>.from(snapshot.value);

          dbTasks.forEach((key, paciente) {
            pacientes.add(
                Paciente.id(
                    key,
                    paciente['numPlano'],
                    paciente['ala'],
                    paciente['prioridade'],
                    paciente['nome'],
                    paciente['sobrenome'],
                    paciente['dataNasc'],
                    paciente['endereco'],
                    paciente['sexo'],
                    paciente['cpf'],
                    paciente['rg']
                )
            );
          });
        }
      });
    });
  }
  void excluirPaciente(Paciente paciente){
    PacienteDao().remover(paciente);
    _recuperPacientes();
  }
  @override
  initState(){
    super.initState();
    Future.delayed( Duration(milliseconds: 6000), () {
      _recuperPacientes();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
              Navigator.pushNamed(context, AppRoutes.FORMPACIENTE).then((value) =>
                _recuperPacientes()
              );
          }
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: pacientes.length > 0 ? ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  Paciente paciente = pacientes[index];
                  String _nome = "Nome: ${paciente.nome} ${paciente.sobrenome}" ;
                  return Card(
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Title(color: Colors.black,
                          child: Text(_nome),
                        )
                        ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Editar'),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.FORMPACIENTE, arguments: paciente
                                ).then((value) =>
                                    _recuperPacientes()
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Excluir'),
                              onPressed: () {
                                excluirPaciente(paciente);

                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),

                  );

                  // return Container();
                },
              ) : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Nenhuma tarefa",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

        ],

      ),
    );
  }
}

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/database/AlaDao.dart';
import 'package:sys_health_app/models/Ala.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/Paciente.dart';
import 'package:sys_health_app/models/Usuario.dart';

import '../../AppRoutes.dart';

class ListagemAlas extends StatefulWidget {
  final String responsavel;
  const ListagemAlas({Key? key,
    this.responsavel = ''
  }) : super(key: key);

  @override
  _ListagemAlasState createState() => _ListagemAlasState();
}

class _ListagemAlasState extends State<ListagemAlas> {
  final dbRef = AlaDao().listar();
  List<Ala> alas = <Ala>[];
  void _recuperAlas() async {
    await dbRef.once().then((DataSnapshot snapshot) {

      setState(() {
        alas = <Ala>[];

        if (snapshot.value != null) {
          var dbTasks = Map<String, dynamic>.from(snapshot.value);

          dbTasks.forEach((key, ala) {
             print(ala);
             var medicosList = Map<dynamic, dynamic>.from(ala['medicos']);
             List<Object?> filasPacienteList = ala['pacientes'];
             List<Medico> medicos = [];
             List<List<Paciente>> pacientes = [];
             filasPacienteList.forEach((element) {
               if(element != null){

               }
               var pacientesList = json.encode(element);

             });
             medicosList.forEach((key, value) {
               Usuario usuario = Usuario(
                   value['usuario']['email'], value['usuario']['senha']
               );
               medicos.add(Medico.id(
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
             //int tamanhoMax= int.parse(ala['tamanhoMaximo']);
             //int totalFilas = int.parse(ala['totalFilas']);
             //int quantidadeMaximaMedicos = int.parse(ala['quantMedicos']);
             alas.add(
                Ala.id(
                    key,
                    ala['nome'],
                    ala['descricao'],
                    ala['tamanhoMaximo'],
                    ala['totalFilas'],
                    ala['quantMedicos'],
                    [],
                    medicos
                )
            );
          });
        }
      });
    });
  }
  String responsavel = '';
  @override
  void initState() {
    Future.delayed( Duration(milliseconds: 45), (){
      _recuperAlas();
    });
    super.initState();
    responsavel = widget.responsavel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alas'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, AppRoutes.FORMALA).then((value) =>
                _recuperAlas()
            );
          }
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: alas.length > 0 ? ListView.builder(
                itemCount: alas.length,
                itemBuilder: (context, index) {
                  Ala ala = alas[index];
                  int totalPacientes = 0;
                  ala.filas.map((e) => totalPacientes += e.length);

                  String _nome = "Nome: ${ala.nome}  "
                      "Total de Pacientes: $totalPacientes" ;
                  return Card(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            height: responsavel == 'gestor'? 70: 60,
                            child: Column( children: <Widget>[
                              Title(color: Colors.black,
                                  child: Text(_nome, style: TextStyle(fontSize: responsavel == 'gestor'? 17: 18,
                                      fontWeight: FontWeight.bold),)),
                              responsavel == 'gestor'?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Editar'),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.FORMALA, arguments: ala
                                      ).then((value) =>
                                          _recuperAlas()
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('Excluir'),
                                    onPressed: () {

                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ): Column()
                            ]),
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

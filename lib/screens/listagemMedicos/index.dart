import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/database/MedicoDao.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/screens/registerMedicos/index.dart';
class ListagemMedicos extends StatefulWidget {
  const ListagemMedicos({Key? key}) : super(key: key);

  @override
  _ListagemMedicosState createState() => _ListagemMedicosState();
}

class _ListagemMedicosState extends State<ListagemMedicos> {
  final dbRef = MedicoDao(FirebaseDatabase.instance.reference().child('Medico'))
      .listar();
  List<Medico> _medicos = [];

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
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterMedicos()));
          }
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: dbRef.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var lists = [];

                  if(snapshot.data != null){
                    Map<dynamic, dynamic> values = snapshot.data!.value;
                    values.forEach((key, values) {
                      lists.add(values);
                    });
                  }

                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        String _nome = "Nome: ${lists[index]['nome']} ${lists[index]['sobrenome']}" ;
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
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Text('Excluir'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),

                        );
                      });
                }
                return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}

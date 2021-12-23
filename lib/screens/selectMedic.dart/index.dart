import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/components/MedicoItemList.dart';
import 'package:sys_health_app/database/AlaDao.dart';
import 'package:sys_health_app/models/Ala.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/Usuario.dart';


class MedicoMultSelect extends StatefulWidget {
  final List<String> medicos;

  const MedicoMultSelect({
    Key? key,
    this.medicos = const [],

  }) : super(key: key);

  @override
  _MedicoMultSelectState createState() => _MedicoMultSelectState();
}

class _MedicoMultSelectState extends State<MedicoMultSelect> {
  final dbRef = AlaDao().listar();
  List<Medico> medicos = <Medico>[];
  List<String> medicosSelecionado = [];

  get selecionarMedico => (Medico medico){
    final estaSelecionado = medicosSelecionado.contains(medico.idMedico);
    setState(() {
      estaSelecionado ? medicosSelecionado.remove(medico.idMedico):
      medicosSelecionado.add(medico.idMedico);
    });
  };


  void _loadDataMedicos() async {

    await dbRef.once().then((DataSnapshot snapshot) {
      setState(() {
        medicos = <Medico>[];
        if (snapshot.value != null) {
          var dbTasks = Map<String, dynamic>.from(snapshot.value);

          dbTasks.forEach((key, medico) {
            Usuario user = new Usuario.fromJson(medico['usuario']);
            medicos.add(
                Medico.id(
                    key,
                    medico['crm'],
                    medico['nome'],
                    medico['sobrenome'],
                    medico['dataNasc'],
                    medico['endereco'],
                    medico['sexo'],
                    medico['cpf'],
                    medico['rg'],
                    user
                )
            );
          });
        }
      });
    });
  }

  @override
  void initState() {
    medicosSelecionado = widget.medicos;
    super.initState();
    Future.delayed(Duration(seconds: 5), (){
      _loadDataMedicos();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione: '),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: medicos.length > 0 ?
              ListView.builder(
                itemCount: medicos.length,
                itemBuilder: (BuildContext context, int index) {
                final estaSelecionado = medicosSelecionado
                    .contains(medicos[index].idMedico);
                return MedicoItemlist(medico: medicos[index],
                    estaSelecionado: estaSelecionado,
                    selecionarMedico: selecionarMedico
                );
              },


              ) : Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Nenhum Medico",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                  ),
                ),
              )
          ),
          buildSelectButton(context),
        ],
      )
    );
  }
  Widget buildSelectButton(BuildContext context) {
    final label = 'Select ${medicosSelecionado.length} Countries';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      color: Theme.of(context).primaryColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          primary: Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        onPressed: submit,
      ),
    );
  }
  void submit() => Navigator.pop(context, medicosSelecionado);
}

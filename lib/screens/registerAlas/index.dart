
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/components/Editor.dart';
import 'package:sys_health_app/database/AlaDao.dart';
import 'package:sys_health_app/database/MedicoDao.dart';
import 'package:sys_health_app/models/Ala.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/Paciente.dart';
import 'package:sys_health_app/models/Usuario.dart';
import 'package:sys_health_app/screens/selectMedic.dart/index.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterAlas extends StatefulWidget {
  const RegisterAlas({Key? key}) : super(key: key);

  @override
  _RegisterAlasState createState() => _RegisterAlasState();
}

class _RegisterAlasState extends State<RegisterAlas> {
  final dbRef = AlaDao()
      .listar();
  final dbRefMedico = MedicoDao().listar();
  late final TextEditingController _controleNome;
  late final TextEditingController _controleDescricao;
  late final TextEditingController _controleTamanhoMaximo;
  late final TextEditingController _controleTotalFila;
  late final TextEditingController _controleQuantMaxMedicos;
  String idAla = '';
  List<List<Paciente>> filas = [];
  List<Medico> medicosList = [];
  List<Object?> medicosSelecionados = [];
  List<Medico> medicos = [];
  bool editar = false;
  List<MultiSelectItem<Object?>> _items = [];

  void cadastrarAlas(){
    medicosSelecionados.forEach((med) {
      Object? medicoOb = med;
      var jsMedico = json.encode(medicoOb);
      Map<String, dynamic> jsonDataMedico = json.decode(jsMedico) as Map<String, dynamic>;
      Medico medico = Medico.fromJson(jsonDataMedico);
      medicos.add(medico);
    });


    Ala? ala;
    int tamanhoMax = int.parse(_controleTamanhoMaximo.text);
    int totalMaxFila = int.parse(_controleTotalFila.text);
    int quantiMaxMedico = int.parse(_controleQuantMaxMedicos.text);
    AlaDao alaDao = AlaDao();
    if(!editar){
      ala = Ala(_controleNome.text,
          _controleDescricao.text,
          tamanhoMax,
          totalMaxFila,
          quantiMaxMedico
      );
      AlaDao().cadastrar(ala);
      AlaDao().adicionarMedicos(ala, medicos);
    } else {
      ala = Ala.id(
          idAla,
          _controleNome.text,
          _controleDescricao.text,
          tamanhoMax,
          totalMaxFila,
          quantiMaxMedico,
          filas,
          medicos
      );
      AlaDao().alterar(ala);
    }
    Navigator.of(context).pop();
  }
  void _loadDataMedicos() async {

    await dbRefMedico.once().then((DataSnapshot snapshot) {
      setState(() {
        medicosList = <Medico>[];
        if (snapshot.value != null) {
          var dbTasks = Map<dynamic, dynamic>.from(snapshot.value);

          dbTasks.forEach((key, medico) {
            /*Usuario user = new Usuario.fromJson(medico['usuario']);*/
            Usuario user = Usuario(
                medico['usuario']['email'], medico['usuario']['senha']
            );
            var medicoId = Medico.id(
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
            );
            _items.add(MultiSelectItem<Medico>(medicoId, medicoId.nome));
            medicosList.add(
                medicoId
            );
          });
        }
      });
    });
  }

  void _loadForm(Ala ala){
      _controleNome.text = ala.nome;
      _controleTamanhoMaximo.text = ala.tamanhoMaximo as String;
      _controleDescricao.text = ala.descricao;
      _controleQuantMaxMedicos.text = ala.quantidadeMaximaMedicos as String;
      _controleTotalFila.text = ala.totalFilas as String;
      filas = ala.filas;
      medicos = ala.medicos;
  }
  @override
  void initState() {

    medicosSelecionados = medicosList;
    super.initState();
    _controleNome = TextEditingController();
    _controleDescricao = TextEditingController();
    _controleTamanhoMaximo = TextEditingController();
    _controleTotalFila = TextEditingController();
    _controleQuantMaxMedicos = TextEditingController();
    Future.delayed(Duration(seconds: 5), (){
      _loadDataMedicos();

    });
  }

  @override
  Widget build(BuildContext context) {

    final ala = ModalRoute.of(context)?.settings.arguments != null?
    ModalRoute.of(context)?.settings.arguments as Ala: null;
    if(ala != null){
      editar = true;
      _loadForm(ala);
    }
    return Scaffold(
      appBar: AppBar(
          title: Text("Cadastro"), backgroundColor: Colors.deepPurpleAccent),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Editor(
                controlador: _controleNome,
                rotulo: "Nome",
                dica: "dica",
                tipe: TextInputType.text),
            Editor(
                controlador: _controleDescricao,
                rotulo: "Descrição",
                dica: "dica",
                icone: Icons.short_text,
                tipe: TextInputType.text),
            Editor(
                controlador: _controleTamanhoMaximo,
                rotulo: "Quantidade Máxima de Pacientes",
                dica: "dica",
                icone: Icons.groups,
                tipe: TextInputType.number),
            Editor(
                controlador: _controleTotalFila,
                rotulo: "Quantidade Máxima de Filas",
                dica: "dica",
                icone: Icons.table_rows,
                tipe: TextInputType.number),
            Editor(
                controlador: _controleQuantMaxMedicos,
                rotulo: "Quantidade Máxima de Medicos",
                dica: "dica",
                icone: Icons.groups,
                tipe: TextInputType.number),
            MultiSelectBottomSheetField(
              initialChildSize: 0.4,
              listType: MultiSelectListType.CHIP,
              searchable: true,
              buttonText: Text("Medicos"),
              title: Text("Medico"),
              items: _items,
              onConfirm: (values) {
                medicosSelecionados = values;
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    medicosSelecionados.remove(value);
                  });
                },
              ),
            ),
            medicosSelecionados.isEmpty
                ? Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "None selected",
                  style: TextStyle(color: Colors.black54),
                ))
                : Container(),
            ElevatedButton(onPressed: cadastrarAlas, child: Text('confirmar'))
          ],
        ),
      ),
    );
  }

}

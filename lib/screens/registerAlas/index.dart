import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/components/Editor.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:sys_health_app/database/MedicoDao.dart';
import 'package:sys_health_app/database/PacienteDao.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/MedicoViewModel.dart';
import 'package:sys_health_app/models/Usuario.dart';

class RegisterAlas extends StatefulWidget {
  const RegisterAlas({Key? key}) : super(key: key);

  @override
  _RegisterAlasState createState() => _RegisterAlasState();
}

class _RegisterAlasState extends State<RegisterAlas> {
  final dbRef = MedicoDao(FirebaseDatabase.instance.reference()
      .child('Medicos'))
      .listar();
  late final TextEditingController _controleNome;
  late final TextEditingController _controleDescricao;
  late final TextEditingController _controleExemploDrop;
  late final TextEditingController _controleMedicos;

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
  var items = [
    'Working a lot harder',
    'Being a lot smarter',
    'Being a self-starter',
    'Placed in charge of trading charter'
  ];
  List<Medico> medicos = <Medico>[];
  @override
  void initState() {
    super.initState();
    _controleNome = TextEditingController();
    _controleDescricao = TextEditingController();
    _controleExemploDrop = TextEditingController();
    _controleMedicos = TextEditingController();


    Future.delayed(Duration(milliseconds: 6000), () {
      _loadDataMedicos();
      print(medicos);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                tipe: TextInputType.text),
            Editor(
                controlador: _controleDescricao,
                rotulo: "Classificação",
                dica: "dica",
                tipe: TextInputType.text),
            Editor(
                controlador: _controleDescricao,
                rotulo: "Quantidade Máxima de Pacientes",
                dica: "dica",
                tipe: TextInputType.number),

          ],
        ),
      ),
    );
  }
}

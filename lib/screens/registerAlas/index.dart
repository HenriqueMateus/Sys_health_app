import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/components/Editor.dart';
import 'package:sys_health_app/database/AlaDao.dart';
import 'package:sys_health_app/database/MedicoDao.dart';
import 'package:sys_health_app/database/PacienteDao.dart';
import 'package:sys_health_app/models/Ala.dart';
import 'package:sys_health_app/models/Fila.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/MedicoViewModel.dart';
import 'package:sys_health_app/models/Usuario.dart';

class RegisterAlas extends StatefulWidget {
  const RegisterAlas({Key? key}) : super(key: key);

  @override
  _RegisterAlasState createState() => _RegisterAlasState();
}

class _RegisterAlasState extends State<RegisterAlas> {
  final dbRef = MedicoDao()
      .listar();
  late final TextEditingController _controleNome;
  late final TextEditingController _controleDescricao;
  late final TextEditingController _controleTamanhoMaximo;
  late final TextEditingController _controleTotalFila;
  late final TextEditingController _controleQuantMaxMedicos;
  String idAla = '';
  List<Fila> filas = <Fila>[];
  List<Medico> medicos = <Medico>[];
  bool editar = false;
  void cadastrarAlas(){
    Ala? ala;
    int tamanhoMax = int.parse(_controleTamanhoMaximo.text);
    int totalMaxFila = int.parse(_controleTotalFila.text);
    int quantiMaxMedico = int.parse(_controleQuantMaxMedicos.text);
    AlaDao alaDao = AlaDao(FirebaseDatabase.instance.reference().child("Alas"));
    if(!editar){
      ala = Ala(_controleNome.text,
          _controleDescricao.text,
          tamanhoMax,
          totalMaxFila,
          quantiMaxMedico
      );
      alaDao.cadastrar(ala);
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
      alaDao.alterar(ala);
    }
    Navigator.of(context).pop();
  }

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
    super.initState();
    _controleNome = TextEditingController();
    _controleDescricao = TextEditingController();
    _controleTamanhoMaximo = TextEditingController();
    _controleTotalFila = TextEditingController();
    _controleQuantMaxMedicos = TextEditingController();

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
                rotulo: "Quantidade Máxima de Pacientes",
                dica: "dica",
                tipe: TextInputType.number),
            Editor(
                controlador: _controleTotalFila,
                rotulo: "Quantidade Máxima de Filas",
                dica: "dica",
                tipe: TextInputType.number),
            Editor(
                controlador: _controleQuantMaxMedicos,
                rotulo: "Quantidade Máxima de Medicos",
                dica: "dica",
                tipe: TextInputType.number),
            ElevatedButton(onPressed: cadastrarAlas, child: Text('confirmar'))
          ],
        ),
      ),
    );
  }
}

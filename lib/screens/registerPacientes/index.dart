import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/components/Editor.dart';
import 'package:sys_health_app/components/padding_label_with_widget.dart';
import 'package:sys_health_app/database/AlaDao.dart';
import 'package:sys_health_app/database/PacienteDao.dart';
import 'package:sys_health_app/models/Ala.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/Paciente.dart';
import 'package:sys_health_app/models/Usuario.dart';

class RegisterPacientes extends StatefulWidget {

  @override
  _RegisterPacientesState createState() => _RegisterPacientesState();
}

class _RegisterPacientesState extends State<RegisterPacientes> {

  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleSobrenome = TextEditingController();
  final TextEditingController _controleCPF = TextEditingController();
  final TextEditingController _controleRG = TextEditingController();
  final TextEditingController _controleDataNacimento = TextEditingController();
  final TextEditingController _controleEndereco = TextEditingController();
  final TextEditingController _controleNumPlano = TextEditingController();
  late final TextEditingController _controleSexo;
  String idPaciente = '';
  Ala ala = new Ala("","",1,1,1);
  String prioridade = '';
  List<String> prioridadeList = [''];
  var sexo = ['Masculino','Feminino','Outros'];
  bool editar = false;
  var dbRef = AlaDao().listar();
  List<Ala> alas = [];
  void registerEnter() {

    final paciente = Paciente(
        _controleNumPlano.text,
        ala.nome,
        prioridade,
        _controleNome.text,
        _controleSobrenome.text,
        _controleDataNacimento.text,
        _controleEndereco.text,
        _controleSexo.text,
        _controleCPF.text,
        _controleRG.text
    );

    if(!editar){
      PacienteDao().cadastrar(paciente);
      AlaDao().adicionarPacientes(paciente);
    } else {
      final pacienteId = Paciente.id(
          idPaciente,
          _controleNumPlano.text,
          ala.nome,
          prioridade,
          _controleNome.text,
          _controleSobrenome.text,
          _controleDataNacimento.text,
          _controleEndereco.text,
          _controleSexo.text,
          _controleCPF.text,
          _controleRG.text
      );
      PacienteDao().alterar(pacienteId);
    }
    Navigator.of(context).pop();

  }
  void _LoadForm(Paciente paciente){
    idPaciente = paciente.idPaciente;
    ala = paciente.ala;
    prioridade = paciente.prioridade;
    _controleNome.text = paciente.nome;
    _controleSobrenome.text = paciente.sobrenome;
    _controleNumPlano.text = paciente.numPlano;
    _controleEndereco.text = paciente.endereco;
    _controleRG.text = paciente.rg;
    _controleCPF.text = paciente.cpf;
    _controleSexo.text = paciente.sexo;
    _controleDataNacimento.text = paciente.dataNasc;
  }
  void _recuperAlas() async {
    await dbRef.once().then((DataSnapshot snapshot) {
      setState(() {
        alas = <Ala>[];
        if (snapshot.value != null) {
          var dbTasks = Map<String, dynamic>.from(snapshot.value);
          dbTasks.forEach((key, ala) {
            var medicosList = Map<dynamic, dynamic>.from(ala['medicos']);
            List<Medico> medicos = [];
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
            setPrioridade(alas.first);
            //ala = alas.first;
          });
        }
      });
    });
  }
  void setPrioridade(Ala ala){
    setState(() {

      prioridadeList = List.generate(ala.totalFilas, (index) =>  "${index + 1}").toList();
    });
  }
  @override
  void initState() {
    _controleSexo = TextEditingController();
    alas.insert(0, ala);
    Future.delayed(Duration(milliseconds: 5), (){
      _recuperAlas();
    });

    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    final paciente = ModalRoute.of(context)?.settings.arguments != null?
    ModalRoute.of(context)?.settings.arguments as Paciente: null;
    if(paciente != null){
      editar = true;
      _LoadForm(paciente);
    }
    List<DropdownMenuItem<Ala>> items = alas.map((item) {
      return DropdownMenuItem<Ala>(
        child: Text(item.nome),
        value: item,
      );
    }).toList();
    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          child: Text(ala.nome),
          value: ala,
        )
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Editor(
                controlador: _controleNome,
                rotulo: "Nome",
                dica: "",
                icone: Icons.person,
                tipe: TextInputType.name),
            Editor(
                controlador: _controleSobrenome,
                rotulo: "Sobrenome",
                dica: '',
                icone: Icons.person,
                tipe: TextInputType.name),
            Editor(
                controlador: _controleCPF,
                rotulo: "CPF",
                dica: '',
                icone: Icons.perm_identity,
                tipe: TextInputType.number),
            Editor(
                controlador: _controleRG,
                rotulo: "RG",
                dica: '',
                icone: Icons.perm_identity,
                tipe: TextInputType.number),
            Editor(
                controlador: _controleDataNacimento,
                rotulo: "Data de Nascimento",
                dica: '',
                icone: Icons.perm_identity,
                tipe: TextInputType.datetime),
            Padding(padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controleSexo,

                decoration: InputDecoration(
                  labelText: "Sexo",
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value){
                      _controleSexo.text = value;
                    },
                    itemBuilder: (BuildContext context){
                      return sexo
                          .map<PopupMenuItem<String>>((String value){
                        return new PopupMenuItem(child:
                          new Text(value), value: value
                        );
                      }).toList();
                    },
                  )
                ),
              ),

            ),

            Editor(
                controlador: _controleNumPlano,
                rotulo: "Número do Plano",
                dica: '',
                icone: Icons.pin,
                tipe: TextInputType.number
            ),
            Editor(
                controlador: _controleEndereco,
                rotulo: "Endereço",
                dica: '',
                icone: Icons.house,
                tipe: TextInputType.streetAddress
            ),
            PaddingLabelWithWidget(
              textPadding: EdgeInsets.only(left: 100, top: 20, right: 10),
              label: Text("ALA"),
              child: DropdownButton<Ala>(
                value: alas.first,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: items,
                hint: Text(
                  "Please choose a langauage",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (Ala? value) {
                  setState(() {
                    ala = value!;
                    setPrioridade(value);
                  });
                },
              ),
            ),
            PaddingLabelWithWidget(

              label: Text("Prioridade"),
              child: DropdownButton<String>(
                value: prioridadeList.first,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: prioridadeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Please choose a langauage",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String? value) {
                  setState(() {
                    prioridade = value!;
                  });
                },
              ),
            ),
            ElevatedButton(onPressed: registerEnter, child: Text('confirmar'))
          ],
        ),
      ),
    );
  }
}

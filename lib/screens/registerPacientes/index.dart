import 'package:flutter/material.dart';
import 'package:sys_health_app/components/Editor.dart';
import 'package:sys_health_app/components/padding_label_with_widget.dart';
import 'package:sys_health_app/database/PacienteDao.dart';
import 'package:sys_health_app/models/Paciente.dart';

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
  String ala = '';
  String prioridade = '';
  var sexo = ['Masculino','Feminino','Outros'];
  bool editar = false;
  void registerEnter() {
    final paciente = Paciente(
        _controleNumPlano.text,
        ala,
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
      PacienteDao().cadastrarPaciente(paciente);
    } else {
      final pacienteId = Paciente.id(
          idPaciente,
          _controleNumPlano.text,
          ala,
          prioridade,
          _controleNome.text,
          _controleSobrenome.text,
          _controleDataNacimento.text,
          _controleEndereco.text,
          _controleSexo.text,
          _controleCPF.text,
          _controleRG.text
      );
      PacienteDao().alterarPaciente(pacienteId);
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
    sexo = paciente.sexo;
    _controleDataNacimento.text = paciente.dataNasc;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controleSexo = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {

    final paciente = ModalRoute.of(context)?.settings.arguments != null? ModalRoute.of(context)?.settings.arguments as Paciente: null;
    if(paciente != null){
      editar = true;
      _LoadForm(paciente);
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
              child: DropdownButton<String>(
                value: ala,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                  '',
                  'A',
                  'B',
                  'C',
                  'D'
                ].map<DropdownMenuItem<String>>((String value) {
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
                    ala = value!;
                  });
                },
              ),
            ),
            PaddingLabelWithWidget(

              label: Text("Prioridade"),
              child: DropdownButton<String>(
                value: prioridade,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                  '',
                  '1',
                  '2',
                  '3',
                  '4'
                ].map<DropdownMenuItem<String>>((String value) {
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

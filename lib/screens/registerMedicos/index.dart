import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sys_health_app/components/Editor.dart';
import 'package:sys_health_app/components/EditorMultiOp.dart';
import 'package:sys_health_app/components/padding_label_with_widget.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/database/MedicoDao.dart';
import 'package:sys_health_app/models/Usuario.dart';

class RegisterMedicos extends StatefulWidget {
  const RegisterMedicos({Key? key}) : super(key: key);

  @override
  _RegisterMedicosState createState() => _RegisterMedicosState();
}

class _RegisterMedicosState extends State<RegisterMedicos> {
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleSobrenome = TextEditingController();
  final TextEditingController _controleCPF = TextEditingController();
  final TextEditingController _controleRG = TextEditingController();
  final TextEditingController _controleCRM = TextEditingController();
  final TextEditingController _controleDataNacimento = TextEditingController();
  final TextEditingController _controleEndereco = TextEditingController();
  final TextEditingController _controleEmail = TextEditingController();
  final TextEditingController _controleSexo = TextEditingController();
  final TextEditingController _controleSenha = TextEditingController();
  var sexo = ['Masculino','Feminino','Outros'];
  String idMedico = '';
  String _chosenValue = '';
  bool editar = false;
  void registerEnter() {
    Usuario usuario = new Usuario(_controleEmail.text, _controleSenha.text);
    Medico? medico = Medico(
        _controleCRM.text,
        _controleNome.text,
        _controleSobrenome.text,
        _controleDataNacimento.text,
        _controleEndereco.text,
        _chosenValue,
        _controleCPF.text,
        _controleRG.text,
        usuario);
    if (!editar) {
      MedicoDao().cadastrar(medico);
    } else {
      medico.idMedico = idMedico;
      print(medico.toJson());
      MedicoDao().alterar(medico);
    }
  }

  void _LoadForm(Medico medico) {
    idMedico = medico.idMedico;
    _controleCRM.text = medico.crm;
    _controleNome.text = medico.nome;
    _controleSobrenome.text = medico.sobrenome;
    _controleDataNacimento.text = medico.dataNasc;
    _controleEndereco.text = medico.endereco;
    _controleSexo.text = medico.sexo;
    _controleCPF.text = medico.cpf;
    _controleRG.text = medico.rg;
    _controleEmail.text = medico.usuario.email;
    _controleSenha.text = medico.usuario.senha;
  }

  @override
  Widget build(BuildContext context) {
    final medico = ModalRoute.of(context)?.settings.arguments != null
        ? ModalRoute.of(context)?.settings.arguments as Medico
        : null;
    if (medico != null) {
      editar = true;
      _LoadForm(medico);
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
                controlador: _controleCRM,
                rotulo: "CRM",
                dica: '',
                icone: Icons.perm_identity,
                tipe: TextInputType.number),
            Editor(
                controlador: _controleDataNacimento,
                rotulo: "Data de Nascimento",
                dica: '',
                icone: Icons.perm_identity,
                tipe: TextInputType.datetime),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controleSexo,
                decoration: InputDecoration(
                    labelText: "Sexo",
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        _controleSexo.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return sexo.map<PopupMenuItem<String>>((String value) {
                          return new PopupMenuItem(
                              child: new Text(value), value: value);
                        }).toList();
                      },
                    )),
              ),
            ),
            Editor(
                controlador: _controleEndereco,
                rotulo: "Endereço",
                dica: '',
                icone: Icons.house,
                tipe: TextInputType.streetAddress),
            Editor(
                controlador: _controleEmail,
                rotulo: "Email",
                dica: '',
                icone: Icons.email,
                tipe: TextInputType.emailAddress),
            Editor(
                controlador: _controleSenha,
                rotulo: "Senha",
                dica: '',
                icone: Icons.password,
                tipe: TextInputType.visiblePassword),
            ElevatedButton(onPressed: registerEnter, child: Text('confirmar'))
          ],
        ),
      ),
    );
  }
}

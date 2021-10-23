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
  String _chosenValue = '';
  void registerEnter() {
    Usuario usuario = new Usuario(_controleEmail.text, _controleSenha.text);
    final medico = Medico(
        _controleCRM.text,
        _controleNome.text,
        _controleSobrenome.text,
        _controleDataNacimento.text,
        _controleEndereco.text,
        _chosenValue,
        _controleCPF.text,
        _controleRG.text,
        usuario
    );

    MedicoDao(FirebaseDatabase.instance.reference().child('Medicos'))
        .cadastrar(medico);
  }

  @override
  Widget build(BuildContext context) {
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

            PaddingLabelWithWidget(
              textPadding: EdgeInsets.only(left: 100, top: 20, right: 10),
              label: Text("Sexo"),
              child: DropdownButton<String>(
                value: _chosenValue,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                  '',
                  'Masculino',
                  'Feminino',
                  'Outros'
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
                    _chosenValue = value!;
                  });
                },
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

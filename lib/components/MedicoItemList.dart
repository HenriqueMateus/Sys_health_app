import 'package:flutter/material.dart';
import 'package:sys_health_app/models/Medico.dart';

class MedicoItemlist extends StatelessWidget {
  const MedicoItemlist({
    Key? key,
    required this.medico,
    required this.estaSelecionado,
    required this.selecionarMedico
  }) : super(key: key);

  final Medico medico;
  final bool estaSelecionado;
  final ValueChanged<Medico> selecionarMedico;

  @override
  Widget build(BuildContext context) {
    final texto = estaSelecionado? TextStyle(
      fontSize: 18,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold
    ) : TextStyle( fontSize: 18);
    return ListTile(
        onTap: () => selecionarMedico(medico),
        title: Text(
            medico.nome,
            style: texto
        ),
    );
  }
}

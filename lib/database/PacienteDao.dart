import 'package:firebase_database/firebase_database.dart';
import 'package:sys_health_app/database/DAO.dart';
import 'package:sys_health_app/models/Paciente.dart';

class PacienteDao implements DAO<Paciente> {
  final DatabaseReference __ref =
  FirebaseDatabase.instance.reference().child('Paciente');

  @override
  void alterar(Paciente value) {
    __ref.child(value.idPaciente).update(value.toJson());
  }

  @override
  void cadastrar(Paciente value) {
    __ref.push().set(value.toJson());
  }

  @override
  Query listar() {
    return __ref;
  }

  @override
  void remover(Paciente value) {
    __ref.child(value.idPaciente).remove();
  }
}
import 'package:firebase_database/firebase_database.dart';
import 'package:sys_health_app/models/Paciente.dart';

class PacienteDao {
  final DatabaseReference __pacienteRef =
  FirebaseDatabase.instance.reference().child('Paciente');
  void cadastrarPaciente(Paciente paciente){
    __pacienteRef.push().set(paciente.toJson());
  }
  Query listarPaciente(){
    return __pacienteRef;
  }
  void alterarPaciente(Paciente paciente){
    __pacienteRef.child(paciente.idPaciente).update(paciente.toJson());
  }
  void excluirPaciente(Paciente paciente){
    __pacienteRef.child(paciente.idPaciente).remove();
  }
}
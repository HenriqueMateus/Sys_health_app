import 'package:firebase_database/firebase_database.dart';
import 'package:sys_health_app/database/DAO.dart';
import 'package:sys_health_app/models/Ala.dart';
import 'package:sys_health_app/models/Medico.dart';
import 'package:sys_health_app/models/Paciente.dart';

class AlaDao implements DAO<Ala>{
  DatabaseReference __ref = FirebaseDatabase.instance.reference().child('Alas');


  @override
  void cadastrar(Ala value) {
    __ref.child(value.nome).set(value.toJson());
  }
  void adicionarMedicos(Ala value, List<Medico> medicosList){
    medicosList.forEach((element) {
      __ref.child(value.nome).child('medicos').push().set(element.toJson());
    });
  }
  void adicionarPacientes(Paciente paciente){
    __ref.child(paciente.ala).child('pacientes').child(paciente.prioridade)
        .push().set(paciente.toJson());

  }
  @override
  Query listar() {
    return __ref;
  }

  @override
  void alterar(Ala value) {
    __ref.child(value.id).update(value.toJson());
  }

  @override
  void remover(Ala value) {
    __ref.child(value.id).remove();
  }

}
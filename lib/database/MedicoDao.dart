import 'package:firebase_database/firebase_database.dart';
import 'package:sys_health_app/database/DAO.dart';
import 'package:sys_health_app/models/Medico.dart';

class MedicoDao implements DAO<Medico> {

  DatabaseReference __ref = FirebaseDatabase
      .instance.reference().child('Medicos');

  @override
  void cadastrar(Medico medico) {
    __ref.push().set(medico.toJson());
  }

  @override
  Query listar() {
    return __ref;
  }

  @override
  void alterar(Medico value) {
    __ref.child(value.idMedico).update(value.toJson());
  }

  @override
  void remover(Medico value) {
    __ref.child(value.idMedico).remove();
  }




}
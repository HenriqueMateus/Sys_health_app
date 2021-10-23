import 'package:firebase_database/firebase_database.dart';
import 'package:sys_health_app/database/DAO.dart';
import 'package:sys_health_app/models/Medico.dart';

class MedicoDao implements DAO<Medico> {

  @override
  late DatabaseReference __ref;

  MedicoDao(this.__ref);

  @override
  void cadastrar(Medico medico) {
    __ref.push().set(medico.toJson());
  }

  @override
  Query listar() {
    return __ref;
  }




}
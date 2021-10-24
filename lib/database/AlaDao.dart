import 'package:firebase_database/firebase_database.dart';
import 'package:sys_health_app/database/DAO.dart';
import 'package:sys_health_app/models/Ala.dart';

class AlaDao implements DAO<Ala>{
  DatabaseReference __ref;
  AlaDao(this.__ref);

  @override
  void cadastrar(Ala value) {
    __ref.push().set(value.toJson());
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
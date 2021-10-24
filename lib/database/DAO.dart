import 'package:firebase_database/firebase_database.dart';

abstract class DAO<T> {
  void cadastrar(T value);
  void alterar(T value);
  void remover(T value);
  Query listar();
}
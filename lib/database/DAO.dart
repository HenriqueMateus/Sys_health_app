import 'package:firebase_database/firebase_database.dart';

abstract class DAO<T> {
  late DatabaseReference __ref;
  void cadastrar(T value);
  Query listar();
}


import 'package:sys_health_app/models/Paciente.dart';

class Ala {

  final String nome;
  final String descricao;
  final int tamanho;
  late final  filas;
  Ala(this.nome, this.descricao, this.tamanho){
    this.filas = List<List<Paciente>>.generate(tamanho, (index) => List<Paciente>.empty());
  }

  Ala.fromJson(Map<String, dynamic> json):
        this.nome = json['nome'],
        this.descricao = json['descricao'],
        this.tamanho = json['tamanho'];

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'descricao': descricao

  };

}
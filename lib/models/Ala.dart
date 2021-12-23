

import 'package:sys_health_app/models/Paciente.dart';
import 'Medico.dart';

class Ala {

  final String nome;
  final String descricao;
  final int tamanhoMaximo;
  final int totalFilas;
  final int quantidadeMaximaMedicos;
  List<List<Paciente>> filas;
  List<Medico> medicos;
  var id;
  Ala(this.nome, this.descricao, this.tamanhoMaximo, this.totalFilas,
      this.quantidadeMaximaMedicos):
    this.filas = List.generate(totalFilas, (index) =>  new List.empty(growable: true)),
    this.medicos = [];


  Ala.id(this.id, this.nome, this.descricao, this.tamanhoMaximo, this.totalFilas,
      this.quantidadeMaximaMedicos,
      this.filas,
      this.medicos
      );

  Ala.fromJson(Map<String, dynamic> json):
        this.nome = json['nome'],
        this.descricao = json['descricao'],
        this.tamanhoMaximo = json['tamanhoMaximo'],
        this.totalFilas = json['totalFilas'],
        this.quantidadeMaximaMedicos =json['quantMedicos'],
        this.filas = json['filas'],
        this.medicos = json['medicos']
  ;

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'descricao': descricao,
    'tamanhoMaximo': tamanhoMaximo,
    'totalFilas': totalFilas,
    'quantMedicos': quantidadeMaximaMedicos,
    'filas': filas,
    'medicos': medicos

  };

}
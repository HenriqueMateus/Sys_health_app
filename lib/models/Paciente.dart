import 'Pessoa.dart';

class Paciente extends Pessoa {
  late final numPlano;
  late final ala;
  late final prioridade;
  var idPaciente = '';

  Paciente(String idplano, String ala, String prioridade
      , String nome, String sobrenome, String dataNasc,
      String endereco, String sexo, String cpf, String rg)
      : super(nome, sobrenome, dataNasc, endereco, sexo, cpf, rg) {
    this.numPlano = idplano;
    this.prioridade = prioridade;
    this.ala = ala;
  }
  Paciente.id(String idPaciente, String idplano, String ala, String prioridade
      , String nome, String sobrenome, String dataNasc,
      String endereco, String sexo, String cpf, String rg)
      : super(nome, sobrenome, dataNasc, endereco, sexo, cpf, rg) {
    this.numPlano = idplano;
    this.prioridade = prioridade;
    this.ala = ala;
    this.idPaciente = idPaciente;
  }



  Paciente.fromJson(Map<String, dynamic> json)
      : this.numPlano = json['numPlano'],
        this.ala = json['ala'],
        this.prioridade = json['prioridade'],
        super(
            json['nome'],
            json['sobrenome'],
            json['dataNasc'],
            json['endereco'],
            json['sexo'],
            json['cpf'],
            json['rg']
        );

  Map<String, dynamic> toJson() => {
        'numPlano': numPlano,
        'ala': ala,
        'prioridade': prioridade,
        'nome': nome,
        'sobrenome': sobrenome,
        'dataNasc': dataNasc,
        'endereco': endereco,
        'sexo': sexo,
        'cpf': cpf,
        'rg': rg,
      };
  Map<String, dynamic> toJsonId() => {
    'idPaciente': idPaciente,
    'numPlano': numPlano,
    'ala': ala,
    'prioridade': prioridade,
    'nome': nome,
    'sobrenome': sobrenome,
    'dataNasc': dataNasc,
    'endereco': endereco,
    'sexo': sexo,
    'cpf': cpf,
    'rg': rg,
  };
}

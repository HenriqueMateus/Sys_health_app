import 'package:sys_health_app/models/Pessoa.dart';
import 'package:sys_health_app/models/Usuario.dart';

class Medico extends Pessoa{
  late final crm;
  late final Usuario usuario;
  var idMedico = '';
  Medico(String crm, String nome, String sobrenome, String dataNasc,
      String endereco, String sexo, String cpf, String rg, Usuario usuario)
      : super(nome,sobrenome,dataNasc,endereco,sexo,cpf,rg){
        this.crm = crm;
        this.usuario = usuario;
  }
  Medico.id(String idMedico, String crm, String nome, String sobrenome, String dataNasc,
      String endereco, String sexo, String cpf, String rg, Usuario usuario)
      : super(nome,sobrenome,dataNasc,endereco,sexo,cpf,rg){
    this.crm = crm;
    this.usuario = usuario;
    this.idMedico = idMedico;
  }
  Medico.fromJson(Map<String, dynamic> json)
      : this.crm = json['crm'],
        this.usuario = new Usuario(json['usuario']['email'],
              json['usuario']['senha']),
        super(json['nome'], json['sobrenome'], json['dataNasc']
          , json['endereco'], json['sexo'], json['cpf'], json['rg'],
  );
  Medico.fromJsonId(Map<String, dynamic> json)
      : this.idMedico = json['id'],
        this.crm = json['crm'],
        this.usuario = json['usuario'],
        super(json['nome'], json['sobrenome'], json['dataNasc']
        , json['endereco'], json['sexo'], json['cpf'], json['rg'],
  );
  Map<String, dynamic> toJson() => {
    'nome': nome,
    'sobrenome': sobrenome,
    'dataNasc': dataNasc,
    'endereco': endereco,
    'sexo': sexo,
    'cpf': cpf,
    'rg': rg,
    'usuario': usuario.toJson(),
    'crm': crm,
  };
  Map<String, dynamic> toJsonId() => {
    'id': idMedico,
    'nome': nome,
    'sobrenome': sobrenome,
    'dataNasc': dataNasc,
    'endereco': endereco,
    'sexo': sexo,
    'cpf': cpf,
    'rg': rg,
    'usuario': usuario.toJson(),
    'crm': crm,
  };

}
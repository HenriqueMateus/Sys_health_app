class Usuario {
  var email;
  var senha;

  Usuario(this.email, this.senha);

  Usuario.foo();
  Usuario.fromJson(Map<String, dynamic> json):
        this.email = json['email'],
        this.senha = json['senha'];

  Map<String, dynamic> toJson() => {
    'email' : email,
    'senha' : senha
  };

}
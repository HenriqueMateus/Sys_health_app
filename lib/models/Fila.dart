import 'Paciente.dart';

class Fila {
  No? __inicio, __fim;
  int tamanho;
  String nome;

  Fila(this.nome) : this.tamanho = 0;

  void adicionarPaciente(Paciente paciente) {
    No pacienteNo = new No(paciente);
    if (tamanho == 0) {
      this.__inicio = this.__fim = pacienteNo;
    } else {
      __fim!.setProximo(pacienteNo);
      __fim = pacienteNo;
      tamanho += 1;
    }
  }

  Paciente? chamarProximo() {
    if (__inicio != null) {
      Paciente primeiro = __inicio!.getElemente();
      No? proximo = __inicio!.getProximo();
      if (proximo != null) {
        this.__inicio = proximo;
        return primeiro;
      } else {
        this.__inicio = this.__fim = null;
        return primeiro;
      }
    } else {
      print('Não Há pacientes na lista');
      return null;
    }
  }
}

class No {
  No? __proximo;
  Paciente __paciente;

  No(this.__paciente);

  void setProximo(No paciente) {
    this.__proximo = paciente;
  }

  No? getProximo() {
    return this.__proximo;
  }

  Paciente getElemente() {
    return this.__paciente;
  }
}

class Iterador {
  No? atual;
  Iterador(this.atual);

  Object current() {
    Paciente elemento = atual!.getElemente();
    atual = atual!.getProximo();

    return elemento;
  }

  bool moveNext() {
    if (atual != null) {
      return true;
    } else {
      return false;
    }
  }
}

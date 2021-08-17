import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModeloUsuario{
  String userId, nome, email, senha, conSenha, provincia, localidade, bairro;
  String quarteirao, nrCasa, telefone;
  String ddNascimento, bio;
  String cargo,tipoUsuario;
  String bi;
  String lastMessage;
  Timestamp timestamp;

  ClassModeloUsuario({
    this.userId, this.nome, this.email, this.senha, this.conSenha, this.provincia, this.localidade,
    this.bairro, this.quarteirao, this.nrCasa, this.ddNascimento, this.cargo, this.bi,
    this.telefone,this.bio ,this.timestamp,this.tipoUsuario,this.lastMessage
  });


toMap() {
  return {
    'userId': userId,
    'nome': nome,
    'email': email,
    'senha': senha,
    'conSenha': conSenha,
    'provincia': provincia,
    'localidade': localidade,
    'bairro': bairro,
    'quarteirao': quarteirao,
    'nrCasa': nrCasa,
    'ddNascimento': ddNascimento,
    'cargo': cargo,
    'bi': bi,
    'telefone': telefone,
    'bio':bio,
    'tipoUsuario': tipoUsuario,
    'lastMessage':lastMessage,
    'timestamp': FieldValue.serverTimestamp()
  };
  }

  factory ClassModeloUsuario.fromMap(Map map) {
    return ClassModeloUsuario(
      userId: map["userId"],
      nome: map["nome"],
      email: map["email"],
      senha: map["senha"],
      conSenha: map["conSenha"],
      provincia: map["provincia"],
      localidade: map["localidade"],
      bairro: map["bairro"],
      quarteirao: map["quarteirao"],
      nrCasa: map["nrCasa"],
      ddNascimento: map["ddNascimento"],
      cargo: map["cargo"],
      bi: map["bi"],
      telefone: map["telefone"],
      tipoUsuario: map["tipoUsuario"],
      bio: map['bio'],
      lastMessage: map['lastMessage'],
      timestamp: map["timestamp"],
    );
  }

}

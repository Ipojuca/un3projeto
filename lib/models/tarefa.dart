import 'dart:convert';

import 'usuario.dart';

//import 'usuario.dart';

Tarefa tarefaFromJson(String str) => Tarefa.fromJson(json.decode(str));

String tarefaToJson(Tarefa data) => json.encode(data.toJson());

class Tarefa {
  Tarefa.inc(
      {required this.id,
      required this.projetoId,
      required this.descricao,
      required this.usuarioId});
  Tarefa.cons(
      {required this.id,
      required this.projetoId,
      required this.descricao,
      required this.usuarioId,
      required this.usuario});

  int id;
  int projetoId;
  String descricao;
  int usuarioId;
  late Usuario usuario;

  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa.cons(
        id: json["id"],
        projetoId: json["projetoId"],
        descricao: json["descricao"],
        usuarioId: json["usuarioId"],
        usuario: Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projetoId": projetoId,
        "descricao": descricao,
        "usuarioId": usuarioId,
        //   "usuario": usuario.toJson(),
      };
}

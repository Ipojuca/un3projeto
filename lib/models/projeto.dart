import 'dart:convert';

import 'tarefa.dart';

Projeto projetoFromJson(String str) => Projeto.fromJson(json.decode(str));

String projetoToJson(Projeto data) => json.encode(data.toJson());

class Projeto {
  Projeto({
    required this.id,
    required this.titulo,
    required this.prazo,
    required this.descricao,
    required this.tarefas,
  });

  int id;
  String titulo;
  DateTime prazo;
  String descricao;
  List<Tarefa> tarefas;

  factory Projeto.fromJson(Map<String, dynamic> json) => Projeto(
      id: json["id"],
      titulo: json["titulo"],
      prazo: DateTime.parse(json["prazo"]),
      descricao: json["descricao"],
      tarefas: []
      // tarefas:
      //     List<Tarefa>.from(json["tarefas"].map((x) => Tarefa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "prazo": prazo.toIso8601String(),
        "descricao": descricao,
        "tarefas": List<dynamic>.from(tarefas.map((x) => x.toJson())),
      };
}

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario(
      {required this.id,
      required this.nome,
      required this.email,
      this.fotoUsuario});

  int id;
  String nome;
  String email;
  String? fotoUsuario;
  //Uint8List? fotoUsuario;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json["id"],
      nome: json["nome"],
      email: json["email"],
      fotoUsuario: json["imagem"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "email": email,
        "imagem": fotoUsuario,
      };
}

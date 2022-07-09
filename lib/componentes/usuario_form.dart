import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/usuariocontroller.dart';
import '../models/usuario.dart';
import 'image_input.dart';

class UsuarioForm extends StatelessWidget {
  UsuarioForm({Key? key}) : super(key: key);
  final _usuarioControllerNome = TextEditingController();
  final _usuarioControllerEmail = TextEditingController();
  String? _pickedImage;
  //Uint8List? _pickedImage;

  void _loadFormData(Usuario usuario) {
    if (usuario.id != 0) {
      _usuarioControllerNome.text = usuario.nome;
      _usuarioControllerEmail.text = usuario.email;
      _pickedImage = usuario.fotoUsuario;
    }
  }

  _selectImage(File? pickedImage) {
    _pickedImage = base64Encode(pickedImage!.readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    final Usuario usuario =
        ModalRoute.of(context)!.settings.arguments as Usuario;
    final title = usuario.id == 0 ? 'Cadastrar Usuário' : 'Alterar Usuário';

    _loadFormData(usuario);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                usuario.nome = _usuarioControllerNome.text;
                usuario.email = _usuarioControllerEmail.text;
                usuario.fotoUsuario = _pickedImage!;
                if (usuario.id == 0) {
                  Provider.of<UsuarioController>(context, listen: false)
                      .addUsuario(usuario);
                } else {
                  Provider.of<UsuarioController>(context, listen: false)
                      .updateUsuario(usuario);
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(children: <Widget>[
            Padding(
              //padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 15, right: 15, top: 20),
              child: TextField(
                controller: _usuarioControllerNome,
                decoration: const InputDecoration(
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.account_box,
                    ),
                  ),
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 15, right: 15, top: 8),
              child: TextField(
                controller: _usuarioControllerEmail,
                decoration: const InputDecoration(
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.email,
                    ),
                  ),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, left: 15, right: 15, top: 8),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ImageInput(_selectImage),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}

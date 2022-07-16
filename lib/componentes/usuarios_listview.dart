import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/usuariocontroller.dart';
import '../models/usuario.dart';
import '../utils/app_routes.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({Key? key}) : super(key: key);

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<UsuarioController>(context);
    //final _controller = context.watch<UsuarioController>();

    //_controller.start();

    return ListView.separated(
      padding: const EdgeInsets.all(15),
      itemCount: _controller.usuarios.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: _controller.usuarios[index].fotoUsuario != null
                    ? ClipOval(
                        child: SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: Image.memory(
                            base64Decode(
                                _controller.usuarios[index].fotoUsuario!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 30,
                      ),
              ),
              title: Text(_controller.usuarios[index].nome),
              subtitle: Text(_controller.usuarios[index].email),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Color.fromARGB(255, 39, 122, 185), width: 1),
                  borderRadius: BorderRadius.circular(5)),
              tileColor: const Color.fromARGB(255, 255, 255, 255),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          updateCliente(_controller.usuarios[index]);
                        },
                        icon: const Icon(Icons.edit),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: const Text('Excluir Usuário'),
                                    content: const Text(
                                        'Deseja realmente excluir o usuário?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            _controller.deleteUsuario(
                                                _controller.usuarios[index]);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Sim')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Não')),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.delete),
                        color: const Color.fromARGB(255, 183, 31, 20),
                      ),
                    ],
                  )),
              // onTap: () {
              //   setState(() {
              //     _usuario = globals.listaUsuariosGlobal[index];
              //   });
              // },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 10,
        );
      },
    );
  }

  void updateCliente(Usuario usuario) {
    Navigator.of(context).pushNamed(AppRoutes.USUARIO_FORM, arguments: usuario);
  }
}

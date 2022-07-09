import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:un3projeto/componentes/usuarios_listview.dart';
import 'package:un3projeto/controller/usuariocontroller.dart';
import '../models/usuario.dart';
import '../utils/app_routes.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key? key}) : super(key: key);

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  // final _usuarioControllerNome = TextEditingController();
  // final _usuarioControllerEmail = TextEditingController();

  //final _controller = UsuarioController();

  int count = 0;

  _success() {
    return const UsuarioListView();
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  _error() {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        //_controller.start();
      },
      child: const Text('Tentar Novamente'),
    ));
  }

  gerenciaEstado(UsuarioState state) {
    switch (state) {
      case UsuarioState.success:
        return _success();
      case UsuarioState.loading:
        return _loading();
      case UsuarioState.error:
        return _error();
      default:
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _controller = Provider.of<UsuarioController>(context, listen: false);
    _controller.start();
  }
  // void  initState() {
  //   super.initState();
  // _controller.start();

  // }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<UsuarioController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        actions: [
          IconButton(
              onPressed: () {
                novoUsuario();
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: AnimatedBuilder(
            animation: _controller.state,
            builder: (context, child) {
              return gerenciaEstado(_controller.state.value);
            },
          ))
        ],
      ),
    );
  }

  // salvarUsuario() {
  //   Usuario novoUsuario = Usuario(
  //       id: 0,
  //       nome: _usuarioControllerNome.text,
  //       email: _usuarioControllerEmail.text);
  //   Provider.of<UsuarioController>(context, listen: false)
  //       .addUsuario(novoUsuario);
  //   //Navigator.pop(context, novoUsuario);
  // }

  void novoUsuario() {
    final usuario = Usuario(id: 0, nome: "", email: "", fotoUsuario: "");
    //Usuario(id: 0, nome: "", email: "", fotoUsuario: Uint8List(0));
    Navigator.of(context).pushNamed(AppRoutes.USUARIO_FORM, arguments: usuario);
  }
}

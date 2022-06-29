import 'package:flutter/cupertino.dart';

import '../models/usuario.dart';
import '../repositories/usuario_repository.dart';

class UsuarioController with ChangeNotifier {
  List<Usuario> usuarios = [];
  final repository = UsuarioRepository();

  final state = ValueNotifier<UsuarioState>(UsuarioState.start);

  //UsuarioState state = UsuarioState.start;

  Future start() async {
    state.value = UsuarioState.loading;

    try {
      usuarios = await repository.getUsuarios();
      state.value = UsuarioState.success;
      notifyListeners();
    } on Exception {
      state.value = UsuarioState.error;
    }
  }

  Future addUsuario(Usuario usuario) async {
    Usuario newUser = await repository.addUsuario(usuario);
    usuarios.add(newUser);
    notifyListeners();
  }

  Future updateUsuario(Usuario usuario) async {
    Usuario newUser = await repository.updateUsuario(usuario);
    usuarios[usuarios.indexWhere((element) => element.id == usuario.id)] =
        newUser;
    notifyListeners();
  }

  Future deleteUsuario(Usuario usuario) async {
    await repository.deleteUsuario(usuario.id);
    usuarios.remove(usuario);
    notifyListeners();
  }
}

enum UsuarioState { start, loading, success, error }

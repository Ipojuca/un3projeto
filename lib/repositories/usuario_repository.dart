import 'package:dio/dio.dart';

import '../models/usuario.dart';
import '../utils/global.dart';

class UsuarioRepository {
  final dio = Dio();
  //final url = 'http://10.0.2.2:5025';
  //final url = 'http://localhost:5025';

  Future<List<Usuario>> getUsuarios() async {
    final response = await dio.get(url + '/Usuarios');
    final list = response.data as List;
    return list.map((json) => Usuario.fromJson(json)).toList();
  }

  Future<Usuario> addUsuario(Usuario usuario) async {
    final response =
        await dio.post(url + '/Usuario', data: usuarioToJson(usuario));
    return Usuario.fromJson(response.data);
  }

  Future<Usuario> updateUsuario(Usuario usuario) async {
    final response = await dio.put(url + '/Usuario/${usuario.id}',
        data: usuarioToJson(usuario));
    return Usuario.fromJson(response.data);
  }

  Future<void> deleteUsuario(int id) async {
    await dio.delete(url + '/Usuario/$id');
  }
}

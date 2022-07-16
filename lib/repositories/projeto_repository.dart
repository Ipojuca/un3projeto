import 'package:dio/dio.dart';

import '../models/projeto.dart';
import '../utils/global.dart';

class ProjetoRepository {
  final dio = Dio();

  //final url = 'http://10.0.2.2:5025';
  //final url = 'http://localhost:5025';

  Future<List<Projeto>> getProjetos() async {
    final response = await dio.get(url + '/Projetos');
    final list = response.data as List;
    return list.map((json) => Projeto.fromJson(json)).toList();
  }

  Future<Projeto> addProjeto(Projeto projeto) async {
    final response =
        await dio.post(url + '/Projeto', data: projetoToJson(projeto));
    return Projeto.fromJson(response.data);
  }

  Future<Projeto> updateProjeto(Projeto projeto) async {
    final response = await dio.put(url + '/Projeto/${projeto.id}',
        data: projetoToJson(projeto));
    return Projeto.fromJson(response.data);
  }

  Future<void> deleteProjeto(int id) async {
    await dio.delete(url + '/Projeto/$id');
  }
}

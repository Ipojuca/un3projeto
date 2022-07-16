import 'package:dio/dio.dart';

import '../models/tarefa.dart';
import '../utils/global.dart';

class TarefaRepository {
  final dio = Dio();
  //final url = 'http://10.0.2.2:5025';
  //final url = 'http://localhost:5025';

  Future<List<Tarefa>> getTarefas(int projetoId) async {
    final response = await dio.get(url + '/Tarefas/$projetoId');
    final list = response.data as List;
    return list.map((json) => Tarefa.fromJson(json)).toList();
  }

  Future<Tarefa> addTarefa(Tarefa tarefa) async {
    final response =
        await dio.post(url + '/Tarefa', data: tarefaToJson(tarefa));
    return Tarefa.fromJson(response.data);
  }

  Future<Tarefa> updateTarefa(Tarefa tarefa) async {
    final response =
        await dio.put(url + '/Tarefa/${tarefa.id}', data: tarefaToJson(tarefa));
    return Tarefa.fromJson(response.data);
  }

  Future<void> deleteTarefa(int id) async {
    await dio.delete(url + '/Tarefa/$id');
  }
}

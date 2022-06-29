import 'package:flutter/cupertino.dart';

import '../models/tarefa.dart';
import '../repositories/tarefa_repository.dart';

class TarefaController with ChangeNotifier {
  List<Tarefa> tarefas = [];
  final repository = TarefaRepository();

  final state = ValueNotifier<TarefaState>(TarefaState.start);

  //TarefaState state = TarefaState.start;

  Future start(int projetoId) async {
    state.value = TarefaState.loading;

    try {
      tarefas = await repository.getTarefas(projetoId);
      state.value = TarefaState.success;
      notifyListeners();
    } on Exception {
      state.value = TarefaState.error;
    }
    //return tarefas;
  }

  Future addTarefa(Tarefa tarefa) async {
    Tarefa newTarefa = await repository.addTarefa(tarefa);
    tarefas.add(newTarefa);
    notifyListeners();
  }

  Future updateTarefa(Tarefa tarefa) async {
    Tarefa newTarefa = await repository.updateTarefa(tarefa);
    tarefas[tarefas.indexWhere((element) => element.id == tarefa.id)] =
        newTarefa;
    notifyListeners();
  }

  Future deleteTarefa(Tarefa tarefa) async {
    await repository.deleteTarefa(tarefa.id);
    // ignore: list_remove_unrelated_type
    tarefas.remove(tarefa);
    notifyListeners();
  }
}

enum TarefaState { start, loading, success, error }

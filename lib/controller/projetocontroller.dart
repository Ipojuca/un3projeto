import 'package:flutter/material.dart';

import '../models/projeto.dart';
import '../repositories/projeto_repository.dart';

class ProjetoController with ChangeNotifier {
  List<Projeto> projetos = [];
  final repository = ProjetoRepository();

  final state = ValueNotifier<ProjetoState>(ProjetoState.start);

  //ProjetoState state = ProjetoState.start;

  Future start() async {
    state.value = ProjetoState.loading;

    try {
      projetos = await repository.getProjetos();
      state.value = ProjetoState.success;
      notifyListeners();
    } on Exception {
      state.value = ProjetoState.error;
    }
  }

  Future addProjeto(Projeto projeto) async {
    Projeto newProjeto = await repository.addProjeto(projeto);
    projetos.add(newProjeto);
    notifyListeners();
  }

  Future updateProjeto(Projeto projeto) async {
    Projeto newProjeto = await repository.updateProjeto(projeto);
    projetos[projetos.indexWhere((element) => element.id == projeto.id)] =
        newProjeto;
    notifyListeners();
  }

  Future deleteProjeto(Projeto projeto) async {
    await repository.deleteProjeto(projeto.id);
    // ignore: list_remove_unrelated_type
    projetos.remove(projeto);
    notifyListeners();
  }
}

enum ProjetoState { start, loading, success, error }

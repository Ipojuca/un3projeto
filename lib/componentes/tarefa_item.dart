import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/tarefacontroller.dart';
import '../models/tarefa.dart';

class TarefaItem extends StatelessWidget {
  final Tarefa tarefa;

  const TarefaItem(this.tarefa, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // cadastrarTarefa(Tarefa tarefa) async {
    //   var result = await Navigator.pushNamed(context, AppRoutes.TAREFA_CADASTRO,
    //       arguments: tarefa);
    // }

    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Tarefa: " + tarefa.descricao),
          subtitle: Text("Usuário: " + tarefa.usuario.nome),
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 39, 122, 185), width: 1),
              borderRadius: BorderRadius.circular(5)),
          //tileColor: const Color.fromARGB(255, 238, 229, 248),
          tileColor: const Color.fromARGB(255, 255, 255, 255),
          trailing: SizedBox(
              width: 100,
              child: Row(
                children: <Widget>[
                  // IconButton(
                  //   onPressed: () {
                  //     // updateTarefa(tarefa);
                  //   },
                  //   icon: const Icon(Icons.edit),
                  //   color: Colors.orange,
                  // ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Excluir Tarefa'),
                          content:
                              const Text('Deseja realmente excluir a tarefa?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Provider.of<TarefaController>(context,
                                          listen: false)
                                      .deleteTarefa(tarefa);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Sim')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Não')),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    //color: Colors.red,
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
  }
}

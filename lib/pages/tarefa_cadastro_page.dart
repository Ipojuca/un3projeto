import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:un3projeto/controller/tarefacontroller.dart';
import 'package:un3projeto/controller/usuariocontroller.dart';
import '../models/tarefa.dart';
import '../models/usuario.dart';
import '../models/projeto.dart';

class TarefaCadastroPage extends StatefulWidget {
  const TarefaCadastroPage({Key? key}) : super(key: key);

  //void Function(Projeto) onSubmit;
  //final Projeto projeto;
  @override
  //State<ProjetoCadastroScreen> createState() => _ProjetoCadastroScreenState();
  State<TarefaCadastroPage> createState() => _TarefaCadastroPageState();
}

class _TarefaCadastroPageState extends State<TarefaCadastroPage> {
  final _tarefaControllerDescricao = TextEditingController();

  Usuario _usuario = Usuario(id: 0, nome: '', email: '', fotoUsuario: "");
  //Usuario(id: 0, nome: '', email: '', fotoUsuario: Uint8List(0));
  _selecionarUsuario() {
    // setState(() {
    //   usuarioSelecionado = globals.listaUsuariosGlobal[3];
    // });
  }

  @override
  Widget build(BuildContext context) {
    final _usuarioController = Provider.of<UsuarioController>(context);
    if (_usuarioController.state.value != UsuarioState.success) {
      _usuarioController.start();
    }
    final projeto = ModalRoute.of(context)!.settings.arguments as Projeto;

    //final projeto = ModalRoute.of(context)!.settings.arguments as Projeto;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Tarefa'),
      ),
      body: Column(children: <Widget>[
        /*Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 238, 229, 248),
            child:*/
        Column(children: <Widget>[
          Padding(
            //padding: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(
                top: 20.0, left: 15, right: 15, bottom: 8),
            child: TextField(
              controller: _tarefaControllerDescricao,
              decoration: const InputDecoration(
                prefixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Icon(
                    Icons.text_snippet_outlined,
                  ),
                ),
                labelText: 'Descricao da tarefa',
                border: OutlineInputBorder(),
              ),
            ),
          )
        ]),
        //),
        /*const Divider(
          height: 20,
        ),*/
        /*TextField(
          controller: _tarefaControllerDescricao,
          decoration: InputDecoration(labelText: 'Descricao da tarefa'),
        ),*/

        Card(
            /*shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),*/
            elevation: 4,
            margin: const EdgeInsets.all(10),
            //color: Color.fromARGB(255, 115, 183, 242),
            color: Theme.of(context).colorScheme.primary,
            child: const Padding(
              //padding: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Selecione um usuario para a tarefa:',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),

        Expanded(
          child: SizedBox(
            height: 200.0,
            child: GestureDetector(
              onTap: () {
                //setar o usuario da lista a tarefa
                _selecionarUsuario;
              },
              child: ListView.builder(
                //itemCount: usuarioItem.length,
                //itemCount: DUMMY_USUARIOS.length,
                itemCount: _usuarioController.usuarios.length,
                itemBuilder: (ctx, index) {
                  //return UsuarioItem(usuarioItem[index]);
                  //return UsuarioItem(DUMMY_USUARIOS[index]);
                  //return UsuarioItem(globals.listaUsuariosGlobal[index]);
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child:
                              //Text('${_usuarioController.usuarios[index].id}'),
                              const ClipRRect(
                            //child: Image.asset('profile-generic.png'),
                            child: Icon(
                              Icons.account_circle,
                              size: 30,
                            ),
                          ),
                        ),
                        title: Text(_usuarioController.usuarios[index].nome),
                        subtitle:
                            Text(_usuarioController.usuarios[index].email),
                        onTap: () {
                          setState(() {
                            _usuario = _usuarioController.usuarios[index];
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        //pegar o usuario que foi clicado
        Text('Usuario selecionado: ' + _usuario.nome),

        SizedBox(
          width: 110,
          height: 45,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 10),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: () => salvarTarefa(projeto.id, _usuario),
                child: const Text('Salvar',
                    style: TextStyle(
                      fontSize: 16,
                    ))),
          ),
        )
      ]),
    );
  }

  salvarTarefa(int id, Usuario _usuario) {
    Tarefa novaTarefa = Tarefa.inc(
        id: 0,
        descricao: _tarefaControllerDescricao.text,
        usuarioId: _usuario.id,
        projetoId: id);
    Provider.of<TarefaController>(context, listen: false).addTarefa(novaTarefa);
    Navigator.pop(context, novaTarefa);
  }
}

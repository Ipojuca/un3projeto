import 'package:flutter/material.dart';
import 'package:un3projeto/models/projeto.dart';

import '../componentes/projetos_listview.dart';
import '../utils/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexSelectedScreen = 0;

  _selectScreen(int index) async {
    switch (index) {
      // case 0:
      //   ProjetosScreen();
      //   break;
      case 1:
        //   var result =
        final Projeto projeto = Projeto(
          id: 0,
          titulo: '',
          prazo: DateTime.now(),
          descricao: '',
          tarefas: [],
        );
        await Navigator.pushNamed(context, AppRoutes.PROJETO_CADASTRO,
            arguments: projeto);
        //   if (result != null) {
        //     _projetos.add(result as Projeto);
        //   }
        break;
      case 2:
//        var result =
        await Navigator.pushNamed(context, AppRoutes.USUARIO_PAGE);
        // if (result != null) {
        //   _usuarios.add(result as Usuario);
        // }
        break;
      default:
    }
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciador de Projetos')),
      body: const ProjetosListView(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _indexSelectedScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Projetos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.construction), label: 'Cadastrar Projeto'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), label: 'Usuários'),
        ],
      ),
    );
  }
}

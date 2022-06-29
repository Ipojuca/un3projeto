import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'componentes/usuario_form.dart';
import 'controller/projetocontroller.dart';
import 'controller/tarefacontroller.dart';
import 'controller/usuariocontroller.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/projeto_cadastro_page.dart';
import 'pages/projeto_detalhe_page.dart';
import 'pages/tarefa_cadastro_page.dart';
import 'pages/usuario_page.dart';
import 'utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioController()),
        ChangeNotifierProvider(create: (_) => ProjetoController()),
        ChangeNotifierProvider(create: (ctx) => TarefaController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gerenciador de Projetos',
        theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color.fromARGB(255, 39, 122, 185),
                secondary: const Color.fromARGB(255, 123, 243, 247)),
            fontFamily: 'Raleway',
            canvasColor: const Color.fromARGB(255, 255, 255, 255),
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                ))),
        initialRoute: '/',
        // home: const LoginPage(),
        routes: {
          AppRoutes.LOGIN: (ctx) => const LoginPage(),
          AppRoutes.HOME: (ctx) => const HomePage(),
          AppRoutes.USUARIO_PAGE: (ctx) => const UsuarioPage(),
          AppRoutes.USUARIO_FORM: (ctx) => UsuarioForm(),
          AppRoutes.PROJETO_CADASTRO: (ctx) => const ProjetoCadastroPage(),
          AppRoutes.PROJETO_DETALHE: (ctx) => const ProjetoDetalhePage(),
          AppRoutes.TAREFA_CADASTRO: (ctx) => const TarefaCadastroPage(),
        },
      ),
    );
  }
}

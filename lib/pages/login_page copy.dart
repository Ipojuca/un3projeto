import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:un3projeto/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userControllerEmail = TextEditingController();
  final _userControllerPassword = TextEditingController();
  bool isAuthenticating = false;
  final localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 60, 210, 223)
              ],
              //begin: const FractionalOffset(0.0, 0.0),
              //end: const FractionalOffset(1.0, 0.0),
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/icone1.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _userControllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  controller: _userControllerPassword,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        Icons.key,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            /*const Divider(
              height: 20,
            ),*/
            LoginButton(
                userControllerEmail: _userControllerEmail,
                userControllerPassword: _userControllerPassword),
            BioButton(),
          ],
        ),
      ),
    );
  }
}

class BioButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ))),
        onPressed: () {
          if (true) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  padding: EdgeInsets.all(8.0),
                  content: Text('Usuário ou senha invalido!')),
            );
          }
        },
        child: const Text(
          'Autenticação Biométrica',
        ));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required TextEditingController userControllerEmail,
    required TextEditingController userControllerPassword,
  })  : _userControllerEmail = userControllerEmail,
        _userControllerPassword = userControllerPassword,
        super(key: key);

  final TextEditingController _userControllerEmail;
  final TextEditingController _userControllerPassword;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ))),
        onPressed: () {
          if ( //_userControllerEmail.text == 'ipojuca@email.com.br' &&
              _userControllerPassword.text == '123') {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  padding: EdgeInsets.all(8.0),
                  content: Text('Usuário ou senha invalido!')),
            );
          }
        },
        child: const Text(
          'Entrar no App',
        ));
  }
}

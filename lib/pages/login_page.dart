import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:un3projeto/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/encrypted_shared_preferences.dart';
import '../helper/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _userControllerEmail = TextEditingController();
  // final _userControllerPassword = TextEditingController();
  bool isAuthenticating = false;
  LocalAuthentication localAuth = LocalAuthentication();

  final Map<String, String> userPreferences = {'name': 'ipojuca', 'age': '22'};

  @override
  void initState() {
    super.initState();
    authenticateWithBiometric();
  }

  checkHasRegisteredPreferences() async {
    final preference = await getEncryptedPreferences('userPreferences');
    return preference != null && preference.isNotEmpty;
  }

  authenticateWithBiometric() async {
    final canCheckBiometric = await checkCanUserBiometric();
    final isDeviceSuported = await checkIsDeviceSupportedBiometric();
    final hasRegisteredPreferences = await checkHasRegisteredPreferences();

    if (canCheckBiometric && isDeviceSuported && hasRegisteredPreferences) {
      await availableBiometrics();
      await authenticateUserWithBiometric();
    }
  }

  Future<bool> checkCanUserBiometric() async {
    try {
      return await localAuth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkIsDeviceSupportedBiometric() async {
    try {
      return await true; //localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> availableBiometrics() async {
    final availableBiometrics = await localAuth.getAvailableBiometrics();
    return availableBiometrics;
  }

  authenticateUserWithBiometric() async {
    try {
      final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Autenticação com biometria',
        //useErrorDialogs: true,
        //stickyAuth: true,
      );

      if (isAuthenticated) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);

        setPreferences();
        await SharedPreferencesHelper.setSharedPrefences();
      }
    } catch (e) {}
  }

  setPreferences() async {
    final userPreferences = json.encode(this.userPreferences);
    EncryptedSharedPreferencesHelper.savePreferences(
        key: 'userPreferences', value: userPreferences);
  }

  Future<String?> getEncryptedPreferences(String key) async {
    return await EncryptedSharedPreferencesHelper.getPreferences(key: key);
  }

  get() async {
    await SharedPreferencesHelper.getSharedPreferences();
  }

  clearAll() async {
    try {
      await EncryptedSharedPreferencesHelper.clearEncrpt();
      await SharedPreferencesHelper.clear();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final _userControllerEmail = TextEditingController();
    final _userControllerPassword = TextEditingController();

    auth() async {
      final isNotAuthenticated =
          //_userControllerEmail.text != 'email.teste@gmail.com' ||
          _userControllerPassword.text != '123';

      if (isNotAuthenticated) {
        const snackBar = SnackBar(
          content: Text('Usuário ou senha invalido!'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      setPreferences();
      await SharedPreferencesHelper.setSharedPrefences();

      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }

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
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: auth,
                child: const Text(
                  'Entrar no App',
                )),
            // LoginButton(
            //     userControllerEmail: _userControllerEmail,
            //     userControllerPassword: _userControllerPassword),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: authenticateWithBiometric,
                child: const Text(
                  'Autenticação Biométrica',
                )),
          ],
        ),
      ),
    );
  }
}

// class LoginButton extends StatelessWidget {
//   const LoginButton({
//     Key? key,
//     required TextEditingController userControllerEmail,
//     required TextEditingController userControllerPassword,
//   })  : _userControllerEmail = userControllerEmail,
//         _userControllerPassword = userControllerPassword,
//         super(key: key);

//   final TextEditingController _userControllerEmail;
//   final TextEditingController _userControllerPassword;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         style: ButtonStyle(
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(18.0),
//         ))),
//         onPressed: () {
//           if ( //_userControllerEmail.text == 'ipojuca@email.com.br' &&
//               _userControllerPassword.text == '123') {
//             Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                   padding: EdgeInsets.all(8.0),
//                   content: Text('Usuário ou senha invalido!')),
//             );
//           }
//         },
//         child: const Text(
//           'Entrar no App',
//         ));
//   }
// }

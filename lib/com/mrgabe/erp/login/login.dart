import 'package:flutter/material.dart';
import 'dart:async';

import '../database/database.dart';
import '../home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  void _login(BuildContext context) {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String company = _companyController.text;

    // Crear un Completer para manejar el resultado
    Completer<bool> completer = Completer<bool>();

    // Verificar si los datos coinciden con la base de datos
    DatabaseHelper.checkUser(company, username).then((bool userExists) {
      if (userExists) {
        DatabaseHelper.checkPassword(company, username, password).then((bool passwordCorrect) {
          if (passwordCorrect) {
            completer.complete(true);
          } else {
            completer.complete(false);
          }
        });
      } else {
        completer.complete(false);
      }
    });

    completer.future.then((bool loggedIn) {
      if (loggedIn) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InventoryPage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Inicio de sesión fallido'),
              content: const Text('Usuario o contraseña incorrectos. Por favor, inténtalo nuevamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _companyController,
                    decoration: const InputDecoration(labelText: 'Empresa o Dominio'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _login(context),
                    child: const Text('Iniciar sesión'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text('¿No tienes una cuenta? Regístrate aquí'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  void registerUser(BuildContext context) {
    // Obtén los valores ingresados en los campos de texto
    String company = _companyController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    Completer<bool> completer = Completer<bool>();

    DatabaseHelper.checkUser(company, username).then((bool userExists) {
      if (userExists) {
        completer.complete(false);
      } else {
        completer.complete(true);
      }
    });

    completer.future.then((bool loggedIn) {
      if(loggedIn) {
        DatabaseHelper.registerUser(username, password, company);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registro exitoso'),
              content: const Text('Usuario registrado correctamente.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InventoryPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else  {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Ya existe un usuario con ese nombre.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Nombre de usuario'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _companyController,
              decoration: const InputDecoration(labelText: 'Empresa o Dominio'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => registerUser(context),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  var _isLoginMode = true;
  var _email = '';
  var _password = '';
  var _username = '';

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_isLoginMode) {
      // Aqui você pode implementar a lógica de autenticação
      print('Autenticando com Email: $_email, Senha: $_password');
    } else {
      // Aqui você pode implementar a lógica para criar um novo usuário
      print('Criando usuário com Email: $_email, Senha: $_password, Nome de Usuário: $_username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey, // Cor de fundo personalizada
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  width: 200,
                  child: const Icon(Icons.lock, size: 200, color: Colors.white),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Endereço de Email'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty || !value.contains('@')) {
                                return 'Por favor, insira um endereço de email válido.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                          if (!_isLoginMode)
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Nome de Usuário'),
                              validator: (value) {
                                if (value == null || value.isEmpty || value.trim().length < 4) {
                                  return 'Por favor, insira pelo menos 4 caracteres.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _username = value!;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Senha'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'A senha deve ter pelo menos 6 caracteres.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: Text(_isLoginMode ? 'Entrar' : 'Cadastrar'),
                          ),
                          const SizedBox(height: 6),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoginMode = !_isLoginMode;
                              });
                            },
                            child: Text(_isLoginMode ? 'Criar uma conta' : 'Já tenho uma conta'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:frontend/src/adapters/api.dart';

import '../../domain/services/auth_validation_services.dart';
import 'components/customTextField.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthService authService = AuthService();
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(authService: authService, auth: auth),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final AuthService authService;
  final Auth auth;

  const LoginForm({super.key, required this.authService, required this.auth});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          widget.authService.isValidEmail(_emailController.text) &&
          _passwordController.text.isNotEmpty &&
          _passwordController.text.length >= 7;
    });
  }

  Future<void> _login() async {
    await widget.auth.getToken(
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            key: const ValueKey('emailField'),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty || !widget.authService.isValidEmail(value)) {
                return 'Email inválido';
              }
              return null;
            },
            icon: Icons.email,
            label: 'email',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            key: const ValueKey('passwordField'),
            controller: _passwordController,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return "Digite sua senha!";
              }
              if (password.length < 7) {
                return "A senha precisa de pelo menos 7 caracteres.";
              }
              return null;
            },
            icon: Icons.lock,
            label: 'password',
            isSecret: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();

              if (_formKey.currentState!.validate()) {
                if(_isButtonEnabled){
                  await _login();
                }
              } else {
                print("Campos não válidos");
              }
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}

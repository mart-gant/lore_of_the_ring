import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  String? _errorMessage;

  Future<void> _submit() async {
    setState(() => _errorMessage = null);

    final authVM = context.read<AuthViewModel>();
    String? result;
    if (_isLogin) {
      result = await authVM.login(_emailController.text, _passwordController.text);
    } else {
      result = await authVM.register(_emailController.text, _passwordController.text);
    }

    if (!mounted) return;

    if (result != null) {
      setState(() => _errorMessage = result);
    } else {
      Navigator.pushReplacementNamed(context, '/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Logowanie' : 'Rejestracja')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Hasło')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submit, child: Text(_isLogin ? 'Zaloguj się' : 'Zarejestruj się')),
            TextButton(
              onPressed: () => setState(() => _isLogin = !_isLogin),
              child: Text(_isLogin ? 'Nie masz konta? Zarejestruj się' : 'Masz już konto? Zaloguj się'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}

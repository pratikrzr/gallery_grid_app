import 'package:flutter/material.dart';
import 'package:grid_app/gridpage.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorText = '';

  void _submitForm() {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      // DUMMY print the values of _email and _password.
      print('Email: $_email');
      print('Password: $_password');

      Navigator.of(context).pushReplacement(GridPageRoute());
    } else {
      setState(() {
        _errorText = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Login Page'),
        elevation: 0,
        backgroundColor: Colors.white,
        /////////////////////
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value?.isEmpty == true ||
                            (value != null && !value.contains('@'))) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value ?? '';
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty == true ||
                            (value != null && value.length < 6)) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value ?? '';
                      },
                    ),
                    if (_errorText.isNotEmpty)
                      Text(
                        _errorText,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  String email = '', password = '', firstName = '', lastName = '', role = 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'First Name'), onChanged: (val) => firstName = val),
              TextFormField(decoration: const InputDecoration(labelText: 'Last Name'), onChanged: (val) => lastName = val),
              TextFormField(decoration: const InputDecoration(labelText: 'Email'), onChanged: (val) => email = val),
              TextFormField(obscureText: true, decoration: const InputDecoration(labelText: 'Password'), onChanged: (val) => password = val),
              const SizedBox(height: 12),
              ElevatedButton(
                child: const Text("Register"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await _authService.registerWithEmail(email, password);
                    if (user != null) {
                      await _firestoreService.addUser(user.uid, firstName, lastName, role);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

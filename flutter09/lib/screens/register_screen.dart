import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();

  void _register() {
    if (_nameController.text.isNotEmpty &&
      _specialtyController.text.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Técnico registado com sucesso!')),
    );

    Navigator.pop(context);
  } else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Preencha os campos obrigatorios.') ),
   );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Técnico')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Crie seu perfil.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                prefixIcon: Icon(Icons.badge),
              ), 
            ), 
            const SizedBox(height: 16),
            TextField(
              controller: _specialtyController,
              decoration: const InputDecoration(
                labelText: 'Especialidade (Ex: Redes, Hardware)',
                prefixIcon: Icon(Icons.handyman),
              ), 
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Concluir Cadastro',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _nameController.dispose();
    _specialtyController.dispose();
    super.dispose();
  }
}


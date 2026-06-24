import 'package:flutter/material.dart';
import 'package:flutter08/database/Database.dart';
import 'package:flutter08/model/client.dart';
import 'package:flutter08/screens/client_modal.dart';
import 'package:flutter08/screens/home_screen.dart';
import 'package:flutter08/screens/login_screen.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final Database _db = Database();

  List<Client> _clients = [];

  @override
  void initState() {
    super.initState();
    _clients = _db.getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'TechService',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Painel de Atividades'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen())

                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Painel de Clientes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Painel de Clientes'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair do app',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clientes Cadastrados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),

            const SizedBox(height: 8),

            const Text('Gerencie os clientes da TechService.'),

            const SizedBox(height: 16),

            Expanded(
              child: _clients.isEmpty
                  ? const Center(child: Text('Nenhum cliente cadastrado.'))
                  : ListView.builder(
                      itemCount: _clients.length,
                      itemBuilder: (context, index) {
                        final client = _clients[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),

                            leading: const CircleAvatar(
                              radius: 28,
                              child: Icon(Icons.person, size: 30),
                            ),

                            title: Text(
                              '${client.id} - ${client.nome}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.phone, size: 16),
                                      const SizedBox(width: 6),
                                      Text(client.telefone),
                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  Row(
                                    children: [
                                      const Icon(Icons.email, size: 16),
                                      const SizedBox(width: 6),
                                      Expanded(child: Text(client.email)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            trailing: IconButton(
                              icon: Icon(
                                client.favorito
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: client.favorito
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  client.favorito = !client.favorito;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final Client? novoCliente = await showModalBottomSheet<Client>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const ClientModal(),
          );

          if (novoCliente != null) {
            setState(() {
              _db.addClient(novoCliente);
              _clients = _db.getClients();
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
            );
          }
        },
      ),
    );
  }
}

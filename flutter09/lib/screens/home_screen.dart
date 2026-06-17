import 'package:flutter/material.dart';
import 'package:flutter08/database/Database.dart';
import 'package:flutter08/model/ServiceOrder.dart';
import 'package:flutter08/screens/Cadastro_order_modal.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Database _db = Database();

  List<ServiceOrder> _serviceOrders = [];

  @override
  void initState() {
    super.initState();
    _serviceOrders = _db.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechService Home'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Painel de Atividades',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ), // TextStyle
            ), // Text
            const SizedBox(height: 8),
            const Text('Ola, Técnico. Veja os seus chamados para hoje:'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _serviceOrders.length,
                itemBuilder: (context, index) {
                  final os = _serviceOrders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        os.status == 'Concluida'
                            ? Icons.check_circle
                            : os.status == 'Em Andamento'
                            ? Icons.pending
                            : Icons.error_outline,
                        color: os.status == "Concluída"
                            ? Colors.green
                            : os.status == 'Em Andamento'
                            ? Colors.orange
                            : Colors.red,
                      ),
                      title: Text(
                        '${os.id} - ${os.client}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      subtitle: Text(os.desc),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ), // EdgeInsets.symmetric
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ), // BoxDecoration
                        child: Text(
                          os.status,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
        onPressed: () async {
          final ServiceOrder? novaOS = await showModalBottomSheet<ServiceOrder>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const CadastroOrderModal(),
          );

          if (novaOS != null) {
            print("Nova OS recebida: ${novaOS.client}");

            setState(() {
              _db.addOrder(novaOS);

              _serviceOrders = _db.getOrders();
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ordem de serviço salva com sucesso'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

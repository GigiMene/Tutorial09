import 'package:flutter08/model/ServiceOrder.dart';
import 'package:flutter08/model/client.dart';

class Database {
  static final Database _instance = Database._internal();

  Database._internal();

  factory Database() => _instance;

  final List<ServiceOrder> serviceOrderMock = [
    ServiceOrder(
      id: 'OS-2026-001',
      client: 'Lab de Informática 3',
      status: 'Em Andamento',
      desc: 'Manutenção preventiva dos computadores',
    ),
    ServiceOrder(
      id: 'OS-2026-002',
      client: 'Secretaria Executiva',
      status: 'Aberta',
      desc: 'Configuração de nova sub-rede local',
    ),
    ServiceOrder(
      id: 'OS-2026-003',
      client: 'Bloco Técnico B',
      status: 'Concluída',
      desc: 'Troca de switch e testes de patch panel',
    ),
  ];

  List<ServiceOrder> getOrders() {
    return serviceOrderMock;
  }

  void addOrder(ServiceOrder order) {
    serviceOrderMock.add(order);
  }

  final List<Client> clientMock = [
  Client(
    id: '1',
    nome: 'Lucas Silva',
    telefone: '(11) 98765-4321',
    email: 'lucas.silva@example.com',
  ),
  Client(
    id: '2',
    nome: 'Beatriz Santos',
    telefone: '(21) 97654-3210',
    email: 'beatriz.santos@example.com',
  ),
  Client(
    id: '3',
    nome: 'Carlos Oliveira',
    telefone: '(31) 96543-2109',
    email: 'carlos.oliveira@example.com',
  ),
  Client(
    id: '4',
    nome: 'Mariana Costa',
    telefone: '(41) 95432-1098',
    email: 'mariana.costa@example.com',
  ),
  Client(
    id: '5',
    nome: 'Gabriel Rodrigues',
    telefone: '(51) 94321-0987',
    email: 'gabriel.rodrigues@example.com',
  ),
];

List<Client> getClients() {
  return clientMock;
}

void addClient(Client client) {
  clientMock.add(client);
}
}


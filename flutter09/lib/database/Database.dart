import 'package:flutter08/model/ServiceOrder.dart';

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
}

import 'package:flutter/material.dart';

import '../inventory/inventory.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventario App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Inventarios'),
              Tab(text: 'Ajustes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InventoryPage(),
            Text('Ajustes Page'),
          ],
        ),
      ),
    );
  }
}

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _searchController = TextEditingController();

  late String _selectedStore;
  late String _selectedWarehouse;
  late String _selectedInventoryType;

  final List<String> _stores = ['Tienda 1', 'Tienda 2', 'Tienda 3'];
  final List<String> _warehouses = ['Almacén 1', 'Almacén 2', 'Almacén 3'];
  final List<String> _inventoryTypes = ['Tipo 1', 'Tipo 2', 'Tipo 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de inventarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Aquí puedes implementar la lógica para realizar la búsqueda
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Buscar inventario'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedStore,
              onChanged: (value) {
                setState(() {
                  _selectedStore = value!;
                });
              },
              items: _stores.map((store) {
                return DropdownMenuItem(
                  value: store,
                  child: Text(store),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Tienda'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedWarehouse,
              onChanged: (value) {
                setState(() {
                  _selectedWarehouse = value!;
                });
              },
              items: _warehouses.map((warehouse) {
                return DropdownMenuItem(
                  value: warehouse,
                  child: Text(warehouse),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Almacén'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedInventoryType,
              onChanged: (value) {
                setState(() {
                  _selectedInventoryType = value!;
                });
              },
              items: _inventoryTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Tipo de inventario'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewInventoryPage()),
                );
              },
              child: const Text('Añadir nuevo inventario'),
            ),
          ],
        ),
      ),
    );
  }
}
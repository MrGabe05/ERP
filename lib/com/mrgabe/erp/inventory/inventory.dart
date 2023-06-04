import 'package:flutter/material.dart';

class NewInventoryPage extends StatefulWidget {
  const NewInventoryPage({super.key});

  @override
  _NewInventoryPageState createState() => _NewInventoryPageState();
}

class _NewInventoryPageState extends State<NewInventoryPage> {
  final TextEditingController _descriptionController = TextEditingController();
  late String _selectedStore;
  late String _selectedWarehouse;
  late String _selectedInventoryType;
  late DateTime _selectedDate;

  final List<String> _stores = ['Tienda 1', 'Tienda 2', 'Tienda 3'];
  final List<String> _warehouses = ['Almacén 1', 'Almacén 2', 'Almacén 3'];
  final List<String> _inventoryTypes = ['Tipo 1', 'Tipo 2', 'Tipo 3'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Inventario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
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
            Row(
              children: [
                Expanded(
                  child: Text('Fecha seleccionada: ${_selectedDate.toString().substring(0, 10)}',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: const Text('Seleccionar fecha'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
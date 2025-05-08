import 'package:flutter/material.dart';
import '../../../core/data/data_provider.dart';
import '../models/warehouse.dart';

class WarehouseProvider extends ChangeNotifier {
  final DataProvider dataProvider;
  List<Warehouse> _warehouses = [];
  bool _isLoading = false;

  WarehouseProvider(this.dataProvider) {
    loadWarehouses();
  }

  List<Warehouse> get warehouses => _warehouses;
  bool get isLoading => _isLoading;

  Future<void> loadWarehouses() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement API call to fetch warehouses
      // For now, using dummy data
      _warehouses = [
        Warehouse(id: '1', name: 'Main Warehouse', location: 'New York'),
        Warehouse(id: '2', name: 'Secondary Warehouse', location: 'Los Angeles'),
      ];
    } catch (e) {
      print('Error loading warehouses: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addWarehouse({required String name, required String location}) async {
    try {
      // TODO: Implement API call to add warehouse
      final newWarehouse = Warehouse(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        location: location,
      );
      _warehouses.add(newWarehouse);
      notifyListeners();
    } catch (e) {
      print('Error adding warehouse: $e');
    }
  }

  Future<void> editWarehouse(Warehouse warehouse) async {
    try {
      // TODO: Implement API call to edit warehouse
      final index = _warehouses.indexWhere((w) => w.id == warehouse.id);
      if (index != -1) {
        _warehouses[index] = warehouse;
        notifyListeners();
      }
    } catch (e) {
      print('Error editing warehouse: $e');
    }
  }

  Future<void> deleteWarehouse(String id) async {
    try {
      // TODO: Implement API call to delete warehouse
      _warehouses.removeWhere((w) => w.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting warehouse: $e');
    }
  }
} 
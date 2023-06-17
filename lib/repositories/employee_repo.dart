import 'package:employee_tracker/models/employee_model.dart';

import '../services/services.dart';

class EmployeeRepo {
  EmployeeRepo({required HiveService<EmployeeModel> hiveService})
      : _hiveService = hiveService;

  final HiveService<EmployeeModel> _hiveService;

  Stream<List<EmployeeModel>> getAllEmployeesAsStream() {
    return _hiveService.getAsStream();
  }

  Future<void> addEmployee(EmployeeModel model) async {
    await _hiveService.add(model);
  }

  Future<void> editEmployee(
    EmployeeModel keyModel,
    EmployeeModel newModel,
  ) async {
    await _hiveService.edit(keyModel, newModel);
  }

  Future<void> deleteEmployee(EmployeeModel model) async {
    await _hiveService.delete(model);
  }
}

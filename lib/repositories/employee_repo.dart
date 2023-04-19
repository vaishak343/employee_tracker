import 'package:realtime_inov/models/employee_model.dart';

import '../services/services.dart';

class EmployeeRepo {
  EmployeeRepo({required HiveService<EmployeeModel> hiveService})
      : _hiveService = hiveService;

  final HiveService<EmployeeModel> _hiveService;

  Stream<List<EmployeeModel>> getAllEmployeesAsStream() {
    return _hiveService.getAsStream();
  }

  Future<void> addEmployee(EmployeeModel model) async {
    await _hiveService.add(
        model, model.empName.toLowerCase().trim().split(' ').join());
  }

  Future<void> editEmployee(
      EmployeeModel keyModel, EmployeeModel newModel) async {
    await _hiveService.edit(keyModel, newModel);
  }

  Future<void> deleteEmployee(EmployeeModel model) async {
    var values = _hiveService.getAll();
    var key = values!
        .where((element) {
          return element.empName.toLowerCase().trim().split(' ').join() ==
              model.empName.toLowerCase().trim().split(' ').join();
        })
        .first
        .empName
        .toLowerCase()
        .trim()
        .split(' ')
        .join();
    await _hiveService.delete(model, key);
  }
}

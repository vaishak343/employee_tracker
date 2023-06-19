import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc({
    required EmployeeRepo employeeRepo,
  })  : _employeeRepo = employeeRepo,
        super(
          const EmployeeListState(
            status: EmployeeListStatus.initial,
            employees: [],
            prevEmployees: [],
            currEmployees: [],
          ),
        ) {
    on<LoadEmployeesEvent>(loadEmployees);
    on<AddEmployeeEvent>(addEmployee);
    on<EditEmployeeEvent>(editEmployee);
    on<DeleteEmployeeEvent>(deleteEmployee);
    on<UndoDeleteEmployeeEvent>(undoDeleteEmployee);
  }

  final EmployeeRepo _employeeRepo;

  Future<void> loadEmployees(
    LoadEmployeesEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    emit(state.copyWith(status: EmployeeListStatus.loading));
    await emit.forEach<List<EmployeeModel>>(
      _employeeRepo.getAllEmployeesAsStream(),
      onData: (employees) => state.copyWith(
        status: EmployeeListStatus.success,
        employees: employees,
        prevEmployees:
            employees.where((element) => element.toDate != null).toList(),
        currEmployees:
            employees.where((element) => element.toDate == null).toList(),
      ),
      onError: (_, __) => state.copyWith(
        status: EmployeeListStatus.failure,
      ),
    );
  }

  Future<void> addEmployee(
    AddEmployeeEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    final newEmp = event.emp;
    await _employeeRepo.addEmployee(newEmp);
  }

  Future<void> editEmployee(
    EditEmployeeEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    await _employeeRepo.editEmployee( event.editedEmp);
  }

  Future<void> deleteEmployee(
    DeleteEmployeeEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    final newEmp = event.emp;
    emit(state.copyWith(lastDeletedEmployee: event.emp));
    await _employeeRepo.deleteEmployee(newEmp);
  }

  Future<void> undoDeleteEmployee(
    UndoDeleteEmployeeEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    if (state.lastDeletedEmployee != null) {
      var lastEmp = state.lastDeletedEmployee!;
      emit(state.copyWith(lastDeletedEmployee: null));
      await _employeeRepo.addEmployee(lastEmp);
    }
  }
}

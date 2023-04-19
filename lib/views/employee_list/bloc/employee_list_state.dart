part of 'employee_list_bloc.dart';

enum EmployeeListStatus { initial, loading, success, failure }

class EmployeeListState extends Equatable {
  const EmployeeListState({
    required this.status,
    required this.employees,
    required this.prevEmployees,
    required this.currEmployees,
    this.lastDeletedEmployee,
  });

  final EmployeeListStatus status;
  final List<EmployeeModel> employees;
  final List<EmployeeModel> prevEmployees;
  final List<EmployeeModel> currEmployees;
  final EmployeeModel? lastDeletedEmployee;

  EmployeeListState copyWith({
    EmployeeListStatus? status,
    List<EmployeeModel>? employees,
    List<EmployeeModel>? prevEmployees,
    List<EmployeeModel>? currEmployees,
    EmployeeModel? lastDeletedEmployee,
  }) {
    return EmployeeListState(
        status: status ?? this.status,
        employees: employees ?? this.employees,
        prevEmployees: prevEmployees ?? this.prevEmployees,
        currEmployees: currEmployees ?? this.currEmployees,
        lastDeletedEmployee: lastDeletedEmployee ?? this.lastDeletedEmployee);
  }

  @override
  List<Object?> get props => [
        status,
        employees,
        prevEmployees,
        currEmployees,
        lastDeletedEmployee,
      ];
}

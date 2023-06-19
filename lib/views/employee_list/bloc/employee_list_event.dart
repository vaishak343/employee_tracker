part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployeesEvent extends EmployeeListEvent {}

class AddEmployeeEvent extends EmployeeListEvent {
  const AddEmployeeEvent({
    required this.emp,
  });

  final EmployeeModel emp;

  @override
  List<Object> get props => [emp];
}

class DeleteEmployeeEvent extends EmployeeListEvent {
  const DeleteEmployeeEvent({
    required this.emp,
  });

  final EmployeeModel emp;

  @override
  List<Object> get props => [emp];
}

class UndoDeleteEmployeeEvent extends EmployeeListEvent {}

class EditEmployeeEvent extends EmployeeListEvent {
  const EditEmployeeEvent({
    // required this.oldEmp,
    required this.editedEmp,
  });

  // final EmployeeModel oldEmp;
  final EmployeeModel editedEmp;

  @override
  List<Object> get props => [editedEmp];
}

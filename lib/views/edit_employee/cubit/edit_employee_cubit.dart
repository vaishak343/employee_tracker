import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_employee_state.dart';

class EditEmployeeCubit extends Cubit<EditEmployeeState> {
  EditEmployeeCubit() : super(EditEmployeeInitial());
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:employee_tracker/utils/utils.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../employee_list/employee_list.dart';

part 'employee_details_widget.dart';

class EmployeeDetailsView extends StatelessWidget {
  const EmployeeDetailsView({this.model, super.key});

  final EmployeeModel? model;

  @override
  Widget build(BuildContext context) {
    return EmployeeDetailsWidget(
      formType: model == null ? EmployeeFormType.add : EmployeeFormType.edit,
      pageTitle: model == null
          ? Constants.addEmpDtlsPageTitle
          : Constants.editEmpDtlsPageTitle,
      employeeModel: model,
      onCancel: () {
        context.pop();
      },
      onSave: (emp) async {
        var tempEmp = emp.copyWith(empName: emp.empName.toName);
        if (model == null) {
          context.read<EmployeeListBloc>().add(AddEmployeeEvent(emp: tempEmp));
        } else {
          context.read<EmployeeListBloc>().add(EditEmployeeEvent(
                // oldEmp: model!,
                editedEmp: tempEmp,
              ));
        }

        context.pop();
      },
    );
  }
}

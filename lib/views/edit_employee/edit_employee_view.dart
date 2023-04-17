import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class EditEmployeeView extends StatelessWidget {
  const EditEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmployeeDetailsWidget(
      formType: EmployeeFormType.edit,
      pageTitle: Constants.editEmpDtlsPageTitle,
    );
  }
}

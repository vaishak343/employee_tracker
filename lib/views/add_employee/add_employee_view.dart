import 'package:flutter/material.dart';
import 'package:realtime_inov/utils/utils.dart';

import '../../widgets/widgets.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmployeeDetailsWidget(
      formType: EmployeeFormType.add,
      pageTitle: Constants.addEmpDtlsPageTitle,
    );
  }
}

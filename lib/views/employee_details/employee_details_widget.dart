part of 'employee_details_view.dart';

class EmployeeDetailsWidget extends StatefulWidget {
  const EmployeeDetailsWidget({
    super.key,
    required this.formType,
    required this.pageTitle,
    this.employeeModel,
    required this.onCancel,
    required this.onSave,
  });

  final EmployeeFormType formType;
  final String pageTitle;
  final EmployeeModel? employeeModel;
  final VoidCallback onCancel;
  final Function(EmployeeModel) onSave;

  @override
  State<EmployeeDetailsWidget> createState() => _EmployeeDetailsWidgetState();
}

class _EmployeeDetailsWidgetState extends State<EmployeeDetailsWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController roleFieldController;
  late TextEditingController nameFieldController;
  late TextEditingController fromDateFieldController;
  late TextEditingController toDateFieldController;

  @override
  void initState() {
    super.initState();

    roleFieldController =
        TextEditingController(text: widget.employeeModel?.empRole);
    nameFieldController =
        TextEditingController(text: widget.employeeModel?.empName);
    fromDateFieldController = TextEditingController(
        text: widget.employeeModel?.fromDate != null
            ? DateFormat('dd MMM yyyy')
                .format(widget.employeeModel!.fromDate)
                .toString()
            : null);
    toDateFieldController = TextEditingController(
      text: widget.employeeModel?.toDate != null
          ? DateFormat('dd MMM yyyy')
              .format(widget.employeeModel!.toDate!)
              .toString()
          : null,
    );
  }

  @override
  void dispose() {
    roleFieldController.dispose();
    nameFieldController.dispose();
    fromDateFieldController.dispose();
    toDateFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.pageTitle),
          automaticallyImplyLeading: false,
          actions: [
            if (widget.formType == EmployeeFormType.edit)
              IconButton(
                  onPressed: () {
                    context.read<EmployeeListBloc>().add(
                          DeleteEmployeeEvent(
                            emp: widget.employeeModel!,
                          ),
                        );

                    context.pop();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(Constants.empDeleted),
                        ),
                      );
                    });
                  },
                  icon: const Icon(Icons.delete_outline))
          ],
        ),
        body: ListView(shrinkWrap: false, children: [
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  firstNameField(),
                  const SizedBox(
                    height: 23,
                  ),
                  jobRoleField(context),
                  const SizedBox(
                    height: 23,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 4, child: fromDateField()),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 8),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(flex: 4, child: toDateField()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
        bottomSheet: ButtonBar(
          children: [
            ActionBtnWidget(
              actionText: Constants.cancelBtn,
              onPressed: widget.onCancel,
              type: ActionBtnType.cancel,
              forDialog: false,
            ),
            ActionBtnWidget(
              actionText: Constants.saveBtn,
              onPressed: () {
                var toDate = toDateFieldController.text.isNotEmpty &&
                        toDateFieldController.text != DateOptions.noDate.string
                    ? DateFormat('dd MMM yyyy')
                        .parse(toDateFieldController.text)
                    : null;

                if (_formKey.currentState!.validate()) {
                  var fromDate = DateFormat('dd MMM yyyy')
                      .parse(fromDateFieldController.text);
                  if (toDate != null && fromDate.isAfter(toDate)) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(Constants.wrongDateRange),
                        ),
                      );
                  } else {
                    var emp = EmployeeModel(
                      
                      empName: nameFieldController.text,
                      empRole: roleFieldController.text,
                      fromDate: fromDate,
                      toDate: toDate,
                    );
                    widget.onSave(emp);
                  }
                }
              },
              type: ActionBtnType.save,
              forDialog: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget fromDateField() {
    return TextFormField(
      controller: fromDateFieldController,
      readOnly: true,
      validator: (String? value) {
        return (value != null && value.isEmpty) ? 'Select start date' : null;
      },
      onTap: () async {
        var val = await showDialog<DateTime>(
          context: context,
          builder: (context) => const CalenderWidget(
            calenderMode: CalendarMode.fromDate,
          ),
        );
        if (val != null) {
          setState(() {
            fromDateFieldController = TextEditingController(
                text: DateFormat('dd MMM yyyy').format(val));
          });
        }
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        prefixIcon: Icon(
          Icons.event_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'No date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget toDateField() {
    return TextFormField(
      controller: toDateFieldController,
      readOnly: true,
      onTap: () async {
        var val = await showDialog<DateTime>(
          context: context,
          builder: (context) => const CalenderWidget(
            calenderMode: CalendarMode.toDate,
          ),
        );
        if (val != null) {
          setState(() {
            toDateFieldController = TextEditingController(
                text: DateFormat('dd MMM yyyy').format(val));
          });
        } else {
          setState(() {
            toDateFieldController = TextEditingController(
              text: DateOptions.noDate.string,
            );
          });
        }
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.event_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'No date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget jobRoleField(BuildContext context) {
    return TextFormField(
      controller: roleFieldController,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.work_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down_rounded,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'Select Role',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onSaved: (String? value) {},
      validator: (String? value) {
        return (value != null && value.isEmpty) ? 'Select a role' : null;
      },
      onTap: () async {
        var result = await showModalBottomSheet<String>(
          useSafeArea: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  context.pop(Constants.empRoles[index]);
                },
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Constants.empRoles[index]),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
              itemCount: Constants.empRoles.length,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        );
        if (result != null) {
          roleFieldController.value = TextEditingValue(text: result);
        }
      },
    );
  }

  Widget firstNameField() {
    return TextFormField(
      controller: nameFieldController,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_outline_sharp,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'Employee Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (String? value) {
        return (value != null && value.isEmpty) ? 'Enter employee name' : null;
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class EmployeeDetailsWidget extends StatefulWidget {
  const EmployeeDetailsWidget({
    super.key,
    required this.formType,
    required this.pageTitle,
  });

  final EmployeeFormType formType;
  final String pageTitle;

  @override
  State<EmployeeDetailsWidget> createState() => _EmployeeDetailsWidgetState();
}

class _EmployeeDetailsWidgetState extends State<EmployeeDetailsWidget> {
  final _formKey = GlobalKey<FormState>();

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
                  onPressed: () {}, icon: const Icon(Icons.delete_outline))
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
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
                  children: [
                    Expanded(flex: 2, child: fromDateField()),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Expanded(flex: 2, child: toDateField()),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomSheet: ButtonBar(
          children: [
            TextButton(
                onPressed: () {}, child: const Text(Constants.cancelBtn)),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Details saved')),
                  );
                }
              },
              child: const Text(Constants.saveBtn),
            )
          ],
        ),
      ),
    );
  }

  Widget fromDateField() {
    return TextFormField(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => const CalenderWidget(),
        );
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.event_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      initialValue: "Today",
    );
  }

  Widget toDateField() {
    return TextFormField(
      onTap: () async {},
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.event_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'No date',
        border: const OutlineInputBorder(),
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
        border: const OutlineInputBorder(),
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
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemBuilder: (context, index) => const Card(
                elevation: 0,
                child: Center(
                  child: Text("afa"),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 4,
            ),
          ),
          constraints: const BoxConstraints.expand(height: 4 * 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
        );
      },
    );
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_outline_sharp,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: 'Employee Name',
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffE5E5E5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onSaved: (String? value) {},
      validator: (String? value) {
        return (value != null && value.isEmpty) ? 'Enter employee name' : null;
      },
    );
  }
}

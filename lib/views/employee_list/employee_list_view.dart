import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/employee_model.dart';

import '../../utils/utils.dart';
import 'bloc/employee_list_bloc.dart';

part 'dismissible_widget.dart';
part 'sliver_header_widget.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text(Constants.empListPageTitle),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            context.push('/details');
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
        body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
          builder: (currContext, state) {
            if (state.employees.isEmpty) {
              if (state.status == EmployeeListStatus.loading) {
                return const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/no_record.svg'),
                    ],
                  ),
                );
              }
            }

            return CustomScrollView(
              slivers: buildSliverList(state, currContext),
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildSliverList(
      EmployeeListState state, BuildContext currContext) {
    return [
      if (state.currEmployees.isNotEmpty)
        SliverPersistentHeader(
          pinned: false,
          delegate: SliverHeaderWidget(
            title: Constants.currEmps,
          ),
        ),
      if (state.currEmployees.isNotEmpty)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.currEmployees.length,
            (context, index) => DismissibleWidget(
              model: state.currEmployees[index],
              onDelete: () {
                context.read<EmployeeListBloc>().add(
                      DeleteEmployeeEvent(
                        emp: state.currEmployees[index],
                      ),
                    );
              },
              undoDelete: () {
                currContext.read<EmployeeListBloc>().add(
                      UndoDeleteEmployeeEvent(),
                    );
              },
              onTap: () {
                context.push(
                  '/details',
                  extra: state.currEmployees[index],
                );
              },
            ),
          ),
        ),
      if (state.prevEmployees.isNotEmpty)
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderWidget(
            title: Constants.prevEmps,
          ),
        ),
      if (state.prevEmployees.isNotEmpty)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.prevEmployees.length,
            (context, index) => DismissibleWidget(
              model: state.prevEmployees[index],
              onTap: () {
                context.push(
                  '/details',
                  extra: state.prevEmployees[index],
                );
              },
              onDelete: () {
                context
                    .read<EmployeeListBloc>()
                    .add(DeleteEmployeeEvent(emp: state.prevEmployees[index]));
              },
              undoDelete: () {
                currContext.read<EmployeeListBloc>().add(
                      UndoDeleteEmployeeEvent(),
                    );
              },
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            Constants.swipDelete,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    ];
  }
}

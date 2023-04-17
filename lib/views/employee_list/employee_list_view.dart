import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/utils.dart';

part 'dismissible_widget.dart';
part 'sliver_header_widget.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  final List<int> numbers = List.generate(5, (index) => index);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.empListPageTitle),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            context.push('/add');
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderWidget(
                title: Constants.currEmps,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 40,
                (context, index) => DismissibleWidget(
                  index: index,
                  onTap: () {
                    context.push('/edit');
                  },
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderWidget(
                title: Constants.prevEmps,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 40,
                (context, index) => DismissibleWidget(
                  index: index,
                  onTap: () {
                    context.push('/edit');
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 64),
                child: const Text(
                  Constants.swipDelete,
                  style: TextStyle(
                    color: Color(0xff949C9E),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

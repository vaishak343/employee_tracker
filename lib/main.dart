import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/add_employee/add_employee.dart';
import 'views/edit_employee/edit_employee.dart';
import 'views/employee_list/employee_list.dart';

void main() {
  runApp(const RootWidget());
}

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const EmployeeListView(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddEmployeeView(),
          ),
          GoRoute(
            path: 'edit',
            builder: (context, state) => const EditEmployeeView(),
          ),
        ])
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff1DA1F2),
          onPrimary: Colors.white,
          secondary: Color(0xff1DA1F2),
          onSecondary: Colors.white,
          error: Color(0xffF34642),
          onError: Colors.white,
          background: Color(0xffF2F2F2),
          onBackground: Color(0xff1DA1F2),
          surface: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      routerConfig: _router,
    );
  }
}

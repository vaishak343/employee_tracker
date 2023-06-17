import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employee_tracker/models/employee_model.dart';
import 'package:employee_tracker/repositories/employee_repo.dart';
import 'package:employee_tracker/services/services.dart';
import 'utils/utils.dart';
import 'views/employee_details/employee_details.dart';
import 'views/employee_list/employee_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeModelAdapter());
  var empBox = await Hive.openBox<EmployeeModel>(Constants.empBox);
  runApp(
    RepositoryProvider(
      create: (context) => EmployeeRepo(
        hiveService: HiveService<EmployeeModel>(box: empBox),
      ),
      child: const RootWidget(),
    ),
  );
}

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const EmployeeListView(),
        routes: [
          GoRoute(
            path: 'details',
            builder: (context, state) {
              return EmployeeDetailsView(model: state.extra as EmployeeModel?);
            },
          ),
        ],
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              EmployeeListBloc(employeeRepo: context.read<EmployeeRepo>())
                ..add(LoadEmployeesEvent()),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color(0xff323238),
            actionTextColor: Color(0xff1DA1F2),
          ),
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
            onSurface: Colors.black,
            primaryContainer: Color(0xffEDF8FF),
            onPrimaryContainer: Color(0xff1DA1F2),
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

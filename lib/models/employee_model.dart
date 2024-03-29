import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends Equatable {
  const EmployeeModel({
    required this.empId,
    required this.empName,
    required this.empRole,
    required this.fromDate,
    this.toDate,
  });

  @HiveField(0)
  final String empId;
  @HiveField(1)
  final String empName;
  @HiveField(2)
  final String empRole;
  @HiveField(3)
  final DateTime fromDate;
  @HiveField(4)
  final DateTime? toDate;

  EmployeeModel copyWith({
    String? empId,
    String? empName,
    String? empRole,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return EmployeeModel(
      empId: empId ?? this.empId,
      toDate: toDate ?? this.toDate,
      empName: empName ?? this.empName,
      empRole: empRole ?? this.empRole,
      fromDate: fromDate ?? this.fromDate,
    );
  }

  @override
  List<Object?> get props => [
        empId,
        empName,
        empRole,
        toDate,
        fromDate,
      ];
}

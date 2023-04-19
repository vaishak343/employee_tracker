class Constants {
  //Hive Box Name
  static const String empBox = 'empBox';

  // String Constants
  static const String empListViewTitle = "Employee List";
  static const String currEmps = "Current employees";
  static const String prevEmps = "Previous employees";
  static const String swipDelete = "Swipe left to delete";
  static const String empDeleted = "Employee data has been deleted";
  static const String wrongDateRange = "Start date should be before end date";
  static const String undo = "Undo";
  static const String empListPageTitle = "Employee List";
  static const String addEmpDtlsPageTitle = "Add Employee Details";
  static const String editEmpDtlsPageTitle = "Edit Employee Details";
  static const String cancelBtn = "Cancel";
  static const String saveBtn = "Save";

  //Roles
  static const List<String> empRoles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];
}

enum EmployeeFormType { add, edit }

enum ActionBtnType { cancel, save }

enum CalendarMode { fromDate, toDate }

enum DateOptions { today, nextMonday, nextTuesday, afterOneWeek, noDate }

extension DateOptionsExtension on DateOptions {
  String get string {
    switch (this) {
      case DateOptions.today:
        return 'Today';
      case DateOptions.nextMonday:
        return 'Next Monday';
      case DateOptions.nextTuesday:
        return 'Next Tuesday';
      case DateOptions.afterOneWeek:
        return 'After 1 Week';
      case DateOptions.noDate:
        return 'No Date';
      default:
        return '';
    }
  }
}

extension StringExtension on String {
  String get toName {
    var nameParts = trim().split(' ');
    if (nameParts.length == 1) {
      return "${nameParts[0][0].toUpperCase()}${nameParts[0].substring(1)}";
    }
    var firstName = nameParts.first;
    var lastName = nameParts.last;
    return "${firstName[0].toUpperCase()}${firstName.substring(1)} ${lastName[0].toUpperCase()}${lastName.substring(1)}";
  }
}

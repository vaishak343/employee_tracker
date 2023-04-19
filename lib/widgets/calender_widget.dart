import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:realtime_inov/utils/utils.dart';
import 'package:realtime_inov/widgets/widgets.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({
    required this.calenderMode,
    super.key,
  });

  final CalendarMode calenderMode;

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  List<DateTime?> _dateValues = [
    DateTime.now(),
  ];

  DateTime getNextMonday(DateTime now) {
    int daysUntilNextMonday = 1 - now.weekday;
    if (daysUntilNextMonday <= 0) daysUntilNextMonday += 7;
    return now.add(Duration(days: daysUntilNextMonday));
  }

  DateTime getNextTuesday(DateTime now) {
    int daysUntilNextTuesday = 2 - now.weekday;
    if (daysUntilNextTuesday <= 0) daysUntilNextTuesday += 7;
    return now.add(Duration(days: daysUntilNextTuesday));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 140,
                minHeight: 84,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DateOptionsWidget(
                  calenderMode: widget.calenderMode,
                  onPressed: (val) {
                    switch (val) {
                      case DateOptions.noDate:
                        setState(() {
                          _dateValues = [];
                        });
                        break;
                      case DateOptions.today:
                        setState(() {
                          _dateValues = [DateTime.now()];
                        });
                        break;
                      case DateOptions.nextMonday:
                        setState(() {
                          _dateValues = [getNextMonday(DateTime.now())];
                        });
                        break;
                      case DateOptions.nextTuesday:
                        setState(() {
                          _dateValues = [getNextTuesday(DateTime.now())];
                        });
                        break;
                      case DateOptions.afterOneWeek:
                        setState(() {
                          _dateValues = [
                            DateTime.now().add(const Duration(days: 7))
                          ];
                        });
                        break;
                    }
                  },
                ),
              ),
            ),
            CalendarDatePicker2(
              config: getDatePickerConfig(
                DateTime.now(),
                widget.calenderMode,
              ),
              value: _dateValues,
              onValueChanged: (dates) {
                setState(() {
                  _dateValues = dates;
                });
              },
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            _dateValues.isNotEmpty
                                ? DateFormat('dd MMM yyyy')
                                    .format(_dateValues.first!)
                                : 'No Date',
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionBtnWidget(
                          actionText: Constants.cancelBtn,
                          onPressed: () {
                            context.pop();
                          },
                          type: ActionBtnType.cancel,
                          forDialog: true,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ActionBtnWidget(
                          actionText: Constants.saveBtn,
                          onPressed: () {
                            if (_dateValues.isNotEmpty) {
                              context.pop(_dateValues.first);
                            } else {
                              context.pop(null);
                            }
                          },
                          type: ActionBtnType.save,
                          forDialog: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  CalendarDatePicker2Config getDatePickerConfig(
    DateTime? initialDate,
    CalendarMode mode,
  ) {
    return CalendarDatePicker2Config(
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black,
      ),
      currentDate: initialDate,
      customModePickerIcon: const SizedBox(),
      centerAlignModePicker: true,
      lastMonthIcon: const Icon(
        Icons.arrow_left_rounded,
        size: 30,
      ),
      nextMonthIcon: const Icon(
        Icons.arrow_right_rounded,
        size: 30,
      ),
      todayTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      firstDayOfWeek: 0,
      controlsHeight: 50,
      controlsTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 15,
      ),
      dayBuilder: ({
        required date,
        decoration,
        isDisabled,
        isSelected,
        isToday,
        textStyle,
      }) {
        Widget? dayWidget;
        dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Text(
              MaterialLocalizations.of(context).formatDecimal(date.day),
              style: textStyle,
            ),
          ),
        );
        return dayWidget;
      },
      dayTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectedDayTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      selectedDayHighlightColor: Theme.of(context).colorScheme.primary,
      selectableDayPredicate: mode == CalendarMode.fromDate
          ? null
          : initialDate != null
              ? (day) {
                  return !day
                      .difference(
                          initialDate.subtract(const Duration(days: 25)))
                      .isNegative;
                }
              : null,
    );
  }
}

class DateOptionsWidget extends StatefulWidget {
  const DateOptionsWidget({
    required this.calenderMode,
    required this.onPressed,
    super.key,
  });

  final CalendarMode calenderMode;
  final Function(DateOptions) onPressed;

  @override
  State<DateOptionsWidget> createState() => _DateOptionsWidgetState();
}

class _DateOptionsWidgetState extends State<DateOptionsWidget> {
  DateOptions? selectedButton;

  Widget elevatedButton(
      VoidCallback onPressed, bool isSelected, DateOptions label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
          widget.onPressed(label);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer,
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            label.string,
            maxLines: 1,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        if (widget.calenderMode == CalendarMode.toDate)
          TableRow(
            children: [
              elevatedButton(
                () => setState(() => selectedButton = DateOptions.noDate),
                selectedButton == DateOptions.noDate,
                DateOptions.noDate,
              ),
              elevatedButton(
                () => setState(() => selectedButton = DateOptions.today),
                selectedButton == DateOptions.today,
                DateOptions.today,
              ),
            ],
          ),
        if (widget.calenderMode == CalendarMode.fromDate) ...[
          TableRow(
            children: [
              elevatedButton(
                () => setState(() => selectedButton = DateOptions.today),
                selectedButton == DateOptions.today,
                DateOptions.today,
              ),
              elevatedButton(
                () => setState(() => selectedButton = DateOptions.nextMonday),
                selectedButton == DateOptions.nextMonday,
                DateOptions.nextMonday,
              ),
            ],
          ),
          TableRow(
            children: [
              elevatedButton(
                () => setState(() => selectedButton = DateOptions.nextTuesday),
                selectedButton == DateOptions.nextTuesday,
                DateOptions.nextTuesday,
              ),
              elevatedButton(
                () => setState(() => selectedButton = DateOptions.afterOneWeek),
                selectedButton == DateOptions.afterOneWeek,
                DateOptions.afterOneWeek,
              ),
            ],
          )
        ]
      ],
    );
  }
}

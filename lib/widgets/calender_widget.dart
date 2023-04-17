import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:realtime_inov/utils/utils.dart';
import 'package:realtime_inov/widgets/widgets.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  List<DateTime?> _dateValues = [
    DateTime.now(),
  ];

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
                maxHeight: 120,
                minHeight: 84,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Table(
                  children: const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: ToggleableButtonWidget(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: ToggleableButtonWidget(),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: ToggleableButtonWidget(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: ToggleableButtonWidget(),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            CalendarDatePicker2(
              config: getDatePickerConfig(),
              value: _dateValues,
              onValueChanged: (dates) => setState(() => _dateValues = dates),
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
                        const FittedBox(
                            fit: BoxFit.fill, child: Text("5 Sep 2023"))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionBtnWidget(
                            actionText: Constants.cancelBtn,
                            onPressed: () {},
                            type: ActionBtnType.cancel,
                            forDialog: true),
                        const SizedBox(
                          width: 8,
                        ),
                        ActionBtnWidget(
                            actionText: Constants.saveBtn,
                            onPressed: () {},
                            type: ActionBtnType.save,
                            forDialog: true),
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

  CalendarDatePicker2Config getDatePickerConfig() {
    return CalendarDatePicker2Config(
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black,
      ),
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
      dayTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectedDayTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 15,
      ),
      selectedDayHighlightColor: Theme.of(context).colorScheme.primary,
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
  }
}

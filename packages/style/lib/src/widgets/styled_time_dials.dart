import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/src/gap.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/widgets/styled_dial.dart';

class StyledTimeDials extends StatelessWidget {
  final Time value;
  final Function(Time) onChanged;

  const StyledTimeDials({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ScrollAbsorber(
      child: Row(
        mainAxisAlignment: .center,
        children: [
          StyledDial(
            options: context.timeFormat.when(
              twentyFourHour: List.generate(24, (hour) => hour),
              amPm: List.generate(12, (hour) => hour + 1),
            ),
            initiallySelected: context.timeFormat.when(
              twentyFourHour: value.hour,
              amPm: value.hourOfPeriod == 0 ? 12 : value.hourOfPeriod,
            ),
            onSelected: (hour) => onChanged(
              Time(
                hour: context.timeFormat.when(twentyFourHour: hour, amPm: hour % 12 + (value.period == .pm ? 12 : 0)),
                minute: value.minute,
              ),
            ),
            itemBuilder: (hour) =>
                hour.toString().padLeft(context.timeFormat.when(twentyFourHour: 2, amPm: 1), '0').toText(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8) + .symmetric(horizontal: 4),
            child: Text(':', style: context.textStyle.headingSm),
          ),
          StyledDial(
            options: List.generate(60, (minute) => minute),
            initiallySelected: value.minute,
            onSelected: (minute) => onChanged(Time(hour: value.hour, minute: minute)),
            itemBuilder: (minute) => minute.toString().padLeft(2, '0').toText(),
          ),
          ...context.timeFormat.when(
            twentyFourHour: <Widget>[],
            amPm: [
              gapW8,
              StyledDial(
                options: TimePeriod.values,
                initiallySelected: value.period,
                onSelected: (period) =>
                    onChanged(Time(hour: value.hourOfPeriod + (period == .pm ? 12 : 0), minute: value.minute)),
                itemBuilder: (period) => period.format().toText(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

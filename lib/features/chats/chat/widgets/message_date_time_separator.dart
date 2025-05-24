import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared/shared.dart';

class MessageDateTimeSeparator extends StatelessWidget {
  const MessageDateTimeSeparator({
    required this.date,
    super.key,
    this.floating = false,
  });

  final DateTime date;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: s),
        padding:  EdgeInsets.symmetric(
          horizontal: md,
          vertical:2,
        ),
        decoration: BoxDecoration(
          color: floating ? AppColors.dark.withOpacity(.7) : AppColors.dark,
          borderRadius: const BorderRadius.all(Radius.circular(22)),
        ),
        child: Text(
          date.format(context, dateFormat: DateFormat.MMMMd),
          style: context.bodyMedium?.apply(color: AppColors.white),
        ),
      ),
    );
  }
}

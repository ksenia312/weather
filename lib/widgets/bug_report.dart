import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class BugReport extends StatefulWidget {
  final String error;

  const BugReport({Key? key, required this.error}) : super(key: key);

  @override
  State<BugReport> createState() => _BugReportState();
}

class _BugReportState extends State<BugReport> {
  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(widget.error)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).errorColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Data reception error ',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).errorColor),
            ),
            Icon(
              Icons.warning,
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}

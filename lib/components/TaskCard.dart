import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String subjectName;
  final int days;
  TaskCard({Key? key, required this.days, required this.subjectName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(10),
      width: 200,
      decoration: BoxDecoration(
        color: days <= 3 ? Colors.red[50] : Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deadline",
            style: TextStyle(color: _theme.shadowColor, fontSize: 16),
          ),
          Row(
            children: [
              Icon(
                Icons.circle,
                color: days <= 3 ? Colors.red : Colors.green,
                size: 12,
              ),
              const SizedBox(width: 5),
              Text(
                "${days.toString()} days left",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _theme.cardColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            child: Expanded(
              child: Text(
                subjectName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

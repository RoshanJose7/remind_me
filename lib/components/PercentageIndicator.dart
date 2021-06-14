import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageIndicator extends StatefulWidget {
  final String subjectName;
  final double completedPercent;
  final int classes;

  const PercentageIndicator({
    Key? key,
    required this.completedPercent,
    required this.subjectName,
    required this.classes,
  }) : super(key: key);

  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  @override
  Widget build(BuildContext context) {
    final Color _color =
        widget.completedPercent >= 75 ? Colors.greenAccent : Colors.redAccent;

    Widget generateSuggestion() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Edit Percentage",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.blueGrey,
                  size: 25,
                ),
              ),
            ],
          ),
          widget.completedPercent >= 75
              ? Text(
                  "You can bunk ${widget.classes} more classes.",
                  style: TextStyle(
                    color: _color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Text(
                  "You will have to attend ${widget.classes} more classes.",
                  style: TextStyle(
                    color: _color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.subjectName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 500,
                  percent: widget.completedPercent / 100,
                  progressColor: _color.withOpacity(0.7),
                  backgroundColor: _color.withOpacity(0.4),
                  curve: Curves.easeInOut,
                  radius: 100,
                  center: Text(
                    "${widget.completedPercent.round()}%",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _color,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Flexible(child: generateSuggestion()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class PercentageIndicator extends StatefulWidget {
  final String subId;
  final String subjectName;
  final double completedPercent;
  final int totalClasses;
  final int attendedClasses;

  const PercentageIndicator({
    Key? key,
    required this.subId,
    required this.completedPercent,
    required this.subjectName,
    required this.totalClasses,
    required this.attendedClasses,
  }) : super(key: key);

  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  @override
  Widget build(BuildContext context) {
    final subjectsProvider = Provider.of<SubjectsProvider>(context);
    final Color color =
        widget.completedPercent > 75 ? Colors.greenAccent : Colors.redAccent;

    _calcReqdClasses(int comp, int att) {
      if (att / comp > 0.75) return ((comp * 0.75).ceil() - att);

      int classes = 0, sub = -1;

      while (sub != 0) {
        sub = (comp * 0.75).ceil() - att;

        comp += sub;
        if (sub > 0) att += sub;
        classes++;
      }

      return classes;
    }

    int classesAttended = widget.attendedClasses;
    int classesCompleted = widget.totalClasses;
    int redqClasses = _calcReqdClasses(classesCompleted, classesAttended);

    _showEditPercentageDialog(context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Edit Total Classes Attended"),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Classes Attended",
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: classesAttended.toString(),
                          onChanged: (val) {
                            if (val != "") classesAttended = int.parse(val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) return "Enter a Number";
                            return null;
                          },
                          onSaved: (val) =>
                              setState(() => classesAttended = int.parse(val!)),
                        ),
                        const SizedBox(height: 20),
                        const Text("Edit Total Classes Completed"),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Classes Completed",
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: classesCompleted.toString(),
                          onChanged: (val) {
                            if (val != "") classesCompleted = int.parse(val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) return "Enter a Number";
                            return null;
                          },
                          onSaved: (val) {
                            if (val != null)
                              setState(() => classesCompleted = int.parse(val));
                          },
                        ),
                        TextButton(
                          onPressed: () => setState(() {
                            subjectsProvider.updateClasses(
                              id: widget.subId,
                              totalClasses: classesCompleted,
                              attendedClasses: classesAttended,
                            );
                            Navigator.of(context).pop();
                          }),
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }

    Widget generateSuggestion() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _showEditPercentageDialog(context),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blueGrey,
                  size: 20,
                ),
              ),
            ],
          ),
          redqClasses < 0
              ? Text(
                  "You can bunk ${redqClasses.abs()} more classes.",
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : redqClasses == 0
                  ? Text(
                      "You are right on Track.",
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      "You will have to attend ${redqClasses.abs()} more class/es.",
                      style: TextStyle(
                        color: color,
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
            style: const TextStyle(
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
                  progressColor: color.withOpacity(0.7),
                  backgroundColor: color.withOpacity(0.4),
                  curve: Curves.easeInOut,
                  radius: 100,
                  center: Text(
                    "${widget.completedPercent.round()}%",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
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

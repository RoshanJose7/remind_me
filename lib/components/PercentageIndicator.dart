import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/Subjects.dart';

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
    final _subjectsProvider = Provider.of<Subjects>(context);
    final Color _color =
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

    int _classesAttended = widget.attendedClasses;
    int _classesCompleted = widget.totalClasses;
    int _redqClasses = _calcReqdClasses(_classesCompleted, _classesAttended);

    _showEditPercentageDialog(context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxHeight: 250),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Edit Total Classes Attended"),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Classes Attended",
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: _classesAttended.toString(),
                          onChanged: (val) {
                            if (val != "") _classesAttended = int.parse(val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) return "Enter a Number";
                            return null;
                          },
                          onSaved: (val) => setState(
                              () => _classesAttended = int.parse(val!)),
                        ),
                        const SizedBox(height: 20),
                        Text("Edit Total Classes Completed"),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Classes Completed",
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: _classesCompleted.toString(),
                          onChanged: (val) {
                            if (val != "") _classesCompleted = int.parse(val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) return "Enter a Number";
                            return null;
                          },
                          onSaved: (val) {
                            if (val != null)
                              setState(
                                  () => _classesCompleted = int.parse(val));
                          },
                        ),
                        TextButton(
                          onPressed: () => setState(() {
                            _subjectsProvider.updateClasses(
                              id: widget.subId,
                              totalClasses: _classesCompleted,
                              attendedClasses: _classesAttended,
                            );
                            Navigator.of(context).pop();
                          }),
                          child: Text(
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
              Flexible(
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
                icon: Icon(
                  Icons.edit,
                  color: Colors.blueGrey,
                  size: 20,
                ),
              ),
            ],
          ),
          _redqClasses < 0
              ? Text(
                  "You can bunk ${_redqClasses.abs()} more classes.",
                  style: TextStyle(
                    color: _color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : _redqClasses == 0
                  ? Text(
                      "You are right on Track.",
                      style: TextStyle(
                        color: _color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      "You will have to attend ${_redqClasses.abs()} more class/es.",
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

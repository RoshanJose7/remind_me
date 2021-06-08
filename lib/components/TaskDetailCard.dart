import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/Tasks.dart';

class TaskDetailCard extends StatefulWidget {
  final String id;
  final bool isCompleted;
  final String subject;
  final String description;
  final String deadLine;

  TaskDetailCard({
    required this.id,
    required this.isCompleted,
    required this.subject,
    required this.deadLine,
    required this.description,
  });

  @override
  _TaskDetailCardState createState() => _TaskDetailCardState();
}

class _TaskDetailCardState extends State<TaskDetailCard> {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    print(widget.deadLine);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: widget.isCompleted
            ? Colors.greenAccent[400]
            : Colors.redAccent[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.subject,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Row(
                children: [
                  !widget.isCompleted
                      ? Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 40,
                          height: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Mark as Completed?"),
                                action: SnackBarAction(
                                  label: "Confirm",
                                  onPressed: () => tasksProvider.markCompleted(
                                      id: widget.id),
                                  textColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 40,
                          height: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Delete Task?"),
                                action: SnackBarAction(
                                  label: "Confirm",
                                  onPressed: () =>
                                      tasksProvider.removeTask(id: widget.id),
                                  textColor: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Description : ${widget.description}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            "DeadLine : ${DateTime.parse(widget.deadLine).day - DateTime.now().day} days left, ${DateTime.parse(widget.deadLine).hour - DateTime.now().hour} hours left.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TaskDetailCard extends StatefulWidget {
  bool isCompleted;
  String subject;
  String description;
  DateTime deadLine;

  TaskDetailCard({
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
                            onPressed: () {},
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
                              Icons.close,
                              color: Colors.red,
                            ),
                            onPressed: () {},
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
            "DeadLine : ${widget.deadLine.day - DateTime.now().day} days left",
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

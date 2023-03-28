import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/calendar_provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class SubjectCard extends StatelessWidget {
  final String id;
  final String subName;
  final String duration;
  final String professorName;
  final String roomName;
  final List timeSlots;

  SubjectCard({
    required this.id,
    required this.duration,
    required this.professorName,
    required this.roomName,
    required this.subName,
    required this.timeSlots,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subjectsProvider = context.watch<SubjectsProvider>();
    final calendarProvider = context.read<CalendarProvider>();

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white60,
        border: Border.all(
          color: Colors.blueGrey.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subject ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subName,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Time ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                duration,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Professor ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/img/professor.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    professorName,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Room Name ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  maxLines: 3,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: roomName.split(':')[0],
                      ),
                      const TextSpan(
                        text: ", ",
                      ),
                      TextSpan(
                        text: roomName.split(':')[1],
                      ),
                    ],
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            "Time Slots ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 7; i++)
                SizedBox(
                  width: 40,
                  height: 53,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        timeSlots[i] != null
                            ? theme.shadowColor
                            : theme.backgroundColor,
                      ),
                    ),
                    onPressed: () => Fluttertoast.showToast(
                      fontSize: 12.0,
                      msg: timeSlots[i] == null
                          ? "No Class"
                          : "${calendarProvider.days[i]} class at ${timeSlots[i]!.split(":")[0]}:${timeSlots[i]!.split(":")[1]}",
                      toastLength: Toast.LENGTH_LONG,
                      textColor: Colors.white,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.red,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          calendarProvider.week[i]['day'][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          calendarProvider.week[i]['date'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: timeSlots[i] != null
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Remove from List",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("You sure you want to delete $subName?"),
                    action: SnackBarAction(
                      label: "Confirm",
                      onPressed: () => subjectsProvider.removeSubject(id: id),
                      textColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

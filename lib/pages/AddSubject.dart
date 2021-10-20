import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/LocalNotifications.dart';
import 'package:remind_me/shared/globals.dart';
import 'package:uuid/uuid.dart';

class AddSubject extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final uuid = Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LocalNotifications _localNotifications = LocalNotifications();

  @override
  void initState() {
    super.initState();
    _localNotifications
        .configureSelectNotificationSubject(notificationSelected);
  }

  @override
  void dispose() {
    super.dispose();
    _localNotifications.dispose();
  }

  Future notificationSelected() async {
    print("tring");
    await Navigator.of(context).pushNamed("/onboard");
  }

  int count = 1;
  String _subName = "";
  int _hours = 00,
      _minutes = 00,
      _minRequiredClasses = 0,
      _totalClassesCompleted = 0;
  String _professorName = "";
  int _classesAttended = 0;
  String _roomFloor = "";
  String _roomName = "";
  List<String?> _timeSlots = [];

  Widget _buildSubNameField({required ThemeData theme}) => TextFormField(
        decoration: InputDecoration(
          labelText: "Subject Name",
          labelStyle: TextStyle(color: theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) {
          _subName = val!;
        },
      );

  Widget _buildProfessorNameField({required ThemeData theme}) => TextFormField(
        decoration: InputDecoration(
          labelText: "Professor Name",
          labelStyle: TextStyle(color: theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) => _professorName = val!,
      );

  Widget _buildDurationField({required ThemeData theme}) => Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "Duration",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.datetime,
                    onChanged: (val) => _hours = int.parse(val),
                    validator: (val) {
                      if (val == null)
                        return "Enter a valid number";
                      else if (int.tryParse(val) == 0)
                        return "Hour cannot be 0";
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Hours',
                      labelStyle: TextStyle(color: theme.shadowColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.shadowColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.shadowColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.datetime,
                    onChanged: (val) => _minutes = int.parse(val),
                    validator: (val) {
                      if (val == null) return "Enter a valid number";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Minutes',
                      labelStyle: TextStyle(color: theme.shadowColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.shadowColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.shadowColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Widget _buildRoomFloorField({required ThemeData theme}) => TextFormField(
        decoration: InputDecoration(
          labelText: "Room Floor",
          labelStyle: TextStyle(color: theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) => _roomFloor = val!,
      );

  Widget _buildClassesAttendedField({required ThemeData theme}) =>
      TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Total Classes Attended",
          labelStyle: TextStyle(color: theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) => _classesAttended = int.parse(val!),
      );

  Widget _buildTotalClassesField({required ThemeData theme}) => TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "No. of Classes Completed",
          labelStyle: TextStyle(color: theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) => _totalClassesCompleted = int.parse(val!),
      );

  Widget _buildRoomNameField({required ThemeData theme}) => TextFormField(
        decoration: InputDecoration(
          labelText: "Room Name",
          labelStyle: TextStyle(color: theme.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.shadowColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) {
          _roomName = val!;
        },
      );

  Widget _buildTimeSlotField(int i, {required ThemeData theme}) {
    setState(() {
      _timeSlots.add(null);
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.shadowColor.withOpacity(0.5),
            width: 2,
          ),
          top: BorderSide(
            color: theme.shadowColor.withOpacity(0.5),
            width: 2,
          ),
          left: BorderSide(
            color: theme.shadowColor.withOpacity(0.5),
            width: 2,
          ),
          right: BorderSide(
            color: theme.shadowColor.withOpacity(0.5),
            width: 2,
          ),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Global.days[i],
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 65),
              Text(
                i > _timeSlots.length - 1 || _timeSlots[i] == null
                    ? "No Class"
                    : "${_timeSlots[i]!}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) => setState(() => _timeSlots[i] =
                          "${date.toString().split(" ")[1].split(":")[0]}:${date.toString().split(" ")[1].split(":")[1] == '0' ? 00 : date.toString().split(" ")[1].split(":")[1]}"),
                      currentTime: DateTime(2021, 12, 12, 09, 41, 00),
                      locale: LocaleType.en,
                    );
                  },
                  child: Text(
                    "Pick Time",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () => setState(() => _timeSlots[i] = null),
                  child: Text(
                    "No Class",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final subjectProvider = Provider.of<Subjects>(context);
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.backgroundColor,
        iconTheme: IconThemeData(
          color: _theme.shadowColor,
        ),
        elevation: 0.0,
        title: Text(
          "Add Subject",
          style: TextStyle(
            fontFamily: "Righteous",
            fontSize: 24,
            color: _theme.cardColor,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSubNameField(theme: _theme),
                const SizedBox(height: 10),
                _buildProfessorNameField(theme: _theme),
                const SizedBox(height: 10),
                _buildClassesAttendedField(theme: _theme),
                const SizedBox(height: 10),
                _buildTotalClassesField(theme: _theme),
                const SizedBox(height: 10),
                _buildRoomFloorField(theme: _theme),
                const SizedBox(height: 10),
                _buildRoomNameField(theme: _theme),
                const SizedBox(height: 10),
                _buildDurationField(theme: _theme),
                Container(
                  width: width - 50,
                  height: height - 470,
                  constraints: BoxConstraints(
                    minHeight: 150,
                  ),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _theme.shadowColor.withOpacity(0.3),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        "Select Your Time Slots",
                        style: TextStyle(
                          fontSize: 17,
                          color: _theme.primaryColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Day",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 80),
                          Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < count && count <= 7; i++)
                        _buildTimeSlotField(i, theme: _theme),
                      if (count < 7)
                        TextButton(
                          child: Text(
                            "Add Day",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _theme.shadowColor,
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                count++;
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();

                    for (int i = _timeSlots.length - 1; i < 7; i++)
                      _timeSlots.add(null);

                    _minRequiredClasses =
                        subjectProvider.calcMinimumClassesRequired(
                      totalClasses: _totalClassesCompleted,
                      attendancePercent: subjectProvider.calcPercentage(
                        totalClasses: _totalClassesCompleted,
                        classesAttended: _classesAttended,
                      ),
                    );

                    subjectProvider.addSubject(
                      duration: "${_hours}hr ${_minutes}min",
                      subjectName: _subName,
                      classesAttended: _classesAttended,
                      professorName: _professorName,
                      roomName: "$_roomName:$_roomFloor",
                      timeSlots: _timeSlots,
                      minRequiredClasses: _minRequiredClasses,
                      totalClassesCompleted: _totalClassesCompleted,
                    );

                    _timeSlots.map((_slot) async {
                      if (_slot != null) {
                        await _localNotifications
                            .scheduleAtDayAndTimeNotification(
                          date: DateTime.parse(_slot),
                          channelId: uuid.v4(),
                          channelName: 'Subject Channel',
                          channelDesc: 'Subject Add Channel Description',
                          notificationTitle:
                              "$_subName will start in 5 minutes",
                          notificationBody: "$_subName starting at time $_slot",
                          payload: "subject",
                        );

                        await _localNotifications.repeatNotificationDaily(
                          date: DateTime.parse(_slot).add(
                              Duration(hours: _hours, minutes: _minutes + 1)),
                          channelId: uuid.v4(),
                          channelName: "Attendance Channel",
                          channelDesc: "Add Attendance Channel Description",
                          notificationTitle: "Mark Attendance Remainder",
                          notificationBody: "Did you attend $_subName today?",
                          payload: "attendance",
                        );
                      }
                    });

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    primary: _theme.primaryColor,
                  ),
                  child: Text(
                    "Add Subject",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

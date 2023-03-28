import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/MainState.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/providers/Theme.dart';
import 'package:remind_me/providers/subjects_provider.dart';
import 'package:remind_me/utils/files.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Tween<Offset> _tween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));

  late int _curIdx;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    final _themes = Provider.of<Themes>(context);
    final _tasksProvider = Provider.of<Tasks>(context);
    final _subjectsProvider = Provider.of<SubjectsProvider>(context);
    final _mainStateProvider = Provider.of<MainState>(context);

    final double width = MediaQuery.of(context).size.width;
    final _theme = Theme.of(context);
    String _name = _mainStateProvider.userName;
    _curIdx = _themes.themeIdx;

    void getPic() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        File uploadfile = File(result.files.single.path!);
        final _path = await _localPath;
        File newFile =
            await uploadfile.copy("$_path/${result.files.single.name}");
        _mainStateProvider.updatePicPath(path: newFile.path);
      }
    }

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, left: 20),
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _theme.backgroundColor,
                const Color(0xFFF0F0F0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.3],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: _theme.cardColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _mainStateProvider.picPath.startsWith("assets")
                        ? Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: _theme.shadowColor.withOpacity(0.2),
                                  blurRadius: 12,
                                  spreadRadius: 8,
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(_mainStateProvider.picPath),
                              ),
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  Image.file(File(_mainStateProvider.picPath)),
                            ),
                          ),
                    Text(
                      "Hi, $_name",
                      style: TextStyle(
                        color: _theme.shadowColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 230,
          bottom: 0,
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "User Name",
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_controller.isDismissed) {
                            _controller.forward();
                          } else if (_controller.isCompleted) {
                            _controller.reverse();
                          }
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Profile Picture",
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        tooltip: "Select Pic",
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () => getPic(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          "Color Theme",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < _themes.colorThemes.length; i++)
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: this._curIdx == i
                                ? Border.all(
                                    color: _theme.primaryColor, width: 3)
                                : null,
                          ),
                          child: new Material(
                            shape: const CircleBorder(),
                            color: _themes.colorThemes[i],
                            child: new InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                setState(() {
                                  this._curIdx = 0;
                                  _themes.changeTheme(idx: i);
                                });
                              },
                              splashColor: Colors.blueGrey[50],
                              child: new Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: const Text(
                          "Export Data",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Icon(Icons.file_download),
                        onPressed: () {
                          final _snackBar = SnackBar(
                            content: const Text("Download?"),
                            action: SnackBarAction(
                              label: "Yes",
                              onPressed: () async {
                                String? path = await downloadDirPath;
                                final subjects =
                                    await _subjectsProvider.toJSON();
                                final tasks = await _tasksProvider.toJSON();

                                final data = {
                                  "subjects": subjects,
                                  "tasks": tasks,
                                };

                                await createFile(
                                    path!,
                                    "${DateTime.now().millisecondsSinceEpoch}.json",
                                    jsonEncode(data));
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("File Saved!")),
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blueGrey[300],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 150,
                        child: Text(
                          "Import Data",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          File? file = await uploadFile();

                          if (file != null) {
                            final jsonString = await file.readAsString();
                            final data = jsonDecode(jsonString);
                            final subjects = data['subjects'];
                            final tasks = data['tasks'];

                            _subjectsProvider.fromJSON(subjects);
                            _tasksProvider.fromJSON(tasks);
                          }
                        },
                        style:
                            TextButton.styleFrom(primary: Colors.blueGrey[300]),
                        child: const Icon(Icons.file_upload),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 150,
                        child: Text(
                          "Clear Data",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async =>
                            await _subjectsProvider.clearData(),
                        style:
                            TextButton.styleFrom(primary: Colors.blueGrey[300]),
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox.expand(
          child: SlideTransition(
            position: _tween.animate(_controller),
            child: DraggableScrollableSheet(
              maxChildSize: 0.5,
              initialChildSize: 0.3,
              expand: false,
              snap: true,
              builder: (context, controller) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _theme.backgroundColor, width: 5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _controller.reverse(),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            Text(
                              "Edit Name",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: 24,
                                color: _theme.cardColor,
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Your Name",
                          ),
                          initialValue: _name,
                          onChanged: (val) => _name = val,
                          validator: (val) {
                            if (val!.isEmpty) return "Enter a Valid Name";
                            return null;
                          },
                          onSaved: (name) => setState(() => _name = name!),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(
                            () {
                              _mainStateProvider.updateUserName(name: _name);
                              _controller.reverse();
                            },
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            primary: _theme.primaryColor,
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

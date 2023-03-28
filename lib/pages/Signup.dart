import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/MainState.dart';

class GetInfoPage extends StatefulWidget {
  @override
  _GetInfoPageState createState() => _GetInfoPageState();
}

class _GetInfoPageState extends State<GetInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    final _mainStateProvider = Provider.of<MainState>(context);
    String _name = "";

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

    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "May I know how you look?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      tooltip: "Select Pic",
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                      onPressed: () => getPic(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "What would you love to be called?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: "User Name"),
                            validator: (String? val) {
                              if (val!.isEmpty) return "Provide a valid Input";
                              return null;
                            },
                            onSaved: (String? val) {
                              setState(() {
                                _name = val!;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              _formKey.currentState!.save();

                              _mainStateProvider.updateHideIntro(val: true);
                              _mainStateProvider.updateUserName(name: _name);
                              Navigator.of(context).pushNamed("/");
                            },
                            child: Container(
                              child: Text("Done!"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

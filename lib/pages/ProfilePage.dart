import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/MainState.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _mainStateProvider = Provider.of<MainState>(context);
    String _name = _mainStateProvider.userName;

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

    _showEditNameDialog(context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxHeight: 150),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Edit User Name"),
                        TextFormField(
                          decoration: InputDecoration(
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
                        TextButton(
                          onPressed: () => setState(() {
                            _mainStateProvider.updateUserName(name: _name);
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

    // _showEditPicDialog(context) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return Dialog(
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20.0),
    //           ),
    //           child: Container(
    //             constraints: BoxConstraints(maxHeight: 150),
    //             child: Padding(
    //               padding: const EdgeInsets.all(12.0),
    //               child: Form(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Text("Edit Profile Pic"),
    //                     IconButton(
    //                       tooltip: "Select Pic",
    //                       icon: Icon(
    //                         Icons.add_a_photo,
    //                         color: Colors.grey,
    //                       ),
    //                       onPressed: () => getPic(),
    //                     ),
    //                     TextButton(
    //                       onPressed: () => setState(() {
    //                         Navigator.of(context).pop();
    //                       }),
    //                       child: Text(
    //                         "Save",
    //                         style: TextStyle(fontSize: 18),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       });
    // }

    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            height: height,
            width: width,
            color: Colors.blueGrey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black54,
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
                            margin: EdgeInsets.only(right: 20, left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.2),
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
                            margin: EdgeInsets.only(right: 20, left: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  Image.file(File(_mainStateProvider.picPath)),
                            ),
                          ),
                    Text(
                      "Hi, $_name",
                      style: TextStyle(
                        color: Color(0xFF37408A),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 170,
            bottom: 0,
            child: Container(
              height: height - 230,
              width: width,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "User Name",
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () => _showEditNameDialog(context),
                          icon: Icon(
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
                        Text(
                          "Profile Picture",
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          tooltip: "Select Pic",
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () => getPic(),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       width: 150,
                    //       child: Text(
                    //         "Import TimeTable",
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //     ),
                    //     TextButton(
                    //       child: Icon(Icons.file_download),
                    //       onPressed: () async {
                    //         Directory _dir =
                    //             await getApplicationDocumentsDirectory();
                    //         final _snackBar = SnackBar(
                    //           content:
                    //               Text("Keep your file at the Downloads Folder"),
                    //           action: SnackBarAction(
                    //             label: "Upload to App",
                    //             onPressed: () {
                    //               File file = File(
                    //                   "/storage/emulated/0/Downloads/shared_preferences.json");
                    //               file.copy(_dir.path);
                    //             },
                    //           ),
                    //         );
                    //         ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    //       },
                    //       style: TextButton.styleFrom(
                    //         primary: Colors.blueGrey[300],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       width: 150,
                    //       child: Text(
                    //         "Export TimeTable",
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //     ),
                    //     TextButton(
                    //       child: Icon(Icons.file_upload),
                    //       onPressed: () async {
                    //         Directory _dir =
                    //             await getApplicationDocumentsDirectory();
                    //         File file =
                    //             File("${_dir.path}/shared_preferences.json");
                    //         file.copy("/storage/emulated/0/Downloads/");
                    //         final _snackBar = SnackBar(
                    //           content:
                    //               Text("Move your data file to Downloads filder"),
                    //         );
                    //         ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    //       },
                    //       style:
                    //           TextButton.styleFrom(primary: Colors.blueGrey[300]),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

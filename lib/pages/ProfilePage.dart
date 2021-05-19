import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/MainState.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _mainStateProvider = Provider.of<MainState>(context);

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
                      "Hi, ${_mainStateProvider.userName}",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          "Import TimeTable",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        child: Icon(Icons.file_download),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 30,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Upload a .db file",
                                      style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Select File",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.edit_rounded,
                                            color: Colors.blueGrey,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                      Container(
                        width: 150,
                        child: Text(
                          "Export TimeTable",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        child: Icon(Icons.file_upload),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 30,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Export to .db File",
                                      style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Select File",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.edit_rounded,
                                            color: Colors.blueGrey,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blueGrey[300],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

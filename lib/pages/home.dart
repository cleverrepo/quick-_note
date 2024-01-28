import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quicknote/pages/note_detail_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();
DateTime dateTime = DateTime.now();
Color getRandomColor() {
  Random random = Random();
  List<Color> generatedColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.brown,
    Colors.indigo,
    Colors.lime,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.grey,
  ];
  return generatedColor[random.nextInt(generatedColor.length)];
}

bool isGrid = false;

class _HomeState extends State<Home> {
  final globalKey = GlobalKey<FormState>();
  final backcgroud = getRandomColor();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection("cloudnote");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: ref.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Welcome to note Storage"),
                    Padding(padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration:InputDecoration(
                        label: Text("Search Note ",style:TextStyle(
                          color: backcgroud,
                        )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      )
                    ),

                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isGrid=!isGrid;
                            });
                          }, icon: const Icon(Icons.grid_4x4_rounded)),
                    ),
                    isGrid
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.hasData
                                ? snapshot.data.docs.length
                                : 0,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, mainAxisExtent: 250),
                            itemBuilder: (context, int index) {
                              final backcgroud = getRandomColor();
                              // Check if the document exists before accessing its properties
                              var title =
                                  snapshot.data?.docs[index].data()?['title'] ??
                                      '';
                              var content = snapshot.data?.docs[index]
                                      .data()?['content'] ??
                                  '';
                              var dateCreated = snapshot.data?.docs[index]
                                      .data()?['datecreated']
                                      ?.toDate()
                                      ?.toString() ??
                                  '';

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => NoteDetails(
                                          noteTile: title,
                                          noteContent: content,
                                          noteCreatioDate: dateCreated,
                                        ));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext) {
                                          return AlertDialog(
                                            content:
                                                const Text("choose action"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    CollectionReference
                                                        reference =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "cloudnote");
                                                    var documentId = snapshot
                                                        .data?.docs[index].id;

                                                    if (documentId != null) {
                                                      reference
                                                          .doc(documentId)
                                                          .delete()
                                                          .whenComplete(() =>
                                                              Navigator.pop(
                                                                  context))
                                                          .then((_) {
                                                        Get.snackbar("success",
                                                            "Note deleted Successfully");
                                                      }).catchError((error) {
                                                        Get.snackbar("Error",
                                                            error.toString());
                                                      });
                                                    }
                                                  },
                                                  child: const Text("delete")),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: backcgroud,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Column(
                                      children: [
                                        Text(
                                          title,
                                          softWrap: true,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          content,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 5,
                                        ),
                                        Text(
                                          dateCreated,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: IconButton(
                                              onPressed: () {
                                                var documentId = snapshot
                                                    .data?.docs[index].id;
                                                _showUpdateAlertDialog(
                                                    documentId, title, content);
                                              },
                                              icon: const Icon(Icons.edit),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Expanded(
                          child: ListView.builder(
                                                
                              shrinkWrap: true,
                              itemCount: snapshot.hasData
                                  ? snapshot.data.docs.length
                                  : 0,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, int index) {
                                final backcgroud = getRandomColor();
                                // Check if the document exists before accessing its properties
                                var title =
                                    snapshot.data?.docs[index].data()?['title'] ??
                                        '';
                                var content = snapshot.data?.docs[index]
                                        .data()?['content'] ??
                                    '';
                                var dateCreated = snapshot.data?.docs[index]
                                        .data()?['datecreated']
                                        ?.toDate()
                                        ?.toString() ??
                                    '';
                          
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => NoteDetails(
                                            noteTile: title,
                                            noteContent: content,
                                            noteCreatioDate: dateCreated,
                                          ));
                                    },
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext) {
                                            return AlertDialog(
                                              content:
                                                  const Text("choose action"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      CollectionReference
                                                          reference =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "cloudnote");
                                                      var documentId = snapshot
                                                          .data?.docs[index].id;
                          
                                                      if (documentId != null) {
                                                        reference
                                                            .doc(documentId)
                                                            .delete()
                                                            .whenComplete(() =>
                                                                Navigator.pop(
                                                                    context))
                                                            .then((_) {
                                                          Get.snackbar("success",
                                                              "Note deleted Successfully");
                                                        }).catchError((error) {
                                                          Get.snackbar("Error",
                                                              error.toString());
                                                        });
                                                      }
                                                    },
                                                    child: const Text("delete")),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 10, right: 10),
                                      decoration: BoxDecoration(
                                        color: backcgroud,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 230,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            title,
                                            softWrap: true,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            content,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 5,
                                          ),
                                          Text(
                                            dateCreated,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  var documentId = snapshot
                                                      .data?.docs[index].id;
                                                  _showUpdateAlertDialog(
                                                      documentId, title, content);
                                                },
                                                icon: const Icon(Icons.edit),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ),
                  ],
                );
              }
            }),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: _showAlertDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showUpdateAlertDialog(
      String documentId, String newTitle, String newContent) {
    titleController.text = newTitle;
    contentController.text = newContent;
    CollectionReference reference =
        FirebaseFirestore.instance.collection("cloudnote");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300.0, // Adjust the height as needed
            padding: const EdgeInsets.all(10.0), // Adjust content padding
            child: SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (title) {
                        if (title!.isEmpty) {
                          return "nothing to be saved";
                        } else {
                          return null;
                        }
                      },
                      controller: titleController,
                      decoration: const InputDecoration(
                          labelText: "Title",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 2))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (content) {
                        if (content!.isEmpty) {
                          return "nothing to be saved";
                        } else {
                          return null;
                        }
                      },
                      controller: contentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Content",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      reference.doc(documentId).update({
                        'title': titleController.text,
                        'content': contentController.text,
                        'dateEdited': dateTime,
                      }).whenComplete(() => Navigator.pop(context));
                    }

                    titleController.clear();
                    contentController.clear();
                  },
                  child: const Text('update'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog() {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("cloudnote");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 300.0, // Adjust the height as needed
            padding: const EdgeInsets.all(10.0), // Adjust content padding
            child: SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (title) {
                        if (title!.isEmpty) {
                          return "nothing to be saved";
                        } else {
                          return null;
                        }
                      },
                      controller: titleController,
                      decoration: const InputDecoration(
                          labelText: "Title",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 2))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (content) {
                        if (content!.isEmpty) {
                          return "nothing to be saved";
                        } else {
                          return null;
                        }
                      },
                      controller: contentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Content",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      reference.add({
                        'title': titleController.text,
                        'content': contentController.text,
                        'datecreated': dateTime,
                      }).whenComplete(() => Navigator.pop(context));
                    }

                    titleController.clear();
                    contentController.clear();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

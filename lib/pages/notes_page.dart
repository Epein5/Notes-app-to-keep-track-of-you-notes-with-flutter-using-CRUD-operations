import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:flutter_application_1/static/colours.dart';
import 'package:flutter_application_1/utils/db_helper.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final FocusNode _focusNode = FocusNode();

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DBhelper db = DBhelper();
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Colours.background,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colours.darkgrey,
        onPressed: () {
          setState(() {});
          DBhelper db = DBhelper();
          db.createNote(Notes(
              title: titlecontroller.text,
              description: descriptioncontroller.text));
          titlecontroller.text = '';
          descriptioncontroller.text = '';
          FocusScope.of(context).unfocus();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: db.getNotes(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Notes>> snapshot) {
                  DBhelper db = DBhelper();

                  if (snapshot.hasData) {
                    // print("aaa");
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      titlecontroller.text = snapshot
                                          .data![index].title
                                          .toString();
                                      descriptioncontroller.text = snapshot
                                          .data![index].description
                                          .toString();
                                      setState(() {});
                                      FocusScope.of(context)
                                          .requestFocus(_focusNode);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].title
                                                .toString()),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(snapshot
                                                .data![index].description
                                                .toString())
                                          ]),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        db.deleteNote(
                                            snapshot.data![index].id!);
                                        db.createNote(Notes(
                                            title: titlecontroller.text,
                                            description:
                                                descriptioncontroller.text));
                                        titlecontroller.text = '';
                                        descriptioncontroller.text = '';
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.edit)),
                                  InkWell(
                                      onTap: () {
                                        db.deleteNote(
                                            snapshot.data![index].id!);

                                        setState(() {});
                                      },
                                      child: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    const Center(
                      child: Text(
                        "Please Write SOmething",
                        style: TextStyle(
                          color: Colours.white,
                        ),
                      ),
                    );
                  }
                  return Text("ads");
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 80),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colours.white),
              child: Column(
                children: [
                  TextFormField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(hintText: '    Title'),
                    controller: titlecontroller,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: '    Description'),
                    controller: descriptioncontroller,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

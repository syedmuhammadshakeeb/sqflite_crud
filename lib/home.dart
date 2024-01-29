import 'package:flutter/material.dart';
import 'package:notes_app/db_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descripController = TextEditingController();
  final newtitleController = TextEditingController();
  final newdescripController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Material(
              elevation: 8,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.black12),
                child: Center(
                  child: ListTile(
                    leading: const Text(
                      'Notes App',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 215, 195, 81),
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Material(
                                          elevation: 5,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: TextFormField(
                                                controller: titleController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'title',
                                                  hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white60),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(30),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.black26,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: TextFormField(
                                                controller: descripController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'description',
                                                  hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white60),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 215, 195, 81),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await DBHelper.instance
                                                    .insertDB({
                                                  DBHelper.columnTitle:
                                                      titleController.text,
                                                  DBHelper.columnDescription:
                                                      descripController.text,
                                                });
                                                setState(() {
                                                  titleController.clear();
                                                  descripController.clear();
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 215, 195, 81),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  );
                                });
                          },
                          child: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 215, 195, 81),
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 215, 195, 81),
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: DBHelper.instance.queryDB(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Material(
                                elevation: 5,
                                child: Dismissible(
                                  background: Container(
                                    color: Colors.red[200],
                                    child: const Icon(Icons.delete),
                                  ),
                                  key: UniqueKey(),
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      DBHelper.instance.deleteDB(snapshot
                                          .data?[index][DBHelper.columnId]);

                                      snapshot.data!
                                          .remove(snapshot.data?[index]);
                                    });
                                  },
                                  child: ListTile(
                                    leading: Material(
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(50),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          color: Colors.black26,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.notes,
                                              size: 35,
                                              color: Color.fromARGB(
                                                  255, 215, 195, 81),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data?[index]
                                          [DBHelper.columnTitle],
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 215, 195, 81),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data?[index]
                                          [DBHelper.columnDescription],
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: Material(
                                      borderRadius: BorderRadius.circular(40),
                                      elevation: 5,
                                      color: Colors.black12,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actions: [
                                                    Column(
                                                      children: [
                                                        Material(
                                                          elevation: 10,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child: Container(
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: Colors
                                                                    .black26),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      10.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    newtitleController,
                                                                decoration: const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'title',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white12)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Material(
                                                          elevation: 10,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child: Container(
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: Colors
                                                                    .black26),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      10.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    newdescripController,
                                                                decoration: const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'description',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white12)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all(
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          215,
                                                                          195,
                                                                          81),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ))),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all(
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          215,
                                                                          195,
                                                                          81),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    await DBHelper
                                                                        .instance
                                                                        .updateDB({
                                                                      DBHelper
                                                                          .columnId: snapshot
                                                                              .data![index]
                                                                          [
                                                                          DBHelper
                                                                              .columnId],
                                                                      DBHelper.columnTitle:
                                                                          newtitleController
                                                                              .text,
                                                                      DBHelper.columnDescription:
                                                                          newdescripController
                                                                              .text
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      newtitleController
                                                                          .clear();
                                                                      newdescripController
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                                  },
                                                                  child: const Center(
                                                                      child: Text(
                                                                          'Update',
                                                                          style:
                                                                              TextStyle(color: Colors.black))))
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(
                                                    255, 215, 195, 81),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                          child: Icon(
                        Icons.add,
                        size: 50,
                      ));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:docscanner/listview_all_features/entry-deatil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListViewTask extends StatefulWidget {
  const ListViewTask({Key? key}) : super(key: key);

  @override
  State<ListViewTask> createState() => _ListViewTaskState();
}

class _ListViewTaskState extends State<ListViewTask> {
  @override
  void initState() {
    getList();
    super.initState();
  }

  //ADDED
  List colors = [
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.pinkAccent,
    Colors.lightBlueAccent
  ];

  List listData = [];

  getList() async {
    print(
        '----------------API INTEGRATION For List Is Started-----------------------------------------');

    final response = await http.get(
      Uri.parse('https://api.publicapis.org/entries'),
    );

    if (response.statusCode == 200) {
      debugPrint("Show Responce=${json.decode(response.body)}");
      setState(() {
        listData = json.decode(response.body)["entries"];
      });
    } else {
      debugPrint(
          '---------------------------Failed--------------------------------');
    }
  }

// this method sort the item.
  void sorting() {
    setState(() {
      listData.sort();
    });
  }

  bool like = true;
  bool unlike = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ListData"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              setState(() {
                getList();
              });
            },
          );
        },
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          padding: const EdgeInsets.all(20.5),
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      debugPrint("Liked-$index");
                    },
                    backgroundColor:colors[index % colors.length],
                    foregroundColor: Colors.white,
                    icon: Icons.thumb_up_sharp,
                    label: 'Like',
                  ),
                ],
              ),
              endActionPane:ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      debugPrint("Unlike-$index");
                    },
                    backgroundColor: colors[index % colors.length],
                    foregroundColor: Colors.white,
                    icon: Icons.thumb_down_sharp,
                    label: 'Like',
                  ),
                ],
              ) ,
              child: Container(
                padding: EdgeInsets.all(20),
                color: colors[index % colors.length],
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EntryDetail(
                              api: listData[index]["API"].toString(),
                              auth: listData[index]["Auth"].toString(),
                              category: listData[index]["Category"].toString(),
                              cors: listData[index]["Cors"].toString(),
                              description:
                                  listData[index]["Description"].toString(),
                              https: listData[index]["HTTPS"].toString(),
                              link: listData[index]["Link"].toString(),
                            )));
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Text("${listData[index]["API"]}",
                            style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("${listData[index]["Description"]}",
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("${listData[index]["Link"]}",
                          style: const TextStyle(color: Colors.blueAccent)),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
///using listview.seprated
// ListView.separated(
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               height: 10,
//             );
//           },
//           padding: const EdgeInsets.all(20.5),
//           shrinkWrap: true,
//           itemCount: listData.length,
//           itemBuilder: (context, index) {
//             return Slidable(
//               startActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 children: [
//                   SlidableAction(
//                     onPressed: (context) {
//                       debugPrint("Liked-$index");
//                     },
//                     backgroundColor:colors[index % colors.length],
//                     foregroundColor: Colors.white,
//                     icon: Icons.thumb_up_sharp,
//                     label: 'Like',
//                   ),
//                 ],
//               ),
//               endActionPane:ActionPane(
//                 motion: const ScrollMotion(),
//                 children: [
//                   SlidableAction(
//                     onPressed: (context) {
//                       debugPrint("Unlike-$index");
//                     },
//                     backgroundColor: colors[index % colors.length],
//                     foregroundColor: Colors.white,
//                     icon: Icons.thumb_down_sharp,
//                     label: 'Like',
//                   ),
//                 ],
//               ) ,
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 color: colors[index % colors.length],
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (_) => EntryDetail(
//                               api: listData[index]["API"].toString(),
//                               auth: listData[index]["Auth"].toString(),
//                               category: listData[index]["Category"].toString(),
//                               cors: listData[index]["Cors"].toString(),
//                               description:
//                                   listData[index]["Description"].toString(),
//                               https: listData[index]["HTTPS"].toString(),
//                               link: listData[index]["Link"].toString(),
//                             )));
//                   },
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Text("${listData[index]["API"]}",
//                             style: const TextStyle(color: Colors.white)),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text("${listData[index]["Description"]}",
//                           style: const TextStyle(color: Colors.white)),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text("${listData[index]["Link"]}",
//                           style: const TextStyle(color: Colors.blueAccent)),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         )
///code for rounded stack design
// Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 4, 4, 0),
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadiusDirectional.all(
//                               Radius.circular(20),
//                             ),
//                             color: Colors.grey,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text("${listData[index]["Category"]}",
//                                 style: const TextStyle(color: Colors.pink)),
//                           ),
//                         ),
//                       ),
///by using listtile
// return ListTile(
//
//   onTap:() {
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => EntryDetail(
//           api: listData[index]["API"].toString(),
//           auth: listData[index]["Auth"].toString(),
//           category:
//           listData[index]["Category"].toString(),
//           cors: listData[index]["Cors"].toString(),
//           description:
//           listData[index]["Description"].toString(),
//           https: listData[index]["HTTPS"].toString(),
//           link: listData[index]["Link"].toString(),
//         )));
//   } ,
//   tileColor: colors[index % colors.length],
//   title: Center(
//     child: Text("${listData[index]["API"]}",
//         style: const TextStyle(color: Colors.white)),
//   ),
//   subtitle: Column(
//     children: [
//       const SizedBox(
//         height: 5,
//       ),
//       Text("${listData[index]["Description"]}",
//           style: const TextStyle(color: Colors.white)),
//       const SizedBox(
//         height: 5,
//       ),
//       Text("${listData[index]["Link"]}",
//           style: const TextStyle(
//               color: Colors.blueAccent)),
//       const SizedBox(
//         height: 5,
//       ),
//     ],
//   ),
// );

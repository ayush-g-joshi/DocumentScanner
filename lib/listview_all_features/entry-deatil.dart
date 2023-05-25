import 'package:flutter/material.dart';

class EntryDetail extends StatefulWidget {
  var api;
  var description;
  var auth;
  var https;
  var cors;
  var link;
  var category;
   EntryDetail({Key? key,this.api,this.description,this.auth,this.https,this.cors,this.link,this.category}) : super(key: key);

  @override
  State<EntryDetail> createState() => _EntryDetailState();
}

class _EntryDetailState extends State<EntryDetail> {
  @override

  void initState() {
    debugPrint("Data Entries are as follows---------");
    debugPrint(widget.api);
    debugPrint(widget.description);
    debugPrint(widget.auth);
    debugPrint(widget.https);
    debugPrint(widget.cors);
    debugPrint(widget.link);
    debugPrint(widget.category);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("${widget.api}"),centerTitle: true),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            // {"API":"AdoptAPet","Description":"Resource to help get pets adopted","Auth":"apiKey","HTTPS":true,
            // "Cors":"yes","Link":"https://www.adoptapet.com/public/apis/pet_list.html","Category":"Animals"}
Text("Description-${widget.description}"),
            SizedBox(height: 10,),
            Text("Auth-${widget.auth}"),
                SizedBox(height: 10,),
            Text("HTTPS-${widget.https}"),
                SizedBox(height: 10,),
            Text("Cors-${widget.cors}"),
                SizedBox(height: 10,),
            Text("Category-${widget.category}"),
                SizedBox(height: 10,),
            Text("${widget.link}",style: TextStyle(color: Colors.blue)),

          ]),
        ),
      ),
    ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ChoosePdfFile extends StatefulWidget {
  var pdf_address;

  ChoosePdfFile({Key? key, this.pdf_address}) : super(key: key);

  @override
  State<ChoosePdfFile> createState() => _ChoosePdfFileState();
}

class _ChoosePdfFileState extends State<ChoosePdfFile> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  var total_page_count;
  var seelected_page_count;
  @override
  void initState() {
    debugPrint("Address of your selected file is-${widget.pdf_address}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF033860),
        centerTitle: true,
        title: Text("Documents"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 109,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Stack(
              children: [
                Container(
                  height: 495,
                  width: double.infinity,
                  child: SfPdfViewer.file(
                    onPageChanged: (details) {
                      setState(() {
                        total_page_count=_pdfViewerController.pageCount;
                        seelected_page_count=_pdfViewerController.pageNumber;
                      });
                    },
                    enableTextSelection: false,
                    controller: _pdfViewerController,
                    onDocumentLoaded: (details) {
                      setState(() {
                        total_page_count=_pdfViewerController.pageCount;
                        seelected_page_count=_pdfViewerController.pageNumber;
                      });

                    },
                    enableDocumentLinkAnnotation: true,
                    canShowScrollStatus: false,
                    scrollDirection: PdfScrollDirection.horizontal,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    //for heading of number
                    canShowScrollHead: false,

                    File("${widget.pdf_address}"),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                      )),
                ),
                seelected_page_count!=null && total_page_count!=null ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(20),
                        ),
                        color: Colors.black38,
                      ),
                      width: 50,
                      height: 30,
                      child: Center(
                          child: Text(
                              "${seelected_page_count} of ${total_page_count} ",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ):Container()
              ],
            ),
          ),

          // :Container(color: Colors.amber,height: 50,)
        ]),
      ),
    );
  }
}
import 'dart:io';
import 'package:http/http.dart' as http;
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

  updateDocuments() async {
    debugPrint("updateDocuments api is called");
    Map<String, String> headers = {
      'authentication_token':
          "7b3b555709328c4f9793781b187f7188d38660e5db62567880119f9af88a6842d3d053e8b529e0c6926effa29615f8cf5e9c6b10e313eeb9967871eb87aec16e"
    };

    var request = http.MultipartRequest('POST',
        Uri.parse('http://192.241.248.136:3200/compliance/get_compliance'));
    request.headers.addAll(headers);

    request.fields.addAll({


      //Parameters for For 1)General Document : 2)for KYC Document : -
      'client_id': "351329",
      'agent_id': "30082",
      'company_id': "265",
      'user_id': "11683",
      "title": "sunny",
      "comment": "2 General test document comment",
      "document_type": "372",
      "notify_admin": "1",

      //Parameters for For 3)for ID Condition : -
      // "client_id":"351335",
      // "agent_id":"30082",
      // "company_id":"265",
      // "user_id":"11683",
      // "title":"2 aws title",
      // "comment":"2 aws test document comment",
      // "document_type":"374",
      // "notify_admin":"1",
      // "trn":"123456789",
      // "id_type":"Passport",
      // "id_number":"9999",
      // "expiry_date":"2023-03-08"

      //Parameters for For 4)for Proof of Address: -
      // "client_id":"351325",
      // "agent_id":"30082",
      // "company_id":"265",
      // "user_id":"11683",
      // "title":"3 aws title",
      // "comment":"3 aws test document comment",
      // "document_type":"373",
      // "notify_admin":"1",
      // "mailing_address":"street99",
      // "town":"112",
      // "parish":"1",
      // "country":"84",
    });

    if (widget.pdf_address != null) {
      debugPrint(widget.pdf_address);

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        "${widget.pdf_address}",
      ));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint("${request.fields}");
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF033860),
        centerTitle: true,
        title: const Text("Documents"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                updateDocuments();
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
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
                        total_page_count = _pdfViewerController.pageCount;
                        seelected_page_count = _pdfViewerController.pageNumber;
                      });
                    },
                    enableTextSelection: false,
                    controller: _pdfViewerController,
                    onDocumentLoaded: (details) {
                      setState(() {
                        total_page_count = _pdfViewerController.pageCount;
                        seelected_page_count = _pdfViewerController.pageNumber;
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
                      icon: const Icon(
                        Icons.cancel_rounded,
                      )),
                ),
                seelected_page_count != null && total_page_count != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: const BoxDecoration(
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
                                    style:
                                        const TextStyle(color: Colors.white))),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),

          // :Container(color: Colors.amber,height: 50,)
        ]),
      ),
    );
  }
}

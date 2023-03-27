import 'dart:io';
import 'package:docscanner/image-cropper.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'choose-pdf-file.dart';


class RoughfScreen extends StatefulWidget {
  const RoughfScreen({Key? key}) : super(key: key);

  @override
  State<RoughfScreen> createState() => _RoughfScreenState();
}

class _RoughfScreenState extends State<RoughfScreen> {

  var pdfpath;

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf','docx'],

    );

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
    pdfpath = result.files.first.path;
    result.files.first.path!=null?
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ChoosePdfFile(pdf_address: result.files.first.path,))):debugPrint("PDF File Is Not Selected");
  }


  @override
  void initState() {

    super.initState();
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
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: const [


        ]),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadiusDirectional.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  height: 128,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) => DemoImagePicker()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.document_scanner),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Scan Document")
                            ],
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            _pickFile();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.file_copy_outlined,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Choose File")
                            ],
                          ),
                        ),
                      ]),
                ),
                Container(height: 6, color: Colors.transparent),
                Container(
                  width: double.infinity,
                  height: 49,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff113162)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
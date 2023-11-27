import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';

import '../../model.dart';

class UploadPDF extends StatefulWidget {
  const UploadPDF({Key? key}) : super(key: key);

  @override
  _UploadPDFState createState() => _UploadPDFState();
}

class _UploadPDFState extends State<UploadPDF> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _pickedFile;
  String _fileName = '';
  bool _isUploading = false;
  String title = '';
  final TextEditingController titlecontroller = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        allowMultiple: false);

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  Future<String> _getPDFUrl(String id) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('attcsv').doc(id).get();
    return documentSnapshot.get('pdfURL');
  }

  Future<void> _uploadFile() async {
    if (_pickedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      String uploaderName = '$namee';

      Timestamp uploadedAt = Timestamp.now();

      String fileName = 'attcsv/$depp/$_fileName';
      await _storage.ref(fileName).putFile(_pickedFile!);
      String pdfURL = await _storage.ref(fileName).getDownloadURL();

      PDFModel pdf = PDFModel(
        id: '$emaill',
        pdfURL: pdfURL,
        uploaderName: '$namee',
        uploadedAt: uploadedAt,
        dep: '$depp',
        title: titlecontroller.text,
        filenamee: fileName,
      );

      await firebaseFirestore
          .collection('attcsv')
          .doc(pdf.title)
          .set(pdf.toJson());
      String pdfId = pdf.id!;
      String pdfUrl = await _getPDFUrl(pdfId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File upload done')),
      );
    }

    setState(() {
      _isUploading = false;
      _pickedFile = null;
      _fileName = '';
    });
  }

  User? user;
  UserModel loggedInUser = UserModel();
  String rooll = '';
  var emaill;
  String id = '';
  String namee = '';
  String depp = '';
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        CircularProgressIndicator();
        setState(() {
          emaill = loggedInUser.email.toString();
          rooll = loggedInUser.rool.toString();
          id = loggedInUser.uid.toString();
          namee = loggedInUser.name.toString();
          depp = loggedInUser.dep.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('Upload Attendance'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                   
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          )
                    ],
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 3)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    maxLines: 14,
                    controller: titlecontroller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.keyboard_alt_outlined,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ),
                      enabled: true,
                      labelText: "Give Title ",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.length == 0) {
                        return "Title cannot be empty";
                      }
                    },
                    onChanged: (value) {},
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ),
            if (_fileName != null) Column(children: [Text(_fileName)]),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: Icon(Icons.attach_file),
              label: Text('Pick csv Files'),
            ),
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _isUploading ? null : _uploadFile,
                    icon: Icon(Icons.cloud_upload),
                    label: Text('Upload Files'),
                  ),
          ],
        ),
      ),
    );
  }
}

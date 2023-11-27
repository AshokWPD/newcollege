import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';

import '../model.dart';

class clgup extends StatefulWidget {
  const clgup({Key? key}) : super(key: key);

  @override
  _clgupState createState() => _clgupState();
}

class _clgupState extends State<clgup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _pickedFile;
  String _fileName = '';
  bool _isUploading = false;
  String title = '';
  final TextEditingController titlecontroller = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
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
        await FirebaseFirestore.instance.collection('clgnotice').doc(id).get();
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
      String uploaderName = namee;

      Timestamp uploadedAt = Timestamp.now();

      String fileName = 'clgnotice/$depp/$_fileName';
      await _storage.ref(fileName).putFile(_pickedFile!);
      String pdfURL = await _storage.ref(fileName).getDownloadURL();

      PDFModel pdf = PDFModel(
        id: '$emaill',
        pdfURL: pdfURL,
        uploaderName: namee,
        uploadedAt: uploadedAt,
        dep: depp,
        title: titlecontroller.text,
        filenamee: fileName,
      );

      await firebaseFirestore
          .collection('clgnotice')
          .doc(pdf.title)
          .set(pdf.toJson());

      // pdf.id = docRef.id;
      String pdfId = pdf.id!;
      String pdfUrl = await _getPDFUrl(pdfId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File upload done')),
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
  String regnumm = '';
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
        loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        const CircularProgressIndicator();
        setState(() {
          emaill = loggedInUser.email.toString();
          rooll = loggedInUser.rool.toString();
          id = loggedInUser.uid.toString();
          namee = loggedInUser.name.toString();
          depp = loggedInUser.dep.toString();
          regnumm = loggedInUser.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text('Upload Notice'),
        //   titleTextStyle: const TextStyle(
        //       color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 23),
        //   backgroundColor: Colors.white,
        // ),
        body: Center(
          child: Center(
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
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 0, 0),
                          Color.fromARGB(255, 25, 0, 255),
                        ]),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 2,
                              offset: Offset(8.0, 8.0))
                        ],
                        border: Border.all(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            width: 3)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 14,
                        controller: titlecontroller,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.keyboard_alt_outlined,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 30,
                          ),
                          enabled: true,
                          labelText: "Give Title ",
                          labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
                if (_fileName != null) Column(children: [Text(_fileName)]),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Pick PDF Files'),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _isUploading ? null : _uploadFile,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Upload Files'),
                ),
              ],
            ),
          ),
        ));
  }
}

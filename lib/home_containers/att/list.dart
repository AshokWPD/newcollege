import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

import '../../model.dart';

class PDFPage extends StatefulWidget {
  const PDFPage({Key? key}) : super(key: key);

  @override
  _PDFPageState createState() => _PDFPageState();
  static String routename = 'PDFPage';
}

class _PDFPageState extends State<PDFPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  bool _isupload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('excel Page'),
      // ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('attcsv').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return Text('Loading...');
            }

            List<PDFModel> pdfs = snapshot.data!.docs
                .map((doc) =>
                    PDFModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            List<PDFModel> filteredPdfs =
                pdfs.where((pdf) => pdf.dep.toString() == depp).toList();

            if (filteredPdfs.isEmpty) {
              return Center(child: Text('There is no CSV files'));
            }

            return ListView.builder(
              itemCount: filteredPdfs.length,
              itemBuilder: (context, index) {
                PDFModel pdf = filteredPdfs[index];
                String pdfurl = pdf.pdfURL.toString();

                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 5, 226, 255),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(6.0, 6.0),
                        )
                      ],
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 3,
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.note_outlined,
                        color: Colors.black,
                        size: 38,
                      ),
                      title: Text(
                        pdf.title.toString(),
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Uploader : ' + pdf.uploaderName.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isupload
                              ? CircularProgressIndicator()
                              : IconButton(
                                  icon: Icon(
                                    Icons.upload,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                  onPressed: () async {
                                    registerAttendeesFromCsv(pdfurl);
                                  },
                                ),
                          if (rooll != "Student")
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Attendance ?'),
                                        content: Text(
                                            'Are you sure you want to delete this  Attendance?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Delete the document from the Firestore collection
                                              // _firestore
                                              //     .collection('clgnotice')
                                              //     .doc(pdf.title)
                                              //     .delete();
                                              if (rooll != "Student")
                                                await _deletePDF(
                                                    pdf.title.toString(),
                                                    pdf.filenamee.toString());

                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Delete'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _deletePDF(String pdfId, String filenam) async {
    try {
      // Delete PDF from Firestore
      await _firestore.collection('attcsv').doc(pdfId).delete();

      // Delete PDF from Firebase Storage
      await _storage.ref(filenam).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete ')),
      );
    }
  }

  Future<void> registerAttendeesFromCsv(String csvUrl) async {
    final CollectionReference attendees =
        FirebaseFirestore.instance.collection("attendees");

    setState(() {
      _isupload = true;
    });

    // Download the CSV file contents using dart:io
    final uri = Uri.parse(csvUrl);
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();
    final csvData = await response.transform(utf8.decoder).join();

    // Convert the CSV data to a 2D list of dynamic values
    List<List<dynamic>> rows = CsvToListConverter().convert(csvData);

    // Process the rows as needed
    // Assuming the CSV data has headers: regnum,name,dep,Ttclass,Atclass,perclass
    for (int i = 1; i < rows.length; i++) {
      var attendeeDetails = {
        'dep': rows[i][2].toString(),
        'name': rows[i][1].toString(),
        'regnum': rows[i][0].toString(),
        'Ttclass': rows[i][3].toString(),
        'Atclass': rows[i][4].toString(),
        'perclass': rows[i][5].toString(),
      };

      // Add the attendee to Firebase
      Attendmodel attendee = Attendmodel.fromMap(attendeeDetails);
      var attendeeDoc = attendees.doc(rows[i][0].toString());
      await attendeeDoc.set(attendee.toDocument()).then((value) {
        // Document added successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File uploaded successfully')),
        );
      }).catchError((error) {
        // Error adding document
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File upload failed')),
        );
      });
    }

    setState(() {
      _isupload = false;
    });
  }
}

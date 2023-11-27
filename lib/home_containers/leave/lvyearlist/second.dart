import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../model.dart';
import '../leavelist/viewbox.dart';

class secondlvlist extends StatefulWidget {
  const secondlvlist({super.key});

  @override
  State<secondlvlist> createState() => _secondlvlistState();
}

class _secondlvlistState extends State<secondlvlist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
        loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        const CircularProgressIndicator();
        setState(() {
          emaill = loggedInUser.email.toString();
          rooll = loggedInUser.rool.toString();
          id = loggedInUser.uid.toString();
          namee = loggedInUser.name.toString();
          depp = loggedInUser.dep.toString();
          // depp = loggedInUser.dep.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Leave permission list'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 23),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('leave').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const Text('Loading...');
            }

            List<leavemodel> pdfs = snapshot.data!.docs
                .map((doc) =>
                    leavemodel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            List<leavemodel> filteredPdfs = pdfs
                .where((pdf) =>
                    // pdf.dep.toString() == depp &&
                    pdf.year.toString() == "MSc Computer Science 2-Year")
                .toList();

            if (filteredPdfs.isEmpty) {
              return const Center(child: Text('There is no Leave Request'));
            }

            return ListView.builder(
              itemCount: filteredPdfs.length,
              itemBuilder: (context, index) {
                leavemodel pdf = filteredPdfs[index];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: pdf.request.toString() == 'Accepted'
                          ? Colors.green
                          : pdf.request.toString() == 'Canceled'
                              ? Colors.red
                              : Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(6.0, 6.0),
                        )
                      ],
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                        pdf.name.toString(),
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'year : ${pdf.year}  ${pdf.dep}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.visibility_rounded,
                              color: Colors.black,
                              size: 28,
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => viewbox(
                                    stuReason: pdf.reason.toString(),
                                    stuRegnum: pdf.regnum.toString(),
                                    stuname: pdf.name.toString(),
                                    stuyear: pdf.year.toString(),
                                    sturequest: pdf.request.toString(),
                                    stuaccepter: pdf.accepter.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delite Leave Request?'),
                                      content: const Text(
                                          'Are you sure you want to delete this leave request?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Delete the document from the Firestore collection
                                            _firestore
                                                .collection('leave')
                                                .doc(pdf.Id)
                                                .delete();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Delete'),
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.black,
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model.dart';
import '../../util/background.dart';

class addstu extends StatefulWidget {
  const addstu({super.key});

  static String routename = 'addstu';

  @override
  State<addstu> createState() => _addstuState();
}

class _addstuState extends State<addstu> {
  _addstuState();

  final TextEditingController confirmpassController = TextEditingController();

  var dep = "MSc Computer Science 1-Year";
// depart ment
  var depOptions = [
    'MSc Computer Science 1-Year',
    'MSc Computer Science 2-Year',
    'Data science',
   
  ];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController regnumcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  var role = "Student";
  // File? file;

  //role
  var roleOptions = ['Student', 'Professor', 'Admin'];

  bool showProgress = false;
  bool visible = false;
  bool _isupload = false;

  final _auth = FirebaseAuth.instance;
  var _currentDepSelected = "MSc Computer Science 1-Year";
  var _currentRoleSelected = "Student";
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2 = true;

// back end

  void signUp(
    String email,
    String password,
    String role,
    String dep,
    String name,
    String regnum,
  ) async {
    setState(() {
      _isupload = true;
    });

    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(email, role, dep, name, password, regnum)
              })
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String rool, String dep, String name,
      String password, String regnum) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.rool = rool;
    userModel.dep = dep;
    userModel.name = name;
    userModel.regnum = regnum;
    userModel.password = password;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    setState(() {
      _isupload = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User created successfully')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Background(
            child: Form(
              key: _formkey,
              child: ListView(children: [
                SizedBox(
                  height: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Create User",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2661FA),
                            fontSize: 36),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: namecontroller,
                        decoration:
                            InputDecoration(enabled: true, labelText: "Name"),
                        validator: (value) {
                          if (value!.length == 0) {
                            return "Name cannot be empty";
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.name,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: regnumcontroller,
                        decoration: InputDecoration(
                            enabled: true, labelText: "Register Number"),
                        validator: (value) {
                          if (value!.length == 0) {
                            return "Enter Register Number ";
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (value) {
                          if (value!.length == 0) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            labelText: "Password"),
                        obscureText: _isObscure,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("please enter valid password min. 6 character");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: confirmpassController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            labelText: "Confirm Password"),
                        obscureText: _isObscure,
                        validator: (value) {
                          if (confirmpassController.text !=
                              passwordController.text) {
                            return "Password did not match";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    // role

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: DropdownButton<String>(
                        hint: Text(
                          'Role',
                          selectionColor: Colors.black,
                        ),
                        dropdownColor: Colors.white,
                        isDense: true,
                        isExpanded: false,
                        iconEnabledColor: Colors.black,
                        focusColor: Colors.blue,
                        items: roleOptions.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            _currentRoleSelected = newValueSelected!;
                            role = newValueSelected;
                          });
                        },
                        value: _currentRoleSelected,
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),
                    role=='Student'?

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: DropdownButton<String>(
                        hint: Text(
                          'Department',
                          selectionColor: Colors.black,
                        ),
                        dropdownColor: Colors.white,
                        isDense: true,
                        isExpanded: false,
                        iconEnabledColor: Colors.black,
                        focusColor: Colors.blue,
                        items: depOptions.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValueSelected) {
                          setState(() {
                            _currentDepSelected = newValueSelected!;
                            dep = newValueSelected;
                          });
                        },
                        value: _currentDepSelected,
                      ),
                    ):SizedBox(),

                    SizedBox(height: size.height * 0.05),
                    _isupload
                        ? CircularProgressIndicator()
                        : Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                // if (showProgress = true) {
                                //   Center(child: CircularProgressIndicator());
                                // }
                                signUp(
                                    emailController.text,
                                    passwordController.text,
                                    role,
                                    dep,
                                    namecontroller.text,
                                    regnumcontroller.text);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: size.width * 0.5,
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    gradient: new LinearGradient(colors: [
                                      Color.fromARGB(255, 255, 136, 34),
                                      Color.fromARGB(255, 255, 177, 41)
                                    ])),
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  "Create",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                              ),
                            ),
                          ),

                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    //   child: GestureDetector(
                    //     onTap: () => {
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
                    //     },
                    //     child: Text(
                    //       "Already Have an Account? Sign in",
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color(0xFF2661FA)
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}

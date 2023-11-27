
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'first.dart';
import 'forth.dart';
import 'second.dart';
import 'third.dart';

class mainlist extends StatelessWidget {
  const mainlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Leave permissions',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 21,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => firstlvlist(),
                ),
              ),
              child: Container(
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
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'MSc Computer Science 1-Year',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3.5
                          ..style = PaintingStyle.fill
                          ..color = Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => secondlvlist(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                   color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          // offset: Offset(8.0, 8.0)
                          )
                    ],
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 3)),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'MSc Computer Science 2-Year',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3.5
                          ..style = PaintingStyle.fill
                          ..color = Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => thirdlvlist(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          // offset: Offset(8.0, 8.0)
                          )
                    ],
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 3)),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'Data science',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3.5
                          ..style = PaintingStyle.fill
                          ..color = Colors.black),
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20),
          //   child: InkWell(
          //     onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => forthlvlist(),
          //       ),
          //     ),
          //     child: Container(
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //           gradient: LinearGradient(colors: [
          //             Colors.red,
          //             Color.fromARGB(255, 2, 19, 253),
          //           ]),
          //           boxShadow: const [
          //             BoxShadow(
          //                 color: Colors.blue,
          //                 blurRadius: 2,
          //                 offset: Offset(8.0, 8.0))
          //           ],
          //           border: Border.all(
          //               color: Color.fromARGB(255, 248, 248, 248), width: 3)),
          //       height: 100,
          //       width: MediaQuery.of(context).size.width,
          //       child: Center(
          //         child: Text(
          //           '4-year Request',
          //           style: TextStyle(
          //               fontSize: 30,
          //               fontWeight: FontWeight.bold,
          //               foreground: Paint()
          //                 ..style = PaintingStyle.stroke
          //                 ..strokeWidth = 3.5
          //                 ..style = PaintingStyle.fill
          //                 ..color = Colors.black),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

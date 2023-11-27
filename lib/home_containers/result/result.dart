import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class resultview extends StatefulWidget {
  static String routeName = 'resultview';

  const resultview({super.key});

  @override
  State<resultview> createState() => _resultviewState();
}

class _resultviewState extends State<resultview> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/image/logoo.png',
              width: 250,
              height: 250,
            ),
            SizedBox(height: 20,),
            const Text(
              'Click here 👇',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () => _launchURL(ResultURL),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                       
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              // offset: Offset(3.0, 3.0))
                          )
                        ],
                        border: Border.all(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            width: 3)),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Central University of TamilNadu',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize:20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

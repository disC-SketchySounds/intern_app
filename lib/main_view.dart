import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sketchy_sounds_intern_app/api_service.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          Image.asset(
            'assets/logo.png',
            height: 200,
          ),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  "Klicke hier, um die aktuellste Partitur zu sehen...",
                  style: TextStyle(fontSize: 32)
              )
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              "Aktuellste Partitur",
                              style: TextStyle(fontSize: 32, color: Colors.white)),
                          content: FutureBuilder<String>(
                            future: APIService.instance.getLastSketch(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text(
                                    "${snapshot.error}",
                                    style: const TextStyle(fontSize: 24, color: Colors.white)
                                );
                              } else {
                                return Image.file(File(snapshot.data!));
                              }
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                  "Schließen",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.music_note, size: 32),
                      SizedBox(width: 10),
                      Text(
                        "Aktuellste Partitur laden",
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  ),
                ),
              )),
        Spacer(),
        Align(
          alignment: Alignment.bottomRight,
            child: IconButton(onPressed: (() {
              Navigator.pushNamed(context, '/api_menu');
            }), icon: Icon(Icons.settings, color: Colors.white,))
        )
        ]),
      ),
    );
  }
}

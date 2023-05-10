import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commy/constants.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:commy/view/pages/setting.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:video_player/video_player.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  TextEditingController textcontroller = TextEditingController();
  bool _isListening = false;
  String _text = 'press the microphone to start speaking';
  double _confidence = 1.0;
  late VideoPlayerController controller;
  String? urlcontroller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network("");

    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.deafultcolor,
        title: Text(
          'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
          style: const TextStyle(color: Constants.iconcolor),
        ),
      ),
      backgroundColor: Constants.background,
      bottomNavigationBar: BottomAppBar(
        color: Constants.deafultcolor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Constants.iconcolor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const Setting();
                  },
                ));
              },
              icon: const Icon(
                Icons.settings,
                color: Constants.iconcolor,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Constants.iconcolor,
        endRadius: 36.0,
        duration: const Duration(milliseconds: 5000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          backgroundColor: Constants.deafultcolor,
          child: Icon(_isListening ? Icons.mic : Icons.mic_off,
              color: Constants.iconcolor),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: InkWell(
                onTap: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: controller == VideoPlayerController.network("")
                    ? const CircularProgressIndicator(
                        color: Constants.deafultcolor,
                      )
                    : AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                child: Text(textcontroller.text,
                    style: const TextStyle(
                      fontSize: 32.0,
                      color: Constants.textcolor,
                      fontWeight: FontWeight.w400,
                    ))

            ),

            SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextFormField(
                  controller: textcontroller,
                )),
            Container(
              color: Colors.transparent,
              width: 300,
              height: 100,
              child: TextButton(
                  onPressed: () {
                    // Get data from docs and convert map to List

                    getDatafromFirebase();
                    print(" text controller ${textcontroller.text}");
                  },
                  child: const Text("Click here to see video")),
            ),
          ],
        ),
      ),
    );
  }

  Future getDatafromFirebase() async {
    await FirebaseFirestore.instance
        .collection('words')
        .doc("${textcontroller.text}")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      urlcontroller = documentSnapshot.data().toString();
      urlcontroller = urlcontroller?.substring(7, urlcontroller!.length - 1);
      print(urlcontroller);
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        controller = VideoPlayerController.network(urlcontroller!);
        controller.addListener(() {
          setState(() {});
        });
        controller.setLooping(true);
        controller.initialize().then((_) => setState(() {}));
        controller.play();
      } else {
        print('Document does not exist on the database');
      }
    });
  }


  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            textcontroller = val.recognizedWords as TextEditingController;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

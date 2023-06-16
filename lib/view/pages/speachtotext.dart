import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commy/constants.dart';
import 'package:commy/viewmodel/bloc/speech_cubit.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:commy/view/pages/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:video_player/video_player.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'press the microphone to start speaking';
  double _confidence = 1.0;

  int _currentVideoIndex = 0;
  late VideoPlayerController _controller;
  List<String> _urls = [];
  final _data = ["welcome", "to", "your", "work"];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("");

    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechCubit(),
      child: BlocConsumer<SpeechCubit, SpeechState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SpeechCubit myspeechcubit = SpeechCubit.get(context);
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: AvatarGlow(
              animate: _isListening,
              glowColor: Constants.iconcolor,
              endRadius: 36.0,
              duration: const Duration(milliseconds: 5000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                //onPressed: () => myspeechcubit.speechtotext(),
                onPressed: () async {
                  if (!_isListening) {
                    bool available = await _speech.initialize(
                      onStatus: (val) => print('onStatus: $val'),
                      onError: (val) => print('onError: $val'),
                    );
                    if (available) {
                      setState(() => _isListening = true);
                      _speech.listen(
                        onResult: (val) => setState(() {
                          _text = val.recognizedWords;
                          if (val.hasConfidenceRating && val.confidence > 0) {
                            _confidence = val.confidence;
                          }
                        }),
                      );
                    }
                  } else {
                    setState(() => _isListening = false);
                    _speech.stop();
                    myspeechcubit.sentance=_text;
                    myspeechcubit.speechtotext();
                  }

                },
                backgroundColor: Constants.deafultcolor,
                child: Icon(_isListening ? Icons.mic : Icons.mic_off,
                    color: Constants.iconcolor),
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(_text,
                        style: const TextStyle(
                          fontSize: 32.0,
                          color: Constants.textcolor,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: _controller == VideoPlayerController.network("")
                          ? CircularProgressIndicator()
                          : AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: Center(child: VideoPlayer(_controller)),
                            ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Constants.deafultcolor),
                    child: TextButton(
                        onPressed: () {
                          // Get data from docs and convert map to List
                          _urls.clear();
                          getDatafromFirebase();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Click here to see video",
                            style: TextStyle(color: Constants.iconcolor),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
            _text = val.recognizedWords;
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

  void getDatafromFirebase() async {
    _urls.clear();

    for (int i = 0; i < _data.length; i++) {
      DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('words').doc(_data[i]);

      DocumentSnapshot<Map<String, dynamic>> snapshot = await documentRef.get();

      if (snapshot.exists) {
        String value = snapshot.get("link");
        _urls.add(value);
      } else {
        _urls.add("not found");
        print("Document not available");
      }

      print(_urls);
    }

    setState(() {
      _currentVideoIndex = 0;
      _controller.dispose();
      _controller = VideoPlayerController.network(_urls[_currentVideoIndex]);

      _controller.initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

      _controller.addListener(_videoPlayerListener);
    });
  }

  void _videoPlayerListener() {
    if (_controller.value.position >= _controller.value.duration) {
      setState(() {
        if (_currentVideoIndex < _urls.length - 1) {
          _currentVideoIndex++;
          _controller.dispose();
          _controller =
              VideoPlayerController.network(_urls[_currentVideoIndex]);

          _controller.initialize().then((_) {
            setState(() {
              _controller.play();
            });
          });

          _controller.addListener(_videoPlayerListener);
        } else {
          print("Last video reached");
          // Last video reached, do something (e.g., navigate to another screen)
        }
      });
    }
  }

  // void getDatafromFirebase() async {
  //   for (int i = 0; i < _data.length; i++) {
  //     DocumentReference<Map<String, dynamic>> documentRef =
  //         //link:,https:
  //         FirebaseFirestore.instance
  //             .collection('words') // Replace with your collection name
  //             .doc(_data[i]); // Replace with your document ID
  //
  //     DocumentSnapshot<Map<String, dynamic>> snapshot = await documentRef.get();
  //     //link:,https:
  //
  //     if (snapshot.exists) {
  //       // Access the document data
  //       String value = snapshot.get("link");
  //       //https
  //       _urls.add(value);
  //     } else {
  //       _urls.add("not found");
  //       print("Document not available");
  //     }
  //
  //     print(_urls);
  //   }
  //   Timer(Duration(seconds: 3), () {
  //     _controller = VideoPlayerController.network(_urls[_currentVideoIndex])
  //       ..initialize().then((_) {
  //         setState(() {
  //           _controller.play();
  //         });
  //       });
  //
  //     _controller.addListener(_videoPlayerListener);
  //   });
  //
  //   print("$_urls \n");
  // }

  // void _videoPlayerListener() {
  //   if (_controller.value.position >= _controller.value.duration) {
  //     setState(() {
  //       if (_currentVideoIndex < _urls.length - 1) {
  //         _currentVideoIndex++;
  //         _controller = VideoPlayerController.network(_urls[_currentVideoIndex])
  //           ..initialize().then((_) {
  //             setState(() {
  //               _controller.play();
  //             });
  //           });
  //         _controller.addListener(_videoPlayerListener);
  //       } else {
  //         print("Last video reached");
  //         // Last video reached, do something (e.g., navigate to another screen)
  //       }
  //     });
  //   }
  // }
}

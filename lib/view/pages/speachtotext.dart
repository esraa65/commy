import 'package:commy/constants.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:commy/view/pages/setting.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'press the microphone to start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.deafultcolor,
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',style: TextStyle(color: Constants.iconcolor),),
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
              icon: Icon(
                Icons.home,
                color: Constants.iconcolor,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Setting();
                    },
                  ));
                },
                icon: Icon(
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
        child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: Text(_text,
                style: TextStyle(
                  fontSize: 32.0,
                  color: Constants.textcolor,
                  fontWeight: FontWeight.w400,
                ))

        ),
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
          onResult: (val) =>
              setState(() {
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
}
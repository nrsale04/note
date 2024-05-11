import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech extends StatefulWidget {
  const Speech({super.key});

  @override
  State<Speech> createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  var textSpeech = "CLICK ON MIC TO RECORD";
  SpeechToText speechToText = SpeechToText();
  var isListening = false;

  void checkMic() async {
    bool micAvailable = await speechToText.initialize();

    if (micAvailable) {
      print("MicroPhone Available");
    } else {
      print("User Denied th use of speech micro");
    }
  }

  @override
  void initState() {
    super.initState();
    checkMic();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.8, color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                        onTap: () {
                          controller.text = textSpeech;
                          Clipboard.setData(
                              ClipboardData(text: controller.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Text Copied in your clipboard!')),
                          );
                        },
                        child: Text(
                          textSpeech,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ))),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    if (!isListening) {
                      bool micAvailable = await speechToText.initialize();

                      if (micAvailable) {
                        setState(() {
                          isListening = true;
                        });

                        speechToText.listen(
                            listenFor: const Duration(seconds: 20),
                            onResult: (result) {
                              setState(() {
                                textSpeech = result.recognizedWords;
                                isListening = false;
                              });
                            });
                      }
                    } else {
                      setState(() {
                        isListening = false;

                        speechToText.stop();
                      });
                    }
                  },
                  child: CircleAvatar(
                    child: isListening
                        ? const Icon(Icons.record_voice_over)
                        : const Icon(Icons.mic),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Press on mic and speak!')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
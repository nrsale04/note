import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:mydailynote/note_options.dart/models/enum/bar_position.dart';
import 'package:mydailynote/note_options.dart/models/rich_editor_options.dart';
import 'package:mydailynote/note_options.dart/rendering/rich_editor.dart';
import 'package:mydailynote/note_options.dart/services/local_server.dart';
import 'package:speech_to_text/speech_to_text.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String mainTitle = 'Title';
  String mainNote = 'Start typing here...';
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

  TextEditingController controllerrr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final editorState =
    //     EditorState.blank(withInitialText: true); // with an empty paragraph
    // final editor = AppFlowyEditor(
    //   editorState: editorState,
    // );
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/milky_way.jpg"),
                  fit: BoxFit.cover,
                )),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: RichEditor(
              value: 'Type html here...',
              editorOptions: RichEditorOptions(
                placeholder: 'Start typing',
                // backgroundColor: Colors.blueGrey, // Editor's bg color
                // baseTextColor: Colors.white,
                // editor padding
                padding: const EdgeInsets.only(top: 50),
                // font name
                baseFontFamily: 'sans-serif',
                // Position of the editing bar (BarPosition.TOP or BarPosition.BOTTOM)
                barPosition: BarPosition.BOTTOM,
              ),
              // You can return a Link (maybe you need to upload the image to your
              // storage before displaying in the editor or you can also use base64
              getImageUrl: (image) {
                // controller.controllerWebView!.reload();

                String base64 = base64Encode(image.readAsBytesSync());
                String base64String = 'data:image/png;base64, $base64';
                return base64String;
              },
            ),
            // Container(
            //   height: size.width * .15,
            //   width: size.width,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.withOpacity(0.3)),
            //     color: Colors.white.withOpacity(0.7),
            //   ),
            //   child: _buildFloatingButton(),
            // ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  if (!isListening) {
                    bool micAvailable = await speechToText.initialize();

                    if (micAvailable) {
                      setState(() {
                        isListening = true;
                        speechToText.listen(
                            listenFor: const Duration(seconds: 20),
                            onResult: (result) {
                              setState(() {
                                controller.textSpeech.value =
                                    result.recognizedWords;
                                isListening = false;
                              });
                            });
                      });
                      // controller.controllerWebView!.reload();
                    }
                    // controller.controllerWebView!.reload();
                  } else {
                    setState(() {
                      isListening = false;
                      speechToText.stop();
                      // _initServer();
                    });
                  }
                },
                child: CircleAvatar(
                  child: isListening
                      ? const Icon(Icons.record_voice_over)
                      : const Icon(Icons.mic),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.8, color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  child: GestureDetector(
                      onTap: () {
                        controllerrr.text = controller.textSpeech.value;
                        Clipboard.setData(
                            ClipboardData(text: controllerrr.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Text Copied in your clipboard!')),
                        );
                      },
                      child: Text(
                        controller.textSpeech.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}

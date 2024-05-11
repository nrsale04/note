import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydailynote/note_options.dart/utils/javascript_executor_base.dart';
import 'package:mydailynote/note_options.dart/widgets/check_dialog.dart';
import 'package:mydailynote/note_options.dart/widgets/fonts_dialog.dart';
import 'package:mydailynote/note_options.dart/widgets/tab_button.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';
import 'color_picker_dialog.dart';
import 'font_size_dialog.dart';
import 'heading_dialog.dart';

TextEditingController linko = TextEditingController();
TextEditingController alt = TextEditingController();
bool picked = false;

class EditorToolBar extends StatefulWidget {
  final Function(File image)? getImageUrl;
  final Function(File video)? getVideoUrl;
  final JavascriptExecutorBase javascriptExecutor;
  final bool? enableVoice;

  // EditorToolBar({
  //   this.getImageUrl,
  //   this.getVideoUrl,
  //   required this.javascriptExecutor,
  //   this.enableVoice,
  // });
  const EditorToolBar({
    super.key,
    this.getImageUrl,
    this.getVideoUrl,
    required this.javascriptExecutor,
    this.enableVoice,
  });

  @override
  State<EditorToolBar> createState() => EditorToolBarState();
}

class EditorToolBarState extends State<EditorToolBar> {
  @override
  void initState() {
    super.initState();
    checkMic();
  }

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

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.0,
      child: Column(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                TabButton(
                  tooltip: 'Bold',
                  icon: Icons.format_bold,
                  onTap: () async {
                    await widget.javascriptExecutor.setBold();
                  },
                ),
                TabButton(
                  tooltip: 'Italic',
                  icon: Icons.format_italic,
                  onTap: () async {
                    await widget.javascriptExecutor.setItalic();
                  },
                ),
                TabButton(
                  tooltip: 'Background Image',
                  icon: Icons.image_outlined,
                  onTap: () async {},
                ),
                // TabButton(
                //   tooltip: 'Insert Link',
                //   icon: Icons.link,
                //   onTap: () async {
                //     var link = await showDialog(
                //       context: context,
                //       barrierDismissible: false,
                //       builder: (_) {
                // return InsertLinkDialog();
                //       },
                //     );
                //     if (link != null)
                // await javascriptExecutor.insertLink(link[0], link[1]);
                //   },
                // ),
                TabButton(
                  tooltip: 'Insert Image',
                  icon: Icons.image,
                  onTap: () async {
                    final picker = ImagePicker();
                    XFile? image;
                    image = await picker.pickImage(
                      source: ImageSource.gallery,
                      // maxWidth: 800.0,
                      // maxHeight: 600.0,
                    );
                    // if (image != null) {

                    // }
                    var link;
                    if (image != null) {
                      linko.text = image.path;
                      picked = true;
                      if (widget.getImageUrl != null && picked == true) {
                        link = await widget.getImageUrl!(File(linko.text));
                      }
                      await widget.javascriptExecutor.insertImage(
                        linko.text,
                      );
                    }
                  },
                ),
                Visibility(
                  visible: widget.enableVoice!,
                  child: TabButton(
                    tooltip: 'Insert voice',
                    icon: Icons.voice_chat,
                    onTap: () async {},
                  ),
                ),
                //    TabButton(
                //   tooltip: 'Speech to text',
                //   icon:isListening ?Icons.record_voice_over:Icons.mic,
                //   onTap: () async {
                //     if (!isListening) {
                //       bool micAvailable = await speechToText.initialize();

                //       if (micAvailable) {
                //         setState(() {
                //           isListening = true;
                //         });

                //         speechToText.listen(
                //             listenFor: const Duration(seconds: 20),
                //             onResult: (result) {
                //               setState(() {
                //                 textSpeech = result.recognizedWords;
                //                 isListening = false;
                //               });
                //             });
                //       }
                //     } else {
                //       setState(() {
                //         isListening = false;

                //         speechToText.stop();
                //       });
                //     }
                //   },
                // ),
                TabButton(
                    tooltip: 'Tag',
                    icon: Icons.tag,
                    onTap: () async {
                      await widget.javascriptExecutor.setTag();
                    }),
                TabButton(
                  tooltip: 'Underline',
                  icon: Icons.format_underline,
                  onTap: () async {
                    await widget.javascriptExecutor.setUnderline();
                  },
                ),
                TabButton(
                  tooltip: 'Strike through',
                  icon: Icons.format_strikethrough,
                  onTap: () async {
                    await widget.javascriptExecutor.setStrikeThrough();
                  },
                ),
                TabButton(
                  tooltip: 'Superscript',
                  icon: Icons.superscript,
                  onTap: () async {
                    await widget.javascriptExecutor.setSuperscript();
                  },
                ),
                TabButton(
                  tooltip: 'Subscript',
                  icon: Icons.subscript,
                  onTap: () async {
                    await widget.javascriptExecutor.setSubscript();
                  },
                ),
                // TabButton(
                //   tooltip: 'Clear format',
                //   icon: Icons.format_clear,
                //   onTap: () async {
                //     await javascriptExecutor.removeFormat();
                //   },
                // ),
                TabButton(
                  tooltip: 'Undo',
                  icon: Icons.undo,
                  onTap: () async {
                    await widget.javascriptExecutor.undo();
                  },
                ),
                TabButton(
                  tooltip: 'Redo',
                  icon: Icons.redo,
                  onTap: () async {
                    await widget.javascriptExecutor.redo();
                  },
                ),
                TabButton(
                  tooltip: 'Blockquote',
                  icon: Icons.format_quote,
                  onTap: () async {
                    await widget.javascriptExecutor.setBlockQuote();
                  },
                ),
                TabButton(
                  tooltip: 'Font format',
                  icon: Icons.text_format,
                  onTap: () async {
                    var command = await showDialog(
                      // isScrollControlled: true,
                      context: context,
                      builder: (_) {
                        return HeadingDialog();
                      },
                    );
                    if (command != null) {
                      if (command == 'p') {
                        await widget.javascriptExecutor
                            .setFormattingToParagraph();
                      } else if (command == 'pre') {
                        await widget.javascriptExecutor.setPreformat();
                      } else if (command == 'blockquote') {
                        await widget.javascriptExecutor.setBlockQuote();
                      } else {
                        await widget.javascriptExecutor
                            .setHeading(int.tryParse(command)!);
                      }
                    }
                  },
                ),
                // TODO: Show font button on iOS
                Visibility(
                  visible: (!kIsWeb && Platform.isAndroid),
                  child: TabButton(
                    tooltip: 'Font face',
                    icon: Icons.font_download,
                    onTap: () async {
                      var command = await showDialog(
                        // isScrollControlled: true,
                        context: context,
                        builder: (_) {
                          return FontsDialog();
                        },
                      );
                      if (command != null)
                        await widget.javascriptExecutor.setFontName(command);
                    },
                  ),
                ),
                TabButton(
                  icon: Icons.format_size,
                  tooltip: 'Font Size',
                  onTap: () async {
                    String? command = await showDialog(
                      // isScrollControlled: true,
                      context: context,
                      builder: (_) {
                        return FontSizeDialog();
                      },
                    );
                    if (command != null)
                      await widget.javascriptExecutor
                          .setFontSize(int.tryParse(command)!);
                  },
                ),
                TabButton(
                  tooltip: 'Text Color',
                  icon: Icons.format_color_text,
                  onTap: () async {
                    var color = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorPickerDialog(color: Colors.blue);
                      },
                    );
                    if (color != null)
                      await widget.javascriptExecutor.setTextColor(color);
                  },
                ),
                TabButton(
                  tooltip: 'Background Color',
                  icon: Icons.format_color_fill,
                  onTap: () async {
                    var color = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorPickerDialog(color: Colors.blue);
                      },
                    );
                    if (color != null)
                      await widget.javascriptExecutor
                          .setTextBackgroundColor(color);
                  },
                ),
                TabButton(
                  tooltip: 'Increase Indent',
                  icon: Icons.format_indent_increase,
                  onTap: () async {
                    await widget.javascriptExecutor.setIndent();
                  },
                ),
                TabButton(
                  tooltip: 'Decrease Indent',
                  icon: Icons.format_indent_decrease,
                  onTap: () async {
                    await widget.javascriptExecutor.setOutdent();
                  },
                ),
                TabButton(
                  tooltip: 'Align Left',
                  icon: Icons.format_align_left_outlined,
                  onTap: () async {
                    await widget.javascriptExecutor.setJustifyLeft();
                  },
                ),
                TabButton(
                  tooltip: 'Align Center',
                  icon: Icons.format_align_center,
                  onTap: () async {
                    await widget.javascriptExecutor.setJustifyCenter();
                  },
                ),
                TabButton(
                  tooltip: 'Align Right',
                  icon: Icons.format_align_right,
                  onTap: () async {
                    await widget.javascriptExecutor.setJustifyRight();
                  },
                ),
                TabButton(
                  tooltip: 'Justify',
                  icon: Icons.format_align_justify,
                  onTap: () async {
                    await widget.javascriptExecutor.setJustifyFull();
                  },
                ),
                TabButton(
                  tooltip: 'Bullet List',
                  icon: Icons.format_list_bulleted,
                  onTap: () async {
                    await widget.javascriptExecutor.insertBulletList();
                  },
                ),
                TabButton(
                  tooltip: 'Numbered List',
                  icon: Icons.format_list_numbered,
                  onTap: () async {
                    await widget.javascriptExecutor.insertNumberedList();
                  },
                ),
                TabButton(
                  tooltip: 'Checkbox',
                  icon: Icons.check_box_outlined,
                  onTap: () async {
                    final String uid = const Uuid().v4();
                    await widget.javascriptExecutor.insertCheckbox(uid);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

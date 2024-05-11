import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';
import 'package:mydailynote/loader_t.dart';


import 'package:url_launcher/link.dart';

import '../../get/controller.dart';

class InterAdAppeks extends StatefulWidget {
  const InterAdAppeks({super.key});

  @override
  State<InterAdAppeks> createState() => _InterAdAppeksState();
}

class _InterAdAppeksState extends State<InterAdAppeks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: controller
                      .myAdDataModel!.appeksInterList[0].toggleBackgroundImage
                  ? CachedNetworkImage(
                      imageUrl: controller
                          .myAdDataModel!.appeksInterList[0].interBackgroundUrl,
                      placeholder: (context, url) => const LoaderT(),
                    )
                  : Container(
                      color: controller
                          .myAdDataModel!.appeksInterList[0].backgroundColor
                          .toColor(),
                    )),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 25, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Image(
                  image: AssetImage('assets/cancelIcon.png'),
                  height: 25,
                  width: 25,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).width * .2,
                        width: MediaQuery.sizeOf(context).width * .2,
                        margin: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                            imageUrl: controller
                                .myAdDataModel!.appeksInterList[0].avatarImage,
                            placeholder: (context, url) => const LoaderT()),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller
                                .myAdDataModel!.appeksInterList[0].interTitle!,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller
                                .myAdDataModel!.appeksInterList[0].interTitle!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * .8,
                    width: MediaQuery.sizeOf(context).width,
                    child: CachedNetworkImage(
                        imageUrl: controller.myAdDataModel!.appeksInterList![0]
                            .discriptionImage,
                        placeholder: (context, url) => const LoaderT()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller
                              .myAdDataModel!.appeksInterList[0].titleCaption!,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller
                              .myAdDataModel!.appeksInterList[0].interCaption,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.appeksInter[0].btnText != '' &&
                  controller.appeksInter[0].actionButton != ''
              ? Positioned(
                  bottom: 20,
                  left: MediaQuery.sizeOf(context).width * .3,
                  right: MediaQuery.sizeOf(context).width * .3,
                  child: Link(
                    target: LinkTarget.self,
                    uri: Uri.parse(controller.appeksInter[0].actionButton == ''
                        ? ''
                        : controller.appeksInter[0].actionButton),
                    builder: (context, followLink) => MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: followLink,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              MediaQuery.sizeOf(context).width * .4,
                              MediaQuery.sizeOf(context).width * .1),
                          maximumSize: Size(
                              MediaQuery.sizeOf(context).width * .4,
                              MediaQuery.sizeOf(context).width * .1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: darkred,
                        ),
                        child: Text(
                            controller.myAdDataModel!.appeksInterList[0]
                                        .btnText ==
                                    ''
                                ? ''
                                : controller
                                    .myAdDataModel!.appeksInterList[0].btnText,
                            style: const TextStyle(
                              fontSize: 22.0,
                              color: white,
                              fontFamily: "vazir",
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/appeks_inter.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:mydailynote/loader_t.dart';



import 'package:url_launcher/link.dart';

class CustomInter extends StatefulWidget {
  const CustomInter({super.key});

  @override
  State<CustomInter> createState() => _CustomInterState();
}

class _CustomInterState extends State<CustomInter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: controller.customInter[0].toggleBackgroundImage
                  ? CachedNetworkImage(
                      imageUrl: controller.customInter[0].interBackgroundUrl,
                      placeholder: (context, url) => const LoaderT(),
                    )
                  : Container(
                      color:
                          controller.customInter[0].backgroundColor.toColor(),
                    )),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
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
                      const SizedBox(
                        width: 20,
                      ),
                      controller.customInter[0].avatarImage != null
                          ? SizedBox(
                              height: MediaQuery.sizeOf(context).width * .2,
                              width: MediaQuery.sizeOf(context).width * .2,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      controller.customInter[0].avatarImage,
                                  placeholder: (context, url) =>
                                      const LoaderT()),
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.customInter[0].interTitle ?? '',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.customInter[0].interTitle ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  controller.customInter[0].discriptionImage != null
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).width * .8,
                          width: MediaQuery.sizeOf(context).width,
                          child: CachedNetworkImage(
                              imageUrl:
                                  controller.customInter[0].discriptionImage,
                              placeholder: (context, url) => const LoaderT()),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.customInter[0].titleCaption ?? '',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.customInter[0].interCaption ?? '',
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
          controller.customInter[0].btnText != '' &&
                  controller.customInter[0].actionButton != ''
              ? Positioned(
                  bottom: 20,
                  left: MediaQuery.sizeOf(context).width * .3,
                  right: MediaQuery.sizeOf(context).width * .3,
                  child: Link(
                    target: LinkTarget.self,
                    uri: Uri.parse(controller.customInter[0].actionButton),
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
                        child: Text(controller.customInter[0].btnText,
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

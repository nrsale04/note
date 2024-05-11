// ignore: file_names
import 'package:flutter/material.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';


class LoaderT extends StatelessWidget {
  const LoaderT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ) {
    return Scaffold(
      backgroundColor: white,
      body: IgnorePointer(
        child: Container(
          color: white.withOpacity(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.all(5),
                  child: const CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: AlwaysStoppedAnimation(black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

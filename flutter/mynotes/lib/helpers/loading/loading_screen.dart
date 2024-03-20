import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mynotes/helpers/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreenController? controller;

  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) return;
    controller = showOverlay(context: context, text: text);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final txtController = StreamController<String>();
    txtController.add(text);
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject()
        as RenderBox; // gives us the available space in the screen
    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        //paints the background so it focus in the loading icon
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            //0.8 means we have 20% margin from the screen
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5,
              minHeight: size.height * 0.5,
            ),
            //gives us border so we can differentiate it with the background
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              //allow us to scroll if it overflows the container
              child: SingleChildScrollView(
                child: Column(
                  //set the column to take minimum size it needs to it doesnt fill its container,
                  mainAxisSize: MainAxisSize.min,
                  //align the contents vertically to the center
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    StreamBuilder(
                        stream: txtController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                            );
                          }
                          return Container();
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    state.insert(overlay);

    return LoadingScreenController(close: () {
      txtController.close();
      overlay.remove();
      return true;
    }, update: (text) {
      txtController.add(text);
      return true;
    });
  }
}

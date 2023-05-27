import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class BlogTTSProvider extends ChangeNotifier{
  // FlutterTts flutterTts = FlutterTts();
  // TtsState _ttsState = TtsState.stopped;
  // int currentWordIndex = -1;
  // List<String> words = [];
  //
  // TtsState get ttsState => _ttsState;
  //
  // void toggleTts(String text) async {
  //   if (_ttsState == TtsState.playing) {
  //     await flutterTts.pause();
  //     _ttsState = TtsState.stopped;
  //     currentWordIndex = -1;
  //     notifyListeners();
  //   } else {
  //     flutterTts.setSpeechRate(0.4);
  //     flutterTts.setCompletionHandler(() {
  //       _ttsState = TtsState.stopped;
  //       notifyListeners();
  //     });
  //     words = text.split(' ');
  //     currentWordIndex = 0;
  //     await flutterTts.speak(text);
  //     _ttsState = TtsState.playing;
  //     notifyListeners();
  //   }
  // }
  //
  // List<TextSpan> getTextSpans(String text) {
  //
  //   List<TextSpan> textSpans = [];
  //
  //   for (int i = 0; i < text.length; i++) {
  //     TextSpan textSpan = TextSpan(
  //       text: text[i],
  //       style: TextStyle(
  //         color: currentWordIndex >= 0 && i >= currentWordIndex && i < currentWordIndex + words.length ?
  //         themeColorSnackBarRed : themeColorWhite,
  //       ),
  //     );
  //     textSpans.add(textSpan);
  //   }
  //   notifyListeners();
  //   return textSpans;
  // }

  FlutterTts flutterTts = FlutterTts();
  List<String> words = [];
  int currentWordIndex = -1;

  BlogTTSProvider() {
    flutterTts.setCompletionHandler(() {
      currentWordIndex = -1; // Reset the current word index when speech is completed
      notifyListeners();
    });
  }

  Future<void> toggleTts(String text) async {
    if (isPlaying()) {
      await flutterTts.pause();
      currentWordIndex = -1;
      notifyListeners();
    } else {
      words = text.split(' ');
      currentWordIndex = 0;
      flutterTts.setSpeechRate(0.4);
      await flutterTts.speak(text);
      notifyListeners();
    }
  }

  bool isPlaying() {
    return currentWordIndex >= 0 && currentWordIndex < words.length;
  }

  // List<String> getSpokenWords() {
  //   if (isPlaying()) {
  //     return words.sublist(currentWordIndex);
  //   } else {
  //     return [];
  //   }
  // }
}
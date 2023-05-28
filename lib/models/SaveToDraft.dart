import 'dart:io';

class SaveToDraft {
  int id;
  File? coverImg;
  String title;
  String content;
  int topic;
  String date;
  int readMinute;

  SaveToDraft({
    required this.id,
    required this.coverImg,
    required this.title,
    required this.content,
    required this.topic,
    required this.date,
    required this.readMinute,
  });

}

class GetFirstCharOfName {
  String getFirstCharacters(String input) {
    List<String> words = input.split(' ');

    if (words.length > 1) {
      return '${words[0][0]}${words[1][0]}';
    } else {
      return words[0][0];
    }
  }
}
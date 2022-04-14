extension StringExtendedExtension on String {
  String get capitalize {
    List<String> words = split(' ');
    List<String> temp = [];
    for (String item in words) {
      temp.add(item[0].toUpperCase() + item.substring(1));
    }
    return temp.join(' ');
  }
}
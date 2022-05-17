extension StringExtendedExtension on String {
  String get capitalize {
    List<String> words = split(' ');
    List<String> temp = [];
    for (String item in words) {
      if (item.isEmpty) continue;
      if (item.length < 2) continue;
      temp.add(item[0].toUpperCase() + item.substring(1));
    }
    return temp.join(' ');
  }
}

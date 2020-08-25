class UniquifyLists {
  static void uniqifyList(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      dynamic object = list[i];
      int index;
      // Remove duplicates
      do {
        index = list.indexOf(object, i + 1);
        if (index != -1) {
          list.removeRange(index, 1);
        }
      } while (index != -1);
    }
  }
}

extension StringExtension on String {
  String toTitleCase() {
    return split('-').map((word) => word.capitalize()).join(' ');
  }

  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeFormatting on DateTime {
  String toFormattedString() {
    return "${year.toString().padLeft(4, '0')}-"
        "${month.toString().padLeft(2, '0')}-"
        "${day.toString().padLeft(2, '0')}";
  }
}

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

extension MonthExtension on Month {
  String get name {
    return toString().split('.').last;
  }

  String get initials {
    return name[0].toUpperCase() + name.substring(1, 3);
  }
}

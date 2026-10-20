class User {}

class Student extends User {
  final String name;
  final String bio;
  final String joinDate;
  final String email;
  final Function()? action;
  Student({
    required this.name,
    required this.bio,
    required this.joinDate,
    required this.email,
    this.action,
  });
}

class Instructor extends User {
  final String? image;
  final String name;
  final String bio;
  final String date;
  final String email;
  final Function()? action;

  Instructor({
    this.image,
    required this.name,
    required this.bio,
    required this.date,
    required this.email,
    required this.action,
  });
}

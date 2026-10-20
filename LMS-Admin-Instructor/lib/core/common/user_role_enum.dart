enum UserRole {
  admin('admin'),
  instructor('instructor'),
  student('student');

  final String name;
  const UserRole(this.name);

  factory UserRole.fromString(String? role) {
    return UserRole.values.firstWhere(
      (element) => element.name == role,
      orElse: () => UserRole.student,
    );
  }
}

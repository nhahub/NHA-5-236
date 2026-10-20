class AdminProfileUIModel {
  final String firstName;
  final String lastName;
  final String email;
  final String slug;
  final String image;
  final String createdAt;

  AdminProfileUIModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.slug,
    required this.image,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName'.trim();

  String get formattedJoinedDate {
    final parsed = DateTime.tryParse(createdAt);
    if (parsed != null) {
      return "${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}";
    }
    return createdAt;
  }
}

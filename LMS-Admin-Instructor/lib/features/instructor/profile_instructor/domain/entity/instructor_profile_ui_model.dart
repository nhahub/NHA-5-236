class InstructorProfileUIModel {
  final String firstName;
  final String lastName;
  final String email;
  final String slug;
  final String bio;
  final String description;
  final String image;
  final List<InstructorLinkUIModel> links;
  final String createdAt;

  InstructorProfileUIModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.slug,
    required this.bio,
    required this.description,
    required this.image,
    required this.links,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  InstructorProfileUIModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? slug,
    String? bio,
    String? description,
    String? image,
    List<InstructorLinkUIModel>? links,
    String? createdAt,
  }) {
    return InstructorProfileUIModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      slug: slug ?? this.slug,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      image: image ?? this.image,
      links: links ?? this.links,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class InstructorLinkUIModel {
  final String slug;
  final String platformName;
  final String url;

  InstructorLinkUIModel({
    required this.slug,
    required this.platformName,
    required this.url,
  });
}

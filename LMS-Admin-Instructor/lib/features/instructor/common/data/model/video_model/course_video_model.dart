class CourseVideoModel {
  final String slug;
  final String title;
  final bool isCompleted;
  final String? videoUrl;
  final String? videoUpload;
  final int order;
  final String? duration;

  CourseVideoModel({
    required this.slug,
    required this.title,
    required this.isCompleted,
    this.videoUrl,
    this.videoUpload,
    required this.order,
    this.duration,
  });

  factory CourseVideoModel.fromJson(Map<String, dynamic> json) {
    return CourseVideoModel(
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      isCompleted: json['is_completed'] ?? false,
      videoUrl: json['video_url'],
      videoUpload: json['video_upload'],
      order: json['order'] ?? 0,
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'title': title,
      'is_completed': isCompleted,
      'video_url': videoUrl,
      'video_upload': videoUpload,
      'order': order,
      'duration': duration,
    };
  }
}

class CourseVideoResponseModel {
  final bool success;
  final int status;
  final String message;
  final List<CourseVideoModel> data;

  CourseVideoResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourseVideoResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseVideoResponseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 200,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => CourseVideoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

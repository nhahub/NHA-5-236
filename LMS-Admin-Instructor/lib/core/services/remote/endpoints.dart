class EndPoint {
    static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:8000/api/',
  );

  // auth
  static String login = "/auth/login/";
  static String register = "/auth/register/";
  static String logout = "/auth/logout/";
  static String changePassword = "/auth/change-password/";
  static String forgotPassword = "/auth/forgot-password/";
  static String resetPassword = "/auth/reset-password/";
  static String refreshToken = "/auth/token/refresh/";
  static String checkToken = "/auth/check-token/";
  static String resendOtp = "/auth/resend-otp/";

  //?***********************************************************************?

  //? Admin
  static String adminProfile(String slug) => "/admin/$slug/profile/";

  //? Students
  static String studentsAdmin = "/admin/students/";
  static String deleteStudentAdmin(String slug) =>
      "/admin/students/$slug/delete/";
  static String studentsInstructor(String instructorSlug) =>
      "/instructor/$instructorSlug/students/";
  static String studentsDetailsInstructor(String studentSlug) =>
      "/instructor/students/$studentSlug/summary/";
  static String studentsDetailsAdmin(String studentSlug) =>
      "/admin/students/$studentSlug/details/";

  static String allCoursesAdmin = "/courses/all/";
  static String deleteCourseAdmin(String slug) => "/courses/delete/$slug/";

  static String createPackage = "/packages/create/";
  static String deletePackage(String slug) => "/packages/delete/$slug/";
  static String packageDetails(String slug) => "/packages/$slug/";
  static String updatePackage(String slug) => "/packages/update/$slug/";

  //?***********************************************************************?
  //? Courses' Instructor
  static String coursesInstructor(String instructorSlug) =>
      "/instructor/$instructorSlug/courses/";
  static String packagesInstructor(String instructorSlug) =>
      "/instructor/$instructorSlug/packages/";

  //? instructor
  static String instructorAdmin = "/instructors/";
  static String addInstructor = "/instructors/create/";
  static String deleteInstructor(String slug) => "/instructors/$slug/delete/";
  static String addCourse = "/courses/create/";
  static String updateCourse(String slug) => "/courses/update/$slug/";
  static String getInstructorBySlug(String slug) => "/instructors/$slug/";
  static String updateInstructor(String slug) => "/instructors/$slug/update/";
  static String getInstructorLinks(String slug) => "/instructors/$slug/links/";
  static String addInstructorLink(String slug) =>
      "/instructors/$slug/links/create/";
  static String deleteInstructorLink(String slug) =>
      "/instructors/links/$slug/delete/";
  static String updateInstructorLink(String slug) =>
      "/instructors/links/$slug/update/";
  static String getInstructorCoursesBySslug(String slug) =>
      "/instructor/$slug/courses/";

  //? course details
  static String courseDetails(String slug) => "/courses/$slug/";
  static String totalCourseDetails(String slug) => "/totalCourseDetails/$slug/";
  static String courseStudents(String slug) => "/courses/$slug/students/";
  static String courseVideos(String slug) => "/courses/$slug/videos/";
  static String videosBySlug(String slug) => "/videos/$slug/";
  static String deleteVideo(String slug) => "/videos/$slug/delete/";
  static String createVideo = "/videos/create/";
  static String courseMaterials(String slug) => "/courses/$slug/materials/";
  static String courseQuizzes(String slug) => "/courses/$slug/quizzes/";

  //? Quizzes
  static String quizDetails(String slug) => "/quizzes/$slug/";

  //? Questions
  static String quizQuestions(String quizSlug) =>
      "/quizzes/$quizSlug/questions/";
  static String createQuestion(String quizSlug) =>
      "/quizzes/$quizSlug/questions/create/";
  static String questionDetails(String quizSlug, String questionSlug) =>
      "/quizzes/$quizSlug/questions/$questionSlug/";
  static String updateQuestion(String quizSlug, String questionSlug) =>
      "/quizzes/$quizSlug/questions/$questionSlug/update/";
  static String deleteQuestion(String quizSlug, String questionSlug) =>
      "/quizzes/$quizSlug/questions/$questionSlug/delete/";

  //? Choices
  static String questionChoices(String quizSlug, String questionSlug) =>
      "/quizzes/$quizSlug/questions/$questionSlug/choices/";
  static String createChoice(String quizSlug, String questionSlug) =>
      "/quizzes/$quizSlug/questions/$questionSlug/choices/create/";
  static String choiceDetails(
    String quizSlug,
    String questionSlug,
    String choiceSlug,
  ) =>
      "/quizzes/$quizSlug/questions/$questionSlug/choices/$choiceSlug/";
  static String updateChoice(
    String quizSlug,
    String questionSlug,
    String choiceSlug,
  ) =>
      "/quizzes/$quizSlug/questions/$questionSlug/choices/$choiceSlug/update/";
  static String deleteChoice(
    String quizSlug,
    String questionSlug,
    String choiceSlug,
  ) =>
      "/quizzes/$quizSlug/questions/$questionSlug/choices/$choiceSlug/delete/";
}

class ApiKey {
  static String message = "message";
  static String authorization = "Authorization";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String email = "email";
  static String password = "password";
  static String role = "role";
  static String slug = "slug";
  static String isActive = "is_active";
  static String isVerified = "is_verified";
  static String student = "student";
  static String accessToken = "access";
  static String refreshToken = "refresh";
  static String user = "user";
  static String isLoggedIn = "is_logged_in";
  static String oldPassword = "old_password";
  static String newPassword = "new_password";
  static String image = "image";
  static String title = "title";
  static String description = "description";
  static String price = "price";
  static String category = "category";
  static String level = "level";
}

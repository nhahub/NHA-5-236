abstract class AdminProfileEvent {}

class GetAdminProfileEvent extends AdminProfileEvent {
  final String slug;

  GetAdminProfileEvent({required this.slug});
}

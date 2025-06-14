abstract class UserEvent {}

class SignUpEvent extends UserEvent{
  Map<String, dynamic> bodyParams;
  SignUpEvent({required this.bodyParams});
}
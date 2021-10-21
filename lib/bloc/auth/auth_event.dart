abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class ForceLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {}

class ResendCodeEvent extends AuthEvent {
  final email;
  ResendCodeEvent({this.email});
}

class SecondCallEvent extends AuthEvent {
  final authCode;
  SecondCallEvent({this.authCode});
}

class ResetStateEvent extends AuthEvent {}

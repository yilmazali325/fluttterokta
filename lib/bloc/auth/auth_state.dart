abstract class AuthState {}

class LoadingLogoutState extends AuthState {}

class LoadingLoginState extends AuthState {}

class ForcingLoginState extends AuthState {}

class UnlogedState extends AuthState {}

class LogedState extends AuthState {
  String location;
  LogedState({String location}) {
    this.location = location;
  }
}

class LoginErrorState extends AuthState {}

class LoadingSignUpState extends AuthState {}

class LoadedSignUpState extends AuthState {}

class ErrorSignUpState extends AuthState {}

class LoadingForgotPasswordState extends AuthState {}

class LoadedForgotPasswordState extends AuthState {}

class ErrorForgotPasswordState extends AuthState {}

class LoadingResendCodeState extends AuthState {}

class LoadedResendCodeState extends AuthState {}

class ErrorResendCodeState extends AuthState {}

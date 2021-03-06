import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_login_example/shared/api_auth.dart';
import 'package:flutter_bloc_login_example/shared/locator.dart';

import 'auth_state.dart';

class BlocAuth extends Bloc<AuthEvent, AuthState> {
  @override
  get initialState => UnlogedState();

  bool _isLoged = false;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is LoginEvent) {
        yield LoadingLoginState();

        String location = await Locator.instance
            .get<ApiAuth>()
            .login("iron_man@example.com", "marvel_2021");

        yield LogedState(location: location);
      } else if (event is SecondCallEvent) {
        yield LoadingLogoutState();
        // TokenResponse tokenResponse =
        //     await Locator.instance.get<ApiAuth>().secondCall(event.authCode);

        yield UnlogedState();
      } else if (event is LogoutEvent) {
        yield LoadingLogoutState();
        await Locator.instance.get<ApiAuth>().logout();

        yield UnlogedState();
      } else if (event is ForceLoginEvent) {
        yield ForcingLoginState();

        // verify if is loged
        await Future.delayed(Duration(seconds: 1));

        yield _isLoged ? LogedState() : UnlogedState();

        yield LoginErrorState();
      } else if (event is SignUpEvent) {
        yield LoadingSignUpState();

        await Locator.instance.get<ApiAuth>().signUp();

        yield LoadedSignUpState();
      } else if (event is ForgotPasswordEvent) {
        yield LoadingForgotPasswordState();

        yield LoadedForgotPasswordState();
      } else if (event is ResendCodeEvent) {
        yield LoadingResendCodeState();

        await Locator.instance.get<ApiAuth>().resendCode(email: event.email);

        yield LoadedResendCodeState();
      } else {
        yield UnlogedState();
      }
    } catch (e) {
      yield LoginErrorState();
    }
  }
}

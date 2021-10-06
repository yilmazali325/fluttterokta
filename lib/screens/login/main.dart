import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_event.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_state.dart';
import 'package:flutter_bloc_login_example/shared/colors.dart';
import 'package:flutter_bloc_login_example/shared/components.dart';
import 'package:flutter_bloc_login_example/webview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passController = TextEditingController();
  var size;
  final regExp = RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$");

  _login() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<BlocAuth>(context).add(LoginEvent());
    }
  }

  String _validatorEmail(value) {
    if (!regExp.hasMatch(value)) {
      return "type a valid email";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    loginController.text = '';
    passController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    loginController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsCustom.loginScreenUp,
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.0671),
          SizedBox(height: size.height * 0.085),
          Expanded(
            child: _formLogin(),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() {
    return BlocBuilder<BlocAuth, AuthState>(condition: (previousState, state) {
      if (state is LogedState) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Loged2()));
      }
      return;
    }, builder: (context, state) {
      if (state is ForcingLoginState) {
        return SizedBox(
          child: SpinKitWave(
            color: Colors.white,
          ),
        );
      } else {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  InputLogin(
                    validator: _validatorEmail,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: loginController,
                  ),
                  SizedBox(height: size.height * 0.03),
                  InputLogin(
                    hint: 'Password',
                    textEditingController: passController,
                  ),
                  SizedBox(height: size.height * 0.035),
                  _buttonLogin(),
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.height * 0.084),
                    child: Divider(
                      height: size.height * 0.14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buttonLogin() {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    return BlocBuilder<BlocAuth, AuthState>(
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return ButtonLogin(
            isLoading: true,
            backgroundColor: Colors.white,
            label: 'LOGIN ...',
            mOnPressed: () => {},
          );
        } else if (state is LogedState) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Loged2(
          //               location: state.location,
          //             )));
          // Navigator.pushNamed(context, '/loged2', arguments: state.location);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewWebView(
                        location: state.location,
                      )));
        } else {
          return ButtonLogin(
            backgroundColor: Colors.white,
            label: 'SIGN IN',
            mOnPressed: () => _login(),
          );
        }
      },
    );
  }
}

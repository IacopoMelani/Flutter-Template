import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_state.dart';
import 'package:flutter_btmnavbar/bloc/login/login_bloc.dart';
import 'package:flutter_btmnavbar/bloc/login/login_event.dart';
import 'package:flutter_btmnavbar/bloc/login/login_state.dart';
import 'package:flutter_btmnavbar/managers/assets_manager.dart';
import 'package:flutter_btmnavbar/mixins/snackbar.dart';
import 'package:flutter_btmnavbar/services/auth_services.dart';
import 'package:flutter_btmnavbar/styles/color.dart';
import 'package:flutter_btmnavbar/widgets/inputs/my_text_field.dart';
import 'package:flutter_btmnavbar/widgets/loadings/circular_progress_indicator_view.dart';

// MARK: - LoginScreen

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with MySnackBar {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthNotAuthenticatedState) {
                return _AuthForm();
              }
              if (state is AuthFailureState) {
                showError(context, state.message);
                return _AuthForm();
              }
              return Container();
            },
          ),
        ),
      );
}

// MARK: - AuthForm

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topCenter,
        child: _SignInForm(),
      );
}

// MARK: - SignInForm

class _SignInForm extends StatefulWidget {
  const _SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> with MySnackBar {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = FAKE_USER_EMAIL;
    _passwordController.text = FAKE_USER_PASSWORD;
  }

// MARK: - SignInForm Build

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          showError(context, state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return MyCircularProgressIndicatorView();
          }
          return SingleChildScrollView(
            child: _buildAuthForm(context),
          );
        },
      ),
    );
  }

  Widget _buildAuthForm(BuildContext context) {
    final assetsManager = RepositoryProvider.of<AssetsManager>(context);
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                width: 200,
                height: 150,
                child: assetsManager.logo,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: 30.0,
              bottom: 0,
            ),
            child: _buildEmailInput(context),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: 25.0,
              bottom: 0,
            ),
            child: _buildPasswordInput(context),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            height: 45,
            width: 110,
            child: ElevatedButton(
              onPressed: _onLoginButtonPressed,
              child: Text(
                'Login',
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) => MyTextField(
        labelText: "Email",
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        hintText: "Enter your email",
        autocorrect: false,
        validator: (value) => value == null || value == "" ? "Email is required" : null,
      );

  Widget _buildPasswordInput(BuildContext context) => MyTextField(
        labelText: 'Password',
        controller: _passwordController,
        hintText: 'Enter password',
        obscureText: !_passwordVisible,
        validator: (value) => value == null || value == "" ? "Password is required" : null,
        suffixIcon: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: ColorApp.primaryColorLight,
          ),
          onPressed: () => setState(
            () {
              _passwordVisible = !_passwordVisible;
            },
          ),
        ),
      );

  // MARK: - SignInForm Actions

  void _onLoginButtonPressed() {
    final LoginState state = BlocProvider.of<LoginBloc>(context).state;
    if (state is LoginLoadingState) {
      return;
    }
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    if (_formKey.currentState!.validate()) {
      loginBloc.add(LoginWithEmailButtonPressedEvent(email: _emailController.text, password: _passwordController.text));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

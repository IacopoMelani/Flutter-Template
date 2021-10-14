import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_state.dart';
import 'package:flutter_btmnavbar/bloc/login/login_bloc.dart';
import 'package:flutter_btmnavbar/bloc/login/login_event.dart';
import 'package:flutter_btmnavbar/bloc/login/login_state.dart';
import 'package:flutter_btmnavbar/mixins/snackbar.dart';
import 'package:flutter_btmnavbar/widgets/loadings/circular_progress_indicator.dart';

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
                showError(state.message);
                return _AuthForm();
              }
              return MyCircularProgressIndicator();
            },
          ),
        ),
      );
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topCenter,
        child: _SignInForm(),
      );
}

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return MyCircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: _buildAuthForm(),
          );
        },
      ),
    );
  }

  Widget _buildAuthForm() {
    _emailController.text = "test@domain.com";
    _passwordController.text = "123456";
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
                child: Image.asset('assets/idflag.png'),
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
            child: TextFormField(
              autofocus: true,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter valid email id as abc@gmail.com',
              ),
              validator: (value) => value == null ? 'La mail è obbligatoria' : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: 25.0,
              bottom: 0,
            ),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter secure password',
              ),
              validator: (value) => value == null ? 'la password è obbligatoria' : null,
            ),
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

  _onLoginButtonPressed() {
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_bloc.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_event.dart';
import 'package:flutter_btmnavbar/bloc/auth/auth_state.dart';
import 'package:flutter_btmnavbar/main.dart';
import 'package:flutter_btmnavbar/views/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailTextFieldKey = GlobalKey();
  final _passwordTextFieldKey = GlobalKey();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final authBloc = BlocProvider.of<AuthBloc>(context);
              if (state is AuthNotAuthenticatedState) {
                return _buildAuthForm(context);
              }
              if (state is AuthFailureState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: _retryPressed(authBloc),
                      child: Text("Retry"),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
          ),
        ),
      );

  Widget _buildAuthForm(BuildContext context) => Form(
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
              child: TextField(
                key: _emailTextFieldKey,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 50.0,
                top: 25.0,
                bottom: 0,
              ),
              child: TextField(
                key: _passwordTextFieldKey,
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              height: 45,
              width: 110,
              child: ElevatedButton(
                onPressed: _goToMainView,
                child: Text(
                  'Login',
                ),
              ),
            ),
          ],
        ),
      );

  _buildSignInForm(BuildContext context) => Form(
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
              child: TextField(
                key: _emailTextFieldKey,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
                right: 50.0,
                top: 25.0,
                bottom: 0,
              ),
              child: TextField(
                key: _passwordTextFieldKey,
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              height: 45,
              width: 110,
              child: ElevatedButton(
                onPressed: _goToMainView,
                child: Text(
                  'Login',
                ),
              ),
            ),
          ],
        ),
      );

  _retryPressed(AuthBloc authBloc) async {
    authBloc.add(AppLoadedAuthEvent());
  }

  _goToMainView() async {
    (await SharedPreferences.getInstance()).setBool("loggedIn", true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainView(),
      ),
    );
  }
}

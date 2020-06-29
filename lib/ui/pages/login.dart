import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/authBloc.dart';
import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/key.dart';

import 'package:Eliverd/ui/pages/home.dart';
import 'package:Eliverd/ui/pages/store_selection.dart';
import 'package:Eliverd/ui/pages/sign_up.dart';
import 'package:Eliverd/ui/pages/register_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool errorOccurred = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          _setErrorActivate(state);
        } else {
          _setErrorDeactivate(state);
        }

        if (state is Authenticated) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => _buildNextPageByStoreState(state)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          key: LoginPageKeys.loginPage,
          appBar: _transparentAppBar,
          body: ListView(
            padding: EdgeInsets.all(50.0),
            children: <Widget>[
              _buildLoginPageLogo(width),
              SizedBox(height: height / 24.0),
              _buildLoginErrorSection(height),
              _buildIdFieldSection(),
              SizedBox(height: height / 80.0),
              _buildPasswordFieldSection(),
              SizedBox(height: height / 80.0),
              _buildSignInSection(),
              _buildSignUpSection(),
            ],
          ),
        );
      },
    );
  }

  final _transparentAppBar = AppBar(
    backgroundColor: Colors.transparent,
    brightness: Brightness.light,
    elevation: 0.0,
    automaticallyImplyLeading: false,
  );

  Widget _buildLoginPageLogo(double width) => Image(
  key: LoginPageKeys.loginLogo,
  width: width / 1.5,
  height: width / 1.5,
  image:
  AssetImage('assets/images/logo/eliverd_logo_original.png'),
  );

  Widget _buildLoginErrorSection(double height) => Visibility(
    key: LoginPageKeys.loginErrorMsg,
    child: Column(
      children: <Widget>[
        Text(
          errorMessage,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height / 120.0),
      ],
    ),
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    visible: errorOccurred,
  );

  Widget _buildIdFieldSection() => TextField(
    key: LoginPageKeys.idTextField,
    obscureText: false,
    controller: _idController,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      labelText: SignInStrings.idText,
    ),
  );

  Widget _buildPasswordFieldSection() => TextField(
    key: LoginPageKeys.passwordTextField,
    obscureText: true,
    controller: _passwordController,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      labelText: SignInStrings.passwordText,
    ),
  );

  Widget _buildSignInSection() => CupertinoButton(
    key: LoginPageKeys.loginBtn,
    child: Text(
      SignInStrings.login,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
    color: eliverdColor,
    borderRadius: BorderRadius.circular(15.0),
    padding: EdgeInsets.symmetric(
      vertical: 15.0,
    ),
    onPressed: () {
      context.bloc<AuthenticationBloc>().add(SignInAuthentication(
          _idController.text, _passwordController.text));
    },
  );

  Widget _buildSignUpSection() => FlatButton(
    key: LoginPageKeys.signUpBtn,
    child: Text(
      SignInStrings.notSignUp,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ),
      );
    },
  );

  void _setErrorActivate(AuthenticationState state) {
    if (state is! AuthenticationError) {
      throw Exception('Tried to activate error when error is not occurred!');
    }

    setState(() {
      errorOccurred = true;
      errorMessage = (state as AuthenticationError).errorMessage;
    });
  }

  void _setErrorDeactivate(AuthenticationState state) {
    if (state is AuthenticationError) {
      throw Exception('Tried to deactivate error when error is not completely solved!');
    }
    setState(() {
      errorOccurred = false;
      errorMessage = '';
    });
  }

  Widget _buildNextPageByStoreState(AuthenticationState state) {
    if (state is! Authenticated) {
      throw Exception('Tried to navigate to next page when it is not authenticated!');
    }

    final _state = state as Authenticated;

    if (_state.stores.length == 0) {
      return RegisterStorePage();
    } else if (_state.stores.length == 1) {
      return HomePage(currentStore: _state.stores[0]);
    } else {
      return StoreSelectionPage();
    }
  }
}

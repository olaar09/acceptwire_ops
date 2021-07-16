import 'package:acceptwire/repository/fire_auth.dart';
import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_events.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/validators/signup_validator.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  actionButton(authBloc) {
    return Row(
      children: [
        Expanded(
          child: primaryButton('Sign Up', vertical: 14, onPressed: () async {
            authBloc.fireRegisterEvent(
                name: _nameTextController.text,
                email: _emailTextController.text,
                password: _passwordTextController.text);
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();

    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: leadingBtn(context),
          backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocConsumer<AuthBloc, AuthenticationState>(
                listener: (context, state) {
                  state.join(
                      (loading) => null,
                      (validationFailed) => null,
                      (loginAttemptFailed) => null,
                      (signUpAttemptFailed) => mSnackBar(
                          message: signUpAttemptFailed.message,
                          context: context),
                      (unAuth) => null,
                      (authenticated) =>
                          navOfAllPage(context: context, route: '/library'));
                },
                builder: (context, state) {
                  return Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        mTextField('Full Name',
                            onChanged: (text) {},
                            controller: _nameTextController,
                            error: state.join(
                                (loading) => null,
                                (validationFailed) =>
                                    validationFailed.nameError,
                                (loginAttemptFailed) => null,
                                (signUpAttemptFailed) => null,
                                (unAuth) => null,
                                (authenticated) => null)),
                        SizedBox(height: 8.0),
                        mTextField('Email address',
                            onChanged: (text) {},
                            controller: _emailTextController,
                            error: state.join(
                                (loading) => null,
                                (validationFailed) =>
                                    validationFailed.emailError,
                                (loginAttemptFailed) => null,
                                (signUpAttemptFailed) => null,
                                (unAuth) => null,
                                (authenticated) => null)),
                        SizedBox(height: 8.0),
                        mTextField('Password',
                            isPassword: true,
                            onChanged: (text) {},
                            controller: _passwordTextController,
                            error: state.join(
                                (loading) => null,
                                (validationFailed) =>
                                    validationFailed.passwordError,
                                (loginAttemptFailed) => null,
                                (signUpAttemptFailed) => null,
                                (unAuth) => null,
                                (authenticated) => null)),
                        SizedBox(height: 32.0),
                        state.join(
                            (loading) => networkActivityIndicator(),
                            (validationFailed) => actionButton(authBloc),
                            (loginAttemptFailed) => emptyState(),
                            (signUpAttemptFailed) => emptyState(),
                            (unAuth) => actionButton(authBloc),
                            (authenticated) => actionButton(authBloc))
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

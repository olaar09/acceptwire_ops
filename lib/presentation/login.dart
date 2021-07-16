import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/presentation/register.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  actionButtons(context, authBloc) {
    return Container(
      // height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child:
                    primaryButton('Sign In', vertical: 14, onPressed: () async {
                  authBloc.fireLoggedInEvent(
                      email: _emailTextController.text,
                      password: _passwordTextController.text);
                }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: primaryButton('Create New Account', vertical: 14,
                    onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: leadingBtn(context),
        backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      ),
      //  backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      body: BlocConsumer<AuthBloc, AuthenticationState>(
        listener: (context, state) {
          state.join(
              (loading) => null,
              (validationFailed) => null,
              (loginAttemptFailed) => mSnackBar(
                  message: loginAttemptFailed.message, context: context),
              (signUpAttemptFailed) => null,
              (unAuth) => null,
              (authenticated) =>
                  navOfAllPage(context: context, route: '/dashboard'));
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      boldText('Sign in'),
                    ],
                  ),
                  SizedBox(height: 10),
                  mTextField('Email address',
                      onChanged: (text) {},
                      controller: _emailTextController,
                      error: state.join(
                          (loading) => null,
                          (validationFailed) => validationFailed.emailError,
                          (loginAttemptFailed) => null,
                          (signUpAttemptFailed) => null,
                          (unAuth) => null,
                          (authenticated) => null)),
                  SizedBox(height: 8.0),
                  mTextField(
                    'Password',
                    isPassword: true,
                    onChanged: (text) {},
                    controller: _passwordTextController,
                    error: state.join(
                        (loading) => null,
                        (validationFailed) => validationFailed.passwordError,
                        (loginAttemptFailed) => null,
                        (signUpAttemptFailed) => null,
                        (unAuth) => null,
                        (authenticated) => null),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  state.join(
                      (loading) => networkActivityIndicator(),
                      (validationFailed) => actionButtons(context, authBloc),
                      (loginAttemptFailed) => actionButtons(context, authBloc),
                      (signUpAttemptFailed) => actionButtons(context, authBloc),
                      (unAuth) => actionButtons(context, authBloc),
                      (authenticated) => actionButtons(context, authBloc))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/presentation/register.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

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
          if (state is UserAuthenticated) {
            navOfAllPage(context: context, route: '/library');
          }
          if (state is LoginAttemptFailedState) {
            mSnackBar(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Form(
              child: Column(
                children: <Widget>[
                  mTextField('Email address',
                      onChanged: (text) {},
                      controller: _emailTextController,
                      error: state is AuthDataValidationFailedState
                          ? state.emailError
                          : null),
                  SizedBox(height: 8.0),
                  mTextField('Password',
                      isPassword: true,
                      onChanged: (text) {},
                      controller: _passwordTextController,
                      error: state is AuthDataValidationFailedState
                          ? state.passwordError
                          : null),
                  SizedBox(
                    height: 30,
                  ),
                  state is AuthenticationLoadingState
                      ? networkActivityIndicator()
                      : Container(
                          // height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: primaryButton('Sign In',
                                        vertical: 14, onPressed: () async {
                                      authBloc.fireLoggedInEvent(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text);
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
                                    child: primaryButton('Create New Account',
                                        vertical: 14, onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

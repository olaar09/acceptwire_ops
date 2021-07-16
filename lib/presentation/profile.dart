import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: leadingBtn(context),
        title: Text('Profile'),
        backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      ),
      body: BlocConsumer<AuthBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is UserUnAuthenticated)
            navOfAllPage(context: context, route: '/login');
        },
        builder: (context, state) {
          if (state is UserAuthenticated) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    Vl.color(color: MColor.K_SECONDARY_MAIN),
                                backgroundImage:
                                    AssetImage('assets/images/ply.png'),
                                radius: 30,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              boldText('${state.user.displayName}'),
                              regularText('Student',
                                  size: 13,
                                  color:
                                      Vl.color(color: MColor.K_SECONDARY_MAIN)),
                              SizedBox(
                                height: 20,
                              ),
                              boldText('${state.user.email}', size: 16),
                              SizedBox(
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  primaryButton('Logout', vertical: 10, onPressed: () async {
                    context.read<AuthBloc>().fireLoggedOutEvent();
                  })
                  // Add widgets for verifying email
                  // and, signing out the user
                ],
              ),
            );
          }
          return emptyState();
        },
      ),
    );
  }
}

import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/logic/profile/profile_bloc.dart';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  profileItem({required title, required value}) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldText('$value'),
          regularText('$title'),
          Divider(thickness: 0.9)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    var _authBloc = buildContext.read<AuthBloc>();
    var _profileBloc = buildContext.read<ProfileBloc>();

    showProfile(AuthBloc bloc, ProfilePODO user) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            profileItem(title: 'Display name', value: user.displayName),
            profileItem(title: 'Phone number', value: user.phone),
            profileItem(title: 'payout bank name', value: user.payoutBankName),
            profileItem(
                title: 'payout account number',
                value: user.payoutAccountNumber),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                primaryButton('Logout', vertical: 10, onPressed: () async {
                  bloc.fireLoggedOutEvent();
                })
              ],
            )
            // Add widgets for verifying email
            // and, signing out the user
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: leadingBtn(buildContext),
        title: boldText('Profile'),
        centerTitle: false,
        backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          print('State changed $state');
        },
        builder: (context, state) {
          return state.join(
            (loading) => networkActivityIndicator(),
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (loaded) => showProfile(_authBloc, loaded.profilePODO),
            (_) => emptyState(),
          );
        },
      ),
    );
  }
}

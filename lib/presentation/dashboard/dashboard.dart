import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/bloc.dart';
import 'package:acceptwire/logic/profile/profile_bloc.dart';
import 'package:acceptwire/presentation/dashboard/widgets/NotFound.dart';
import 'package:acceptwire/presentation/dashboard/widgets/NotVerifiedForm.dart';
import 'package:acceptwire/presentation/dashboard/widgets/Verified.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

class Dashboard extends StatelessWidget {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    ProfileBloc _profileBloc = buildContext.read<ProfileBloc>();

    Widget loadingError() {
      return Container(
          padding: EdgeInsets.all(12),
          //height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              boldText('An  error occurred. Please try again',
                  textAlign: TextAlign.center, size: 16),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryButton('Try again', vertical: 10, fontSize: 16,
                      onPressed: () async {
                    _profileBloc.fireLoadProfile();
                  })
                ],
              )
            ],
          ));
    }

    loadingWidget(loading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loading.hasError
              ? loadingError()
              : Center(child: networkActivityIndicator()),
        ],
      );
    }

    return Scaffold(
      appBar: buildAppBar(buildContext),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          print('inside the dashboard');
          print(state);
        },
        builder: (context, profileState) {
          return FocusDetector(
            onVisibilityGained: () {
              profileState.join((_) {}, (_) {}, (_) {}, (_) {}, (_) {},
                  (initial) => _profileBloc.fireLoadProfile());
            },
            child: Container(
              color: Colors.white,
              child: profileState.join(
                (loading) {
                  return loadingWidget(loading);
                },
                (notActivated) {
                  return BlocProvider.value(
                    value: _profileBloc,
                    child: NotVerified(),
                  );
                },
                (notVerified) {
                  return BlocProvider.value(
                    value: _profileBloc,
                    child: NotVerifiedForm(),
                  );
                },
                (notFound) {
                  return BlocProvider.value(
                    value: _profileBloc,
                    child: NotFoundForm(),
                  );
                },
                (loaded) {
                  return Text('loaded');
                },
                (initial) {
                  return Center(child: networkActivityIndicator());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext buildContext) {
    AuthBloc _authBloc = buildContext.read<AuthBloc>();

    return AppBar(
      elevation: 0,
      leading: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.join(
              (_) => emptyState(),
              (_) => emptyState(),
              (_) => emptyState(),
              (_) => emptyState(),
              (profileLoaded) => CircleAvatar(
                backgroundColor: Vl.color(color: MColor.K_PRIMARY_MAIN),
                backgroundImage: AssetImage('assets/images/hi.png'),
              ),
              (_) => emptyState(),
            ),
          );
        },
      ),
      titleSpacing: 2,
      title: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.join(
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (profileLoaded) => regularText(
                'Hi, ${profileLoaded.profilePODO.firstName} ${profileLoaded.profilePODO.lastName}',
                size: 16),
            (_) => emptyState(),
          );
        },
      ),
      centerTitle: false,
      backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      actions: [
        BlocConsumer<AuthBloc, AuthenticationState>(builder: (context, state) {
          return state.join(
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (authenticated) => TextButton(
                onPressed: () => _authBloc.fireLoggedOutEvent(),
                child: regularText('Logout', size: 16)),
            (_) => emptyState(),
          );
        }, listener: (_, state) {
          state.join(
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => emptyState(),
            (_) => navOfAllPage(context: buildContext, route: '/onboard'),
            (_) => emptyState(),
            (_) => emptyState(),
          );
        }),
      ],
    );
  }
}

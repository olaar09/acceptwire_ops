import 'package:acceptwire/logic/profile/profile_bloc.dart';
import 'package:acceptwire/presentation/dashboard/widgets/NotFound.dart';
import 'package:acceptwire/presentation/dashboard/widgets/NotVerifiedForm.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        elevation: 0,
        leading: leadingBtn(buildContext),
        backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      ),
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
              child: profileState.join(
                (loading) {
                  return loadingWidget(loading);
                },
                (notActivated) {
                  return Text('not activated ');
                },
                (notVerified) {
                  return NotVerifiedForm();
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
}

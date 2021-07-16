import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/logic/meta_bloc/bloc.dart';
import 'package:acceptwire/logic/meta_bloc/metadata_state.dart';
import 'package:acceptwire/utils/helpers/get_value.dart';
import 'package:acceptwire/utils/helpers/navigation.dart';
import 'package:acceptwire/utils/helpers/widget.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _authBloc = context.read<AuthBloc>();
    var _metaBloc = context.read<MetaDataBloc>();

    Widget displayContent(MetaDataState state) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: normalSize('assets/images/acceptwirelogo.png',
                      height: 80, width: 80),
                ),
              ),
            ),
          ),
          state.join((loading) => networkActivityIndicator(),
              (loaded) => emptyState(), (error) => Text(error.message)),
          SizedBox(
            height: 20,
          )
        ],
      );
    }

    void navigateToDashboard() {
      _metaBloc.state.join(
          (loading) => null,
          (loaded) => {navOfAllPage(context: context, route: '/profile')},
          (error) => null);
    }

    void navigateToOnboard() {
      _metaBloc.state.join((loading) => null, (loaded) {
        navOfAllPage(context: context, route: '/onboard');
      }, (error) => null);
    }

    return Scaffold(
      backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      body: FocusDetector(
        onFocusGained: () async => await _authBloc.loadUser(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthenticationState>(
                listener: (context, authState) {
              authState.join(
                  (loading) => null,
                  (validationFailed) => null,
                  (loginAttemptFailed) => null,
                  (signUpAttemptFailed) => null, (unAuthenticated) {
                navigateToOnboard();
              }, (authenticated) {
                navigateToDashboard();
              });
            }),
          ],
          child: BlocBuilder<MetaDataBloc, MetaDataState>(
            builder: (context, buildState) {
              return FocusDetector(
                  onFocusGained: () => _metaBloc.fireLoadingEvent(),
                  child: displayContent(buildState));
            },
          ),
        ),
      ),
    );
  }
}

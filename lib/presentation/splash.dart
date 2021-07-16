import 'package:acceptwire/logic/auth_bloc/auth_bloc.dart';
import 'package:acceptwire/logic/auth_bloc/auth_states.dart';
import 'package:acceptwire/logic/meta_bloc/bloc.dart';
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
    var _authBloc = context.watch<AuthBloc>();
    var _metaBloc = context.watch<MetaDataBloc>();

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
          state is MetaDataLoadingState
              ? networkActivityIndicator()
              : emptyState(),
          state is MetaDataErrorState ? Text(state.message) : emptyState(),
          SizedBox(
            height: 20,
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Vl.color(color: MColor.K_LIGHT_PLAIN),
      body: FocusDetector(
        onFocusGained: () async => await _authBloc.loadUser(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthenticationState>(
                listener: (context, authState) {
              if (authState is UserAuthenticated &&
                  _metaBloc.state is MetaDataLoadedState) {
                navOfAllPage(context: context, route: '/library');
              }
              if (authState is UserUnAuthenticated &&
                  _metaBloc.state is MetaDataLoadedState) {
                navOfAllPage(context: context, route: '/onboard');
              }
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

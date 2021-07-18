import 'package:acceptwire/logic/profile/profile_bloc.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotVerified extends StatelessWidget {
  const NotVerified({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    ProfileBloc _profileBloc = buildContext.read<ProfileBloc>();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              height: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/verifying.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: regularText(
                  'We are currently verifying your information and will let you know when your account is ready.',
                  size: 16,
                  textAlign: TextAlign.center),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryButton('Check verification status', vertical: 14,
                      onPressed: () {
                    _profileBloc.fireLoadProfile();
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:acceptwire/logic/create_profile/create_profile_bloc.dart';
import 'package:acceptwire/logic/profile/profile_bloc.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/error.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotFoundForm extends StatelessWidget {
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    ProfileRepository _profileRepo = buildContext.read<ProfileRepository>();
    CreateProfileBloc _bloc = CreateProfileBloc(repository: _profileRepo);
    actionBtn() {
      return Expanded(
        child:
            primaryButton('Create profile', vertical: 14, onPressed: () async {
          print('hi');
          _bloc.createProfile(phoneNumber: _emailTextController.text);
        }),
      );
    }

    return BlocConsumer<CreateProfileBloc, CreateProfileState>(
      bloc: _bloc,
      listener: (context, state) {
        print(state);
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
                    boldText('Create a profile'),
                  ],
                ),
                SizedBox(height: 10),
                mTextField('Phone number',
                    onChanged: (text) {},
                    controller: _emailTextController,
                    error: state.join(
                      (creating) => '',
                      (created) => '',
                      (error) => '${error.message}',
                      (initial) => '',
                    )),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.join(
                      (creating) => Center(child: networkActivityIndicator()),
                      (created) => Center(child: networkActivityIndicator()),
                      (_) => actionBtn(),
                      (initial) => actionBtn(),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

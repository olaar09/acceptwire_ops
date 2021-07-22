import 'package:acceptwire/logic/profile/profile_bloc.dart';
import 'package:acceptwire/logic/verify_identity/verify_identity_bloc.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:acceptwire/utils/helpers/buttons.dart';
import 'package:acceptwire/utils/helpers/text.dart';
import 'package:acceptwire/utils/widgets/loading.dart';
import 'package:acceptwire/utils/widgets/snackbars.dart';
import 'package:acceptwire/utils/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NotVerifiedForm extends StatefulWidget {
  @override
  _NotVerifiedFormState createState() => _NotVerifiedFormState();
}

class _NotVerifiedFormState extends State<NotVerifiedForm> {
  final _bvnTextController = TextEditingController();

  final _firstNameTextController = TextEditingController();

  final _lastNameTextController = TextEditingController();

  final _bankNameTextController = TextEditingController();

  final _bankAccNoTextController = TextEditingController();

  @override
  Widget build(BuildContext buildContext) {
    ProfileRepository _profileRepo = buildContext.read<ProfileRepository>();
    VerifyIdentityBloc _bloc = VerifyIdentityBloc(repository: _profileRepo);

    /// call verify
    ProfileBloc _profileBloc = buildContext.read<ProfileBloc>();
    _profileBloc.onVerifyProfileNav(_bloc);

    actionBtn() {
      return Row(
        children: [
          Expanded(
            child: primaryButton('Continue', vertical: 14, onPressed: () async {
              _bloc.verifyIdentity(
                firstName: _firstNameTextController.text,
                lastName: _lastNameTextController.text,
                bvn: _bvnTextController.text,
                payoutBankAccNo: _bankAccNoTextController.text,
                payoutBankName: _bankNameTextController.text,
              );
            }),
          ),
        ],
      );
    }

    return BlocConsumer<VerifyIdentityBloc, VerifyIdentityState>(
      bloc: _bloc,
      listener: (context, state) {
        state.join(
          (verifying) => null,
          (verified) => null,
          (error) {
            if (GetUtils.isNullOrBlank(error.genericErr) ?? true)
              print('');
            else
              mSnackBar(context: buildContext, message: error.genericErr);
          },
          (initial) => null,
        );
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
                    boldText('Verify your identity'),
                  ],
                ),
                SizedBox(height: 10),
                mTextField('First name',
                    onChanged: (text) {},
                    controller: _firstNameTextController,
                    error: state.join(
                      (verifying) => '',
                      (verified) => '',
                      (error) => '${error.firstNameErr}',
                      (initial) => '',
                    )),
                SizedBox(height: 8.0),
                mTextField('Last name',
                    onChanged: (text) {},
                    controller: _lastNameTextController,
                    error: state.join(
                      (verifying) => '',
                      (verified) => '',
                      (error) => '${error.lastNameErr}',
                      (initial) => '',
                    )),
                SizedBox(height: 8.0),
                mTextField('BVN number',
                    onChanged: (text) {},
                    controller: _bvnTextController,
                    error: state.join(
                      (verifying) => '',
                      (verified) => '',
                      (error) => '${error.bvnNameErr}',
                      (initial) => '',
                    )),
                mTextField('Payout bank Name',
                    onChanged: (text) {},
                    controller: _bankNameTextController,
                    error: state.join(
                      (verifying) => '',
                      (verified) => '',
                      (error) => '${error.bvnNameErr}',
                      (initial) => '',
                    )),
                mTextField('Payout account number',
                    onChanged: (text) {},
                    controller: _bankAccNoTextController,
                    error: state.join(
                      (verifying) => '',
                      (verified) => '',
                      (error) => '${error.bvnNameErr}',
                      (initial) => '',
                    )),
                SizedBox(height: 20.0),
                state.join(
                  (verifying) => networkActivityIndicator(),
                  (verified) => networkActivityIndicator(),
                  (error) => actionBtn(),
                  (initial) => actionBtn(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bankNameTextController.dispose();
    _lastNameTextController.dispose();
    _bvnTextController.dispose();
    _firstNameTextController.dispose();
    _bankAccNoTextController.dispose();

    super.dispose();
  }
}

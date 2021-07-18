import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'verify_identity_state.dart';

class VerifyIdentityBloc extends Cubit<VerifyIdentityState> {
  ProfileRepository repository;

  VerifyIdentityBloc({required this.repository})
      : super(VerifyIdentityState.initial());

  verifyIdentity({required firstName, required lastName, required bvn}) async {
    this.emit(VerifyIdentityState.verifying());
    if (GetUtils.isNullOrBlank(firstName) ?? true) {
      this.emit(VerifyIdentityState.error(firstName: 'Enter first name'));
      return;
    }

    if (GetUtils.isNullOrBlank(lastName) ?? true) {
      this.emit(VerifyIdentityState.error(lastName: 'Enter last name'));
      return;
    }

    if (GetUtils.isNullOrBlank(bvn) ?? true) {
      this.emit(VerifyIdentityState.error(bvn: 'Enter your bvn'));
      return;
    }

    try {
      var response = await repository.attemptVerification(
          firstName: firstName, lastName: lastName, bvn: bvn);
      if (response is ProfilePODO) {
        this.emit(VerifyIdentityState.created());
      } else {
        this.emit(VerifyIdentityState.error(
            genericErr: 'An error occurred, please try later'));
      }
    } catch (e) {
      this.emit(VerifyIdentityState.error(
          genericErr: 'An error occurred, please try later'));
    }
  }
}

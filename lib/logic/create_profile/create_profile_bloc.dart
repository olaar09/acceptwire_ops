import 'dart:async';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'create_profile_event.dart';

part 'create_profile_state.dart';

class CreateProfileBloc extends Cubit<CreateProfileState> {
  ProfileRepository repository;

  CreateProfileBloc({required this.repository})
      : super(CreateProfileState.initial());

  createProfile({required phoneNumber}) async {
    this.emit(CreateProfileState.creating());
    if (GetUtils.isNullOrBlank(phoneNumber) ?? true) {
      this.emit(CreateProfileState.error(message: 'Please enter phone number'));
      return;
    }

    try {
      var response =
          await repository.createProfileAfterSignUp(phoneNumber: phoneNumber);
      if (response is ProfilePODO) {
        this.emit(CreateProfileState.created());
      } else {
        this.emit(CreateProfileState.error(
            message: 'An error occurred, please try later'));
      }
    } catch (e) {
      this.emit(CreateProfileState.error(message: 'An error occurred'));
    }
  }
}

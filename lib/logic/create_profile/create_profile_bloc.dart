import 'dart:async';
import 'package:acceptwire/podo/profile_podo.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import 'package:acceptwire/repository/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'create_profile_state.dart';

class CreateProfileBloc extends Cubit<CreateProfileState> {
  ProfileRepository repository;
  AuthRepository _authRepository;

  CreateProfileBloc(
      {required this.repository, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(CreateProfileState.initial());

  createProfile({required phoneNumber}) async {
    this.emit(CreateProfileState.creating());
    if (GetUtils.isNullOrBlank(phoneNumber) ?? true) {
      this.emit(CreateProfileState.error(message: 'Please enter phone number'));
      return;
    }

    User? user = await _authRepository.getUser();
    if (GetUtils.isNullOrBlank(user) ?? true)
      return this.emit(CreateProfileState.error(
          message: 'An error occurred, please try later'));

    try {
      var response = await repository.createProfileAfterSignUp(
          phoneNumber: phoneNumber, email: '${user!.email}');
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

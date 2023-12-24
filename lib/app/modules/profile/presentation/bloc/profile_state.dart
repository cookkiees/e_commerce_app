part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final ProfileUserEntity? user;
  final String? error;
  final String? success;
  final String? failure;
  const ProfileState({this.user, this.success, this.error, this.failure});

  @override
  List<Object?> get props => [user, error, failure];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState({super.user, super.success});
}

class ProfileFailureState extends ProfileState {
  const ProfileFailureState({super.failure});
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState({super.error});
}

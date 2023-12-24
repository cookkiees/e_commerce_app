part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  final String? username;
  final dynamic userPhoto;
  final String? password;
  final String? phoneNumber;
  const ProfileEvent(
      {this.username, this.userPhoto, this.password, this.phoneNumber});

  @override
  List<Object?> get props => [username, userPhoto, password, phoneNumber];
}

class ProfileUserEvent extends ProfileEvent {
  const ProfileUserEvent();
}

class ProfileUpdateUserEvent extends ProfileEvent {
  const ProfileUpdateUserEvent({super.username, super.phoneNumber});
}

class ProfileUpdateUserPhotoEvent extends ProfileEvent {
  const ProfileUpdateUserPhotoEvent({super.userPhoto});
}

class ProfileUpdateUserPasswordEvent extends ProfileEvent {
  const ProfileUpdateUserPasswordEvent({super.password});
}

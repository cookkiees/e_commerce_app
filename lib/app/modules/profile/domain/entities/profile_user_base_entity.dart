import 'package:equatable/equatable.dart';

class ProfileUserEntity extends Equatable {
  final String? displayName;
  final String? email;
  final bool? isEmailVerified;
  final bool? isAnonymous;
  final String? creationTime;
  final String? lastSignInTime;
  final String? phoneNumber;
  final String? photoURL;
  final String? dateBirthDay;
  final String? refreshToken;
  final String? uid;

  const ProfileUserEntity({
    this.dateBirthDay,
    this.displayName,
    this.email,
    this.isEmailVerified,
    this.isAnonymous,
    this.creationTime,
    this.lastSignInTime,
    this.phoneNumber,
    this.photoURL,
    this.refreshToken,
    this.uid,
  });

  @override
  List<Object?> get props => [
        displayName,
        email,
        isEmailVerified,
        isAnonymous,
        creationTime,
        lastSignInTime,
        phoneNumber,
        photoURL,
        refreshToken,
        uid,
      ];
}

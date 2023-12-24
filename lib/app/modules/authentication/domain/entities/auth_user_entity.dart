import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String? displayName;
  final String? email;
  final bool? isEmailVerified;
  final bool? isAnonymous;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;
  final String? phoneNumber;
  final String? photoURL;
  final String? refreshToken;
  final String? uid;

  const AuthUserEntity({
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

  Map<String, dynamic> toJson({String? username, String? dateofBirth}) {
    return {
      'display_name': displayName ?? username,
      'date-of-birth': dateofBirth,
      'email': email,
      'is_email_verified': isEmailVerified,
      'is_anonymous': isAnonymous,
      'creation_time': creationTime?.toIso8601String(),
      'last_sign_in_time': lastSignInTime?.toIso8601String(),
      'phone_number': phoneNumber,
      'photo_url': photoURL,
      'refresh_token': refreshToken,
      'uid': uid,
    };
  }
}

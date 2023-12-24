import '../../domain/entities/profile_user_base_entity.dart';

class ProfileUserModels extends ProfileUserEntity {
  const ProfileUserModels({
    super.displayName,
    super.email,
    super.isEmailVerified,
    super.isAnonymous,
    super.dateBirthDay,
    super.creationTime,
    super.lastSignInTime,
    super.phoneNumber,
    super.photoURL,
    super.refreshToken,
    super.uid,
  });

  factory ProfileUserModels.fromJson(Map<String, dynamic> json) {
    return ProfileUserModels(
      displayName: json['display_name'],
      email: json['email'],
      isEmailVerified: json['is_email_verified'],
      isAnonymous: json['is_anonymous'],
      creationTime: json['creation_time'],
      lastSignInTime: json['last_sign_in_time'],
      phoneNumber: json['phone_number'],
      photoURL: json['photo_url'],
      dateBirthDay: json['date-of-birth'],
      refreshToken: json['refresh_token'],
      uid: json['uid'],
    );
  }
}

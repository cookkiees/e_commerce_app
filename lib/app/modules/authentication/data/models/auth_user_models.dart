import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_user_entity.dart';

class AuthUserModels extends AuthUserEntity {
  const AuthUserModels({
    super.displayName,
    super.email,
    super.isEmailVerified,
    super.isAnonymous,
    super.creationTime,
    super.lastSignInTime,
    super.phoneNumber,
    super.photoURL,
    super.refreshToken,
    super.uid,
  });

  factory AuthUserModels.fromUser(User user) {
    return AuthUserModels(
      displayName: user.displayName,
      email: user.email,
      isEmailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
      phoneNumber: user.phoneNumber,
      photoURL: user.photoURL,
      refreshToken: user.refreshToken,
      uid: user.uid,
    );
  }
}

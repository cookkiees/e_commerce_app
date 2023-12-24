part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthUserModels? user;
  final String? error;
  final String? success;
  final String? failure;
  final String? tokenExpire;
  const AuthState(
      {this.user, this.success, this.error, this.failure, this.tokenExpire});

  @override
  List<Object?> get props => [user, error, failure, tokenExpire];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  const AuthSuccessState({super.user, super.success});
}

class AuthFailureState extends AuthState {
  const AuthFailureState({super.failure});
}

class AuthErrorState extends AuthState {
  const AuthErrorState({super.error});
}

class AuthTokenExpireState extends AuthState {
  const AuthTokenExpireState({super.tokenExpire});
}

part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phonenumber;
  final String? password;
  final String? birthday;
  const AuthEvent({
    this.birthday,
    this.phonenumber,
    this.email,
    this.password,
    this.firstname,
    this.lastname,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthSignInGoogleEvent extends AuthEvent {}

class AuthAnonymousEvent extends AuthEvent {}

class AuthSignInPhonenumberEvent extends AuthEvent {
  const AuthSignInPhonenumberEvent({required super.phonenumber});
}

class AuthSignInEvent extends AuthEvent {
  const AuthSignInEvent({required super.email, required super.password});
}

class AuthSignUpEvent extends AuthEvent {
  const AuthSignUpEvent({
    required super.email,
    required super.password,
    required super.firstname,
    required super.lastname,
    required super.birthday,
  });
}

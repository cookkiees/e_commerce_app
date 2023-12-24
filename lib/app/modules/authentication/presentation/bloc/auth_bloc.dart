import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/firebase_service_result_type.dart';
import '../../../../core/helpers/app_logger.dart';
import '../../data/models/auth_user_models.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignInEvent>((event, emit) => handleSingIn(event, emit));
    on<AuthSignUpEvent>((event, emit) => handleSingUp(event, emit));
  }

  Future<AuthUserModels?> handleSingIn(
      AuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final response = await AuthRepositoryImpl.instance.getSignIn(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(AuthSuccessState(user: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(AuthFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(AuthErrorState(error: response.message));
          return response.data;
        case FirebaseResultType.tokenExpire:
          emit(AuthTokenExpireState(tokenExpire: response.message));
          return response.data;
        default:
          return null;
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
      return null;
    }
  }

  Future<AuthUserModels?> handleSingUp(
      AuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final response = await AuthRepositoryImpl.instance.getSignUp(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(AuthSuccessState(
            success: response.message,
            user: response.data,
          ));
          return response.data;
        case FirebaseResultType.failure:
          emit(AuthFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(AuthErrorState(error: response.message));
          return response.data;
        case FirebaseResultType.tokenExpire:
          emit(AuthTokenExpireState(tokenExpire: response.message));
          return response.data;
        default:
          return null;
      }
    } catch (e) {
      AppLogger.logError(e.toString());
      emit(AuthErrorState(error: e.toString()));
      return null;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/firebase_service_result_type.dart';
import '../../data/models/profile_user_base_models.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile_user_base_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileUserEvent>((event, emit) => handleUserData(event, emit));
    on<ProfileUpdateUserEvent>(
        (event, emit) => handleUpdateUserData(event, emit));
  }
  Future<ProfileUserModels?> handleUserData(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final response = await ProfileRepositoryImpl.instance.getUser(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(ProfileSuccessState(user: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(ProfileFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ProfileErrorState(error: response.message));
          return response.data;

        default:
          return null;
      }
    } catch (e) {
      emit(ProfileErrorState(error: e.toString()));
      return null;
    }
  }

  Future<ProfileUserModels?> handleUpdateUserData(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final response = await ProfileRepositoryImpl.instance.updateUser(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(ProfileSuccessState(user: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(ProfileFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ProfileErrorState(error: response.message));
          return response.data;

        default:
          return null;
      }
    } catch (e) {
      emit(ProfileErrorState(error: e.toString()));
      return null;
    }
  }
}

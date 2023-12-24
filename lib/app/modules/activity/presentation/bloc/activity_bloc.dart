import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/app/core/helpers/app_logger.dart';
import 'package:e_commerce_app/app/modules/activity/data/models/activity_base_models.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/firebase_service_result_type.dart';
import '../../data/repositories/activity_repository_impl.dart';
import '../../domain/entities/activity_base_entity.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitialState()) {
    on<ActivityPostEvent>((event, emit) => handlePosActivity(event, emit));
    on<ActivityPutEvent>((event, emit) => handlePutActivity(event, emit));
    on<ActivityGetInitialEvent>(
        (event, emit) => handleActivity(event, emit, true));
    on<ActivityGetRefreshEvent>(
        (event, emit) => handleActivity(event, emit, false));
  }

  Future<void> handleActivity(ActivityEvent event, emit, isLoading) async {
    if (isLoading) {
      emit(ActivityLoadingState());
      await Future.delayed(const Duration(seconds: 1));
    }

    final activity = await prosessGetActivity(event, emit);
    emit(ActivityGetSuccessState(entity: activity));
  }

  Future<ListActivityModels?> prosessGetActivity(
      ActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      final response = await ActivityRepositoryImpl.instance.getActivity();
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(ActivityGetSuccessState(entity: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(ActivityFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ActivityErrorState(error: response.message));
          return response.data;
        default:
          return null;
      }
    } catch (e) {
      emit(ActivityErrorState(error: e.toString()));
      return null;
    }
  }

  Future<ActivityModels?> handlePosActivity(
      ActivityEvent event, Emitter<ActivityState> emit) async {
    emit(ActivityLoadingState());
    try {
      final response =
          await ActivityRepositoryImpl.instance.postActivity(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(ActivityPostSuccessState(entity: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(ActivityFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ActivityErrorState(error: response.message));
          return response.data;

        default:
          return null;
      }
    } catch (e) {
      AppLogger.logError(e.toString());
      emit(ActivityErrorState(error: e.toString()));
      return null;
    }
  }

  Future<ActivityModels?> handlePutActivity(
      ActivityEvent event, Emitter<ActivityState> emit) async {
    emit(ActivityPutLoadingState());
    try {
      final response = await ActivityRepositoryImpl.instance.putActivity(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(const ActivityPutSuccessState());
          return response.data;
        case FirebaseResultType.failure:
          emit(ActivityFailureState(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(ActivityErrorState(error: response.message));
          return response.data;

        default:
          return null;
      }
    } catch (e) {
      AppLogger.logError(e.toString());
      emit(ActivityErrorState(error: e.toString()));
      return null;
    }
  }
}

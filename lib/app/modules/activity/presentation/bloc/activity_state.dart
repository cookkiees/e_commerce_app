part of 'activity_bloc.dart';

sealed class ActivityState extends Equatable {
  final ListActivityEntity? entity;
  final String? failure;
  final String? error;
  const ActivityState({this.entity, this.failure, this.error});

  @override
  List<Object?> get props => [entity, failure, error];
}

class ActivityInitialState extends ActivityState {}

final class ActivityLoadingState extends ActivityState {}

final class ActivityPutLoadingState extends ActivityState {}

final class ActivityErrorState extends ActivityState {
  const ActivityErrorState({super.error});
}

final class ActivityFailureState extends ActivityState {
  const ActivityFailureState({super.failure});
}

class ActivityGetSuccessState extends ActivityState {
  const ActivityGetSuccessState({super.entity});
}

class ActivityPostSuccessState extends ActivityState {
  const ActivityPostSuccessState({super.entity});
}

class ActivityPutSuccessState extends ActivityState {
  const ActivityPutSuccessState();
}

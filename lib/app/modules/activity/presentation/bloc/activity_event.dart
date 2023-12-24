part of 'activity_bloc.dart';

sealed class ActivityEvent extends Equatable {
  final ActivityModels? models;
  const ActivityEvent({this.models});

  @override
  List<Object?> get props => [models];
}

final class ActivityPostEvent extends ActivityEvent {
  const ActivityPostEvent({super.models});
}

final class ActivityPutEvent extends ActivityEvent {
  const ActivityPutEvent({super.models});
}

class ActivityGetInitialEvent extends ActivityEvent {
  const ActivityGetInitialEvent();
}

class ActivityGetRefreshEvent extends ActivityEvent {
  const ActivityGetRefreshEvent();
}

part of 'customers_bloc.dart';

sealed class CustomersEvent extends Equatable {
  final CustomersModels? models;
  const CustomersEvent({this.models});

  @override
  List<Object> get props => [];
}

class CustomersGetInitialEvent extends CustomersEvent {}

class CustomersGetRefreshEvent extends CustomersEvent {}

class CustomersPostEvent extends CustomersEvent {
  const CustomersPostEvent({super.models});
}

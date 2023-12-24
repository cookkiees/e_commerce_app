part of 'customers_bloc.dart';

sealed class CustomersState extends Equatable {
  final ListCustomersEntity? entity;
  final String? error;
  final String? failure;
  const CustomersState({this.error, this.failure, this.entity});

  @override
  List<Object> get props => [];
}

final class CustomersInitial extends CustomersState {}

final class CustomersLoading extends CustomersState {}

final class CustomersError extends CustomersState {
  const CustomersError({super.error});
}

final class CustomersFailure extends CustomersState {
  const CustomersFailure({super.failure});
}

final class CustomersGetSuccess extends CustomersState {
  const CustomersGetSuccess({super.entity});
}

final class CustomersPostSuccess extends CustomersState {
  const CustomersPostSuccess({super.entity});
}

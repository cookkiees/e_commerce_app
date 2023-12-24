import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/app/modules/customers/data/models/customers_models.dart';
import 'package:e_commerce_app/app/modules/customers/domain/entities/customers_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/firebase_service_result_type.dart';
import '../../../../core/helpers/app_logger.dart';
import '../../data/repositories/customers_repository_impl.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc() : super(CustomersInitial()) {
    on<CustomersPostEvent>((event, emit) => handlePosCustomers(event, emit));
    on<CustomersGetInitialEvent>(
        (event, emit) => handleCustomers(event, emit, true));
    on<CustomersGetRefreshEvent>(
        (event, emit) => handleCustomers(event, emit, false));
  }

  Future<void> handleCustomers(CustomersEvent event, emit, isLoading) async {
    if (isLoading) {
      emit(CustomersLoading());
      await Future.delayed(const Duration(seconds: 1));
    }

    final customers = await prosessGetCustomers(event, emit);
    emit(CustomersGetSuccess(entity: customers));
  }

  Future<ListCustomersModels?> prosessGetCustomers(
      CustomersEvent event, Emitter<CustomersState> emit) async {
    try {
      final response = await CustomersRepositoryImpl.instance.getCustomers();
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(CustomersGetSuccess(entity: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(CustomersFailure(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(CustomersError(error: response.message));
          return response.data;
        default:
          return null;
      }
    } catch (e) {
      emit(CustomersError(error: e.toString()));
      return null;
    }
  }

  Future<CustomersModels?> handlePosCustomers(
      CustomersEvent event, Emitter<CustomersState> emit) async {
    emit(CustomersLoading());
    try {
      final response =
          await CustomersRepositoryImpl.instance.postCustomers(event);
      switch (response.resultType) {
        case FirebaseResultType.success:
          emit(CustomersPostSuccess(entity: response.data));
          return response.data;
        case FirebaseResultType.failure:
          emit(CustomersFailure(failure: response.message));
          return response.data;
        case FirebaseResultType.error:
          emit(CustomersError(error: response.message));
          return response.data;

        default:
          return null;
      }
    } catch (e) {
      AppLogger.logError(e.toString());
      emit(CustomersError(error: e.toString()));
      return null;
    }
  }
}

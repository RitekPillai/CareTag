import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/pharmacy/model/homepage/offer_model.dart'
    show PromoCodeValidation;
import 'package:caretag/Modules/pharmacy/model/order/order_list_item.dart'
    show OrderListItem;
import 'package:caretag/Modules/pharmacy/model/order/order_model.dart'
    show Order;
import 'package:caretag/Modules/pharmacy/model_view/repo/pharmacy_repo.dart';
import 'package:caretag/Modules/pharmacy/model_view/repo/oderRepo.dart';
import 'package:flutter/foundation.dart';

part "order_state.dart";
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Authenticationservice authService;
  final Oderrepo oderrepo;

  OrderBloc(this.authService, this.oderrepo) : super(OrderInitial()) {
    on<CreateOrder>(_onCreateOrder);
    on<LoadMyOrders>(_onLoadMyOrders);
    on<LoadOrderDetail>(_onLoadOrderDetail);
    on<ValidatePromoCode>(_onValidatePromoCode);
  }

  Future<void> _onCreateOrder(
    CreateOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final order = await oderrepo.createOrder(
        authService,
        items: event.items,
        deliveryAddress: event.deliveryAddress,
        deliveryInstructions: event.deliveryInstructions,
        prescriptionUrl: event.prescriptionUrl,
        paymentMethod: event.paymentMethod,
        promoCode: event.promoCode,
      );
      emit(OrderCreated(order));
    } catch (e) {
      debugPrint("Error creating order: $e");
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onLoadMyOrders(
    LoadMyOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final orders = await oderrepo.getMyOrders(authService);
      emit(OrdersLoaded(orders));
    } catch (e) {
      debugPrint("Error loading orders: $e");
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onLoadOrderDetail(
    LoadOrderDetail event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final order = await oderrepo.getOrderDetail(authService, event.orderId);
      emit(OrderDetailLoaded(order));
    } catch (e) {
      debugPrint("Error loading order detail: $e");
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onValidatePromoCode(
    ValidatePromoCode event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final validation = await oderrepo.validatePromoCode(
        authService,
        event.code,
        event.orderAmount,
      );
      emit(PromoCodeValidated(validation));
    } catch (e) {
      debugPrint("Error validating promo code: $e");
      emit(OrderError(e.toString()));
    }
  }
}

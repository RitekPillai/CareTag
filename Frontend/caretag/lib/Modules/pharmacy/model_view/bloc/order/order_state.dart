part of 'oder_bloc.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderCreated extends OrderState {
  final Order order;
  OrderCreated(this.order);
}

final class OrdersLoaded extends OrderState {
  final List<OrderListItem> orders;
  OrdersLoaded(this.orders);
}

final class OrderDetailLoaded extends OrderState {
  final Order order;
  OrderDetailLoaded(this.order);
}

final class PromoCodeValidated extends OrderState {
  final PromoCodeValidation validation;
  PromoCodeValidated(this.validation);
}

final class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

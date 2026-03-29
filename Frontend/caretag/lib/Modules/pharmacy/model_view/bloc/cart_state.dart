part of 'cart_bloc.dart';

sealed class CartState {
  final List<CartItem> items;
  final CartSummary? summary;

  CartState({this.items = const [], this.summary});
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {
  CartLoading({super.items, super.summary});
}

final class CartLoaded extends CartState {
  CartLoaded({required super.items, required super.summary});
}

final class CartError extends CartState {
  final String message;
  CartError(this.message, {super.items, super.summary});
}

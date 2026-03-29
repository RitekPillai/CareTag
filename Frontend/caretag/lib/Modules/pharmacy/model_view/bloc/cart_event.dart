part of 'cart_bloc.dart';

sealed class CartEvent {}

final class AddToCart extends CartEvent {
  final Medicine medicine;
  final int quantity;
  AddToCart(this.medicine, {this.quantity = 1});
}

final class RemoveFromCart extends CartEvent {
  final String medicineId;
  RemoveFromCart(this.medicineId);
}

final class UpdateQuantity extends CartEvent {
  final String medicineId;
  final int quantity;
  UpdateQuantity(this.medicineId, this.quantity);
}

final class LoadCart extends CartEvent {}

final class ClearCart extends CartEvent {}

final class RefreshCartSummary extends CartEvent {}

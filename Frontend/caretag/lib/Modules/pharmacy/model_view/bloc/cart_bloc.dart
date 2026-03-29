import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/pharmacy/model/cart/cart_model.dart';
import 'package:caretag/Modules/pharmacy/model/cart/cart_summary.dart';
import 'package:caretag/Modules/pharmacy/model/medicine/medicine_model.dart';
import 'package:caretag/Modules/pharmacy/model_view/repo/cart_repo.dart';
import 'package:flutter/foundation.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Authenticationservice authService;
  final CartRepo cartRepo;
  List<CartItem> _cartItems = [];

  CartBloc(this.authService, this.cartRepo) : super(CartInitial()) {
    on<RefreshCartSummary>(_onRefreshCartSummary);
    on<AddToCart>(_onAddToCart);
    on<LoadCart>(_onLoadCart);
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      final existingIndex = _cartItems.indexWhere(
        (item) => item.medicineId == event.medicine.id,
      );

      ///checking for already exisit items in the cart
      if (existingIndex != -1) {
        _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
          quantity: _cartItems[existingIndex].quantity + event.quantity,
        );
      } else {
        final newItem = CartItem(
          medicineId: event.medicine.id,
          medicineName: event.medicine.name,
          medicineImage: event.medicine.imageUrl,
          packageSize: event.medicine.packageSize,
          price: event.medicine.price,
          discountedPrice: event.medicine.discountedPrice,
          quantity: event.quantity,
          itemTotal:
              (event.medicine.discountedPrice ?? event.medicine.price) *
              event.quantity,
          requiresPrescription: event.medicine.requiresPrescription,
          inStock: event.medicine.inStock,
        );
        _cartItems.add(newItem);
      }

      await _refreshSummary(emit);
    } catch (e) {
      debugPrint("Error adding to cart: $e");
      emit(CartError(e.toString(), items: _cartItems));
    }
  }

  Future<void> _onRefreshCartSummary(
    RefreshCartSummary event,
    Emitter<CartState> emit,
  ) async {
    await _refreshSummary(emit);
  }

  Future<void> _refreshSummary(Emitter<CartState> emit) async {
    if (_cartItems.isEmpty) {
      emit(CartLoaded(items: [], summary: null));
      return;
    }

    emit(CartLoading(items: _cartItems));

    try {
      final summary = await cartRepo.getCartSummary(authService, _cartItems);
      emit(CartLoaded(items: _cartItems, summary: summary));
    } catch (e) {
      debugPrint("Error refreshing cart summary: $e");
      emit(CartError(e.toString(), items: _cartItems));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    await _refreshSummary(emit);
  }
}

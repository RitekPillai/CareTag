import 'package:bloc/bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/pharmacy/model/homepage/offer_model.dart';
import 'package:caretag/Modules/pharmacy/model/homepage/pharmacy_model.dart';
import 'package:caretag/Modules/pharmacy/model/medicine/medicine_category.dart';
import 'package:caretag/Modules/pharmacy/model/medicine/medicine_model.dart';
import 'package:caretag/Modules/pharmacy/model_view/repo/pharmacy_repo.dart';
import 'package:flutter/foundation.dart';

part 'parmacy_event.dart';
part 'parmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  final Authenticationservice authService;
  final PharmacyRepo pharmacyRepo;

  PharmacyBloc(this.authService, this.pharmacyRepo) : super(PharmacyInitial()) {
    on<LoadPharmacyHome>(_onLoadPharmacyHome);
  }

  Future<void> _onLoadPharmacyHome(
    LoadPharmacyHome event,
    Emitter<PharmacyState> emit,
  ) async {
    emit(PharmacyLoading());
    try {
      debugPrint("inside");
      final featured = await pharmacyRepo.getFeaturedMedicines(authService);
      final popular = await pharmacyRepo.getPopularMedicines(authService);
      final offers = await pharmacyRepo.getActiveOffers(authService);
      final pharmacies = await pharmacyRepo.getNearbyPharmacies(authService);
      debugPrint(featured.toString());

      emit(
        PharmacyHomeLoaded(
          featuredProducts: featured,
          popularProducts: popular,
          offers: offers,
          nearbyPharmacies: pharmacies,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("Error loading pharmacy home: $e");
      emit(PharmacyError(e.toString()));
    }
  }
}

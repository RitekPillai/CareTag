part of 'parmacy_bloc.dart';

sealed class PharmacyState {}

final class PharmacyInitial extends PharmacyState {}

final class PharmacyLoading extends PharmacyState {}

final class PharmacyHomeLoaded extends PharmacyState {
  final List<Medicine> featuredProducts;
  final List<Medicine> popularProducts;
  final List<OfferModel> offers;
  final List<PharmacyModel> nearbyPharmacies;

  PharmacyHomeLoaded({
    required this.featuredProducts,
    required this.popularProducts,
    required this.offers,
    required this.nearbyPharmacies,
  });
}

final class CategoriesLoaded extends PharmacyState {
  final List<MedicineCategory> categories;
  CategoriesLoaded(this.categories);
}

final class FeaturedProductsLoaded extends PharmacyState {
  final List<Medicine> products;
  FeaturedProductsLoaded(this.products);
}

final class OffersLoaded extends PharmacyState {
  final List<OfferModel> offers;
  OffersLoaded(this.offers);
}

final class NearbyPharmaciesLoaded extends PharmacyState {
  final List<PharmacyModel> pharmacies;
  NearbyPharmaciesLoaded(this.pharmacies);
}

final class PharmacyError extends PharmacyState {
  final String message;
  PharmacyError(this.message);
}

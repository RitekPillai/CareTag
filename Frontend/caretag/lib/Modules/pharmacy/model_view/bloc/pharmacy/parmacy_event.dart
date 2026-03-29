part of 'parmacy_bloc.dart';

sealed class PharmacyEvent {}

final class LoadPharmacyHome extends PharmacyEvent {}

final class LoadCategories extends PharmacyEvent {}

final class LoadFeaturedProducts extends PharmacyEvent {}

final class LoadPopularProducts extends PharmacyEvent {}

final class LoadActiveOffers extends PharmacyEvent {
  final bool? isNewUser;
  LoadActiveOffers({this.isNewUser});
}

final class LoadNearbyPharmacies extends PharmacyEvent {
  final double? latitude;
  final double? longitude;
  final double? radius;
  LoadNearbyPharmacies({this.latitude, this.longitude, this.radius});
}

import 'dart:convert';

import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/pharmacy/model/homepage/offer_model.dart';
import 'package:caretag/Modules/pharmacy/model/homepage/pharmacy_model.dart';
import 'package:caretag/Modules/pharmacy/model/medicine/medicine_category.dart';
import 'package:caretag/Modules/pharmacy/model/medicine/medicine_detail.dart';
import 'package:caretag/Modules/pharmacy/model/medicine/medicine_model.dart';
import 'package:flutter/foundation.dart';

class PharmacyRepo {
  final String baseUrl =
      "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/paitent/pharmacy";

  Future<List<MedicineCategory>> getAllCategories(
    Authenticationservice authService,
  ) async {
    try {
      final response = await authService.get(Uri.parse("$baseUrl/categories"));
      debugPrint("------------response :${response.body}");
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => MedicineCategory.fromJson(e)).toList();
      }
      throw Exception("Failed to load categories");
    } catch (e) {
      debugPrint("Error getting categories: $e");
      rethrow;
    }
  }

  Future<List<Medicine>> getFeaturedMedicines(
    Authenticationservice authService,
  ) async {
    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/medicines/featured"),
      );
      debugPrint("------------response :${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Medicine.fromJson(e)).toList();
      }
      throw Exception("Failed to load featured medicines");
    } catch (e) {
      debugPrint("Error getting featured medicines: $e");
      rethrow;
    }
  }

  Future<List<Medicine>> getPopularMedicines(
    Authenticationservice authService,
  ) async {
    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/medicines/popular"),
      );
      debugPrint("------------response :${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Medicine.fromJson(e)).toList();
      }
      throw Exception("Failed to load popular medicines");
    } catch (e) {
      debugPrint("Error getting popular medicines: $e");
      rethrow;
    }
  }

  Future<List<Medicine>> getMedicinesByCategory(
    Authenticationservice authService,
    String category,
  ) async {
    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/medicines/category/$category"),
      );
      debugPrint("------------response :${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Medicine.fromJson(e)).toList();
      }
      throw Exception("Failed to load medicines by category");
    } catch (e) {
      debugPrint("Error getting medicines by category: $e");
      rethrow;
    }
  }

  Future<MedicineDetail> getMedicineDetail(
    Authenticationservice authService,
    String medicineId,
  ) async {
    try {
      final response = await authService.get(
        Uri.parse("$baseUrl/medicines/$medicineId"),
      );
      debugPrint("------------response :${response.body}");

      if (response.statusCode == 200) {
        return MedicineDetail.fromJson(jsonDecode(response.body));
      }
      throw Exception("Failed to load medicine detail");
    } catch (e) {
      debugPrint("Error getting medicine detail: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> searchMedicines(
    Authenticationservice authService, {
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? requiresPrescription,
    String? manufacturer,
    String? sortBy,
    int? page,
    int? size,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        if (query != null) 'query': query,
        if (category != null) 'category': category,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
        if (requiresPrescription != null)
          'requiresPrescription': requiresPrescription,
        if (manufacturer != null) 'manufacturer': manufacturer,
        if (sortBy != null) 'sortBy': sortBy,
        'page': page ?? 0,
        'size': size ?? 20,
      };

      final response = await authService.post(
        Uri.parse("$baseUrl/medicines/search"),
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'medicines': (data['medicines'] as List)
              .map((e) => Medicine.fromJson(e))
              .toList(),
          'totalCount': data['totalCount'],
          'currentPage': data['currentPage'],
          'totalPages': data['totalPages'],
        };
      }
      throw Exception("Failed to search medicines");
    } catch (e) {
      debugPrint("Error searching medicines: $e");
      rethrow;
    }
  }

  Future<List<PharmacyModel>> getNearbyPharmacies(
    Authenticationservice authService, {
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    try {
      String url = "$baseUrl/nearby";
      List<String> params = [];
      if (latitude != null) params.add("latitude=$latitude");
      if (longitude != null) params.add("longitude=$longitude");
      if (radius != null) params.add("radius=$radius");
      if (params.isNotEmpty) url += "?${params.join('&')}";

      final response = await authService.get(Uri.parse(url));
      debugPrint("------------response :${response.body}");
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => PharmacyModel.fromJson(e)).toList();
      }
      throw Exception("Failed to load nearby pharmacies");
    } catch (e) {
      debugPrint("Error getting nearby pharmacies: $e");
      rethrow;
    }
  }

  // ============= Offer APIs =============

  Future<List<OfferModel>> getActiveOffers(
    Authenticationservice authService, {
    bool? isNewUser,
  }) async {
    try {
      String url = "$baseUrl/offers";
      if (isNewUser != null) url += "?isNewUser=$isNewUser";

      final response = await authService.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => OfferModel.fromJson(e)).toList();
      }
      throw Exception("Failed to load offers");
    } catch (e) {
      debugPrint("Error getting offers: $e");
      rethrow;
    }
  }
}

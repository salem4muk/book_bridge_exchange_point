import 'package:dio/dio.dart';

import 'api_service.dart';

class DonationService {
  static Future<Response> getWaitedDonationsByPhoneNumber(
      String phoneNumber, String token) async {
    try {
      final response = await ApiService.dio.get(
        '/exchangePoint/bookDonations/getWaitedDonationsByPhoneNumber',
        queryParameters: {'phoneNumber': phoneNumber},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Response> getWaitedReservationsByPhoneNumber(
      String phoneNumber, String token) async {
    try {
      final response = await ApiService.dio.get(
        '/exchangePoint/bookDonations/getWaitedReservationsByPhoneNumber',
        queryParameters: {'phoneNumber': phoneNumber},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Response> confirmReceptionOfWaitedDonations(
      int donationId, String token) async {
    try {
      final response = await ApiService.dio.put(
        '/exchangePoint/bookDonations/confirmReceptionOfWaitedDonations/$donationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Response> rejectByExchangePoint(
      int donationId, String token) async {
    try {
      final response = await ApiService.dio.put(
        '/exchangePoint/bookDonations/RejectByExchangePoint/$donationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Response> confirmDelivery(
      String donationId, String code, String token) async {
    try {
      final response = await ApiService.dio.put(
        '/exchangePoint/bookDonations/confirmDelivery/$donationId',
        queryParameters: {'code': code},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<Response> rejectFromBeneficiary(
      int donationId, String token) async {
    try {
      final response = await ApiService.dio.put(
        '/exchangePoint/bookDonations/RejectFromBeneficiary/$donationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}

import 'dart:developer';

import 'package:book_bridge_exchange_point/models/waited_reservation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../helper/dialog_helper.dart';
import '../models/waited_donation.dart';
import '../services/donation_service.dart';

class DonationController extends GetxController {
  var isLoading = false.obs;
  var isLoadingDelete = false.obs;
  var waitedDonations = List<WaitedDonations>.empty().obs;
  var waitedReservations = List<WaitedReservations>.empty().obs;
  final box = GetStorage();

  Future<List<WaitedDonations>> getWaitedDonationsByPhoneNumber(
      String phoneNumber) async {
    isLoading(true);
    String token = box.read('token') ?? '';
    try {
      var response = await DonationService.getWaitedDonationsByPhoneNumber(
          phoneNumber, token);
      if (response.data['status'] == 'success') {
        var data = response.data['data'] as List;
        List<WaitedDonations> loadedDonations =
            data.map((json) => WaitedDonations.fromJson(json)).toList();
        waitedDonations.addAll(loadedDonations);
        return loadedDonations;
      } else {
        DialogHelper.showDialog(response.data['message']);
        return [];
      }
    } catch (e) {
      log('Failed to load donations $e');
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<List<WaitedReservations>> getWaitedReservationsByPhoneNumber(
      String phoneNumber) async {
    isLoading(true);
    String token = box.read('token') ?? '';
    try {
      var response = await DonationService.getWaitedReservationsByPhoneNumber(
          phoneNumber, token);
      if (response.data['status'] == 'success') {
        var data = response.data['data'] as List;
        List<WaitedReservations> loadedReservations =
            data.map((json) => WaitedReservations.fromJson(json)).toList();
        waitedReservations.addAll(loadedReservations);
        return loadedReservations;
      } else {
        DialogHelper.showDialog(response.data['message']);
        return [];
      }
    } catch (e) {
      log('Failed to load reservations $e');
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<void> confirmReceptionOfWaitedDonations(int donationId) async {
    isLoadingDelete(true);
    String token = box.read('token') ?? '';
    try {
      var response = await DonationService.confirmReceptionOfWaitedDonations(
          donationId, token);
      if (response.data['status'] == 'success') {
        DialogHelper.showDialog("تم استلام التبرع بنجاح");
        // waitedDonations.removeWhere((element) => element.id == donationId);
      } else {
        DialogHelper.showDialog(response.data['message']);
      }
    } catch (e) {
      log('Failed to confirm reception of donation $e');
    } finally {
      isLoadingDelete(false);
    }
  }

  Future<void> rejectByExchangePoint(int donationId) async {
    isLoadingDelete(true);
    String token = box.read('token') ?? '';
    try {
      var response =
          await DonationService.rejectByExchangePoint(donationId, token);
      if (response.data['status'] == 'success') {
        DialogHelper.showDialog("تم رفض التبرع بنجاح");
        // waitedDonations.removeWhere((element) => element.id == donationId);
      } else {
        DialogHelper.showDialog(response.data['message']);
      }
    } catch (e) {
      log('Failed to reject donation $e');
    } finally {
      isLoadingDelete(false);
    }
  }

  Future<void> confirmDelivery(String reservationId, String code) async {
    isLoadingDelete(true);
    String token = box.read('token') ?? '';
    try {
      var response =
          await DonationService.confirmDelivery(reservationId, code, token);
      if (response.data['status'] == 'success') {
        DialogHelper.showDialog("تم استلام الحجز بنجاح");
        // waitedReservations.removeWhere((element) => element.id == reservationId);
      } else {
        DialogHelper.showDialog(response.data['message']);
      }
    } catch (e) {
      log('Failed to confirm reception of reservation $e');
    } finally {
      isLoadingDelete(false);
    }
  }

  Future<void> rejectFromBeneficiary(int reservationId) async {
    isLoadingDelete(true);
    String token = box.read('token') ?? '';
    try {
      var response =
          await DonationService.rejectFromBeneficiary(reservationId, token);
      if (response.data['status'] == 'success') {
        DialogHelper.showDialog("تم رفض الحجز بنجاح");
        // waitedReservations.removeWhere((element) => element.id == reservationId);
      } else {
        DialogHelper.showDialog(response.data['message']);
      }
    } catch (e) {
      log('Failed to reject reservation $e');
    } finally {
      isLoadingDelete(false);
    }
  }
}

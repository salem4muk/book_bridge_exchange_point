
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
 //   Get.lazyPut<DonationController>(() => DonationController());
   // Get.lazyPut<CityController>(() => CityController());
 //   Get.lazyPut<ReservationController>(() => ReservationController());
 //   Get.lazyPut<NotificationController>(() => NotificationController());

    Get.put(AuthController());
    //Get.put(CityController());
  //  Get.put(DonationController());
   // Get.put(NotificationController());
  }
}

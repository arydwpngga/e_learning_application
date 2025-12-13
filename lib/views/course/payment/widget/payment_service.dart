import 'package:e_learning_application/services/dummy_data_service.dart';
import 'package:e_learning_application/views/course/payment/widget/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentService {
  static void processPayment({
    required GlobalKey<FormState> formKey,
    required String courseId,
  }) {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // simulate payment processing
      Future.delayed(const Duration(seconds: 2), () {
        Get.back(); // close loading dialog

        // add the course to purchased course
        DummyDataService.addPurchasedCourse(courseId);

        Get.dialog(
          const PaymentSuccessDialog(),
          barrierDismissible: false,
        );
      });
    }
  }
}

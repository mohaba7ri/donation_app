import 'package:dontations_app/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class ManagePlansController extends GetxController {
  var plans = <Map<String, dynamic>>[].obs;
  var selectedLevel = 1.obs;

  void addPlan() async {
    if (plans.length >= 3) {
      // Get.snackbar('خطأ', 'يمكنك رفع ثلاث خطط فقط.');
      CustomToast.errorToast('يمكنك رفع ثلاث خطط فقط.');
      return;
    }

    if (plans.any((plan) => plan['level'] == selectedLevel.value)) {
      // Get.snackbar('خطأ', 'يجب أن تكون كل خطة من مستوى مختلف.');
      CustomToast.errorToast('يجب أن تكون كل خطة من مستوى مختلف.');
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      plans.add({
        'file': result.files.first,
        'level': selectedLevel.value,
      });
    }
  }

  void deletePlan(int index) {
    plans.removeAt(index);
  }

  void viewPlan(Map<String, dynamic> plan) {
    PlatformFile file = plan['file'];
    OpenFile.open(file.path);
  }
}

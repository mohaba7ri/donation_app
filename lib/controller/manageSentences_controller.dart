import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ManageSentencesController extends GetxController {
  var sentences = <String>[].obs;
  var isExpanded = false.obs;
  var sentenceController = TextEditingController();

  void addSentence(String sentence) {
    if (sentence.isNotEmpty) {
      sentences.add(sentence);
      sentenceController.clear();
    }
  }

  void deleteSentence(int index) {
    sentences.removeAt(index);
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }
}

import 'package:dontations_app/controller/manageSentences_controller.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageSentences extends GetView<ManageSentencesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'إدارة الجمل',
          style: robotoHugeWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    controller.toggleExpansion();
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('انقر لإضافة جملة'),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: controller.sentenceController,
                              textAlign: TextAlign.right,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'أدخل جملة',
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                controller.addSentence(
                                    controller.sentenceController.text);
                              },
                              child: Text('أضف الجملة'),
                            ),
                          ],
                        ),
                      ),
                      isExpanded: controller.isExpanded.value,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.sentences.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          controller.sentences[index],
                          textAlign: TextAlign.right,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteSentence(index);
                          },
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

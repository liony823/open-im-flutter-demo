import 'package:get/get.dart';

class WebviewLogic extends GetxController {
  late String content;
  late String title;
  late String url;

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments['title'];
    url = Get.arguments['url'];
    content = Get.arguments['content'];
  }

  String get webHtml => '''
                      <!DOCTYPE html>
                      <html>
                      <head>
                          <meta name="viewport" content="width=device-width, initial-scale=1.0">
                      </head>
                      <body>
                          $content
                      </body>
                      </html>
                      ''';
}

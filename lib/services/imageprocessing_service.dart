import 'dart:io';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

import '../app/app.logger.dart';

class ImageProcessingService {
  final log = getLogger('ImageProcessing_Service');

  Future<List<String>> getTextFromImage(File image) async {
    log.i("Getting label");
    final _labels = <String>[];

    final inputImage = InputImage.fromFilePath(image.path);
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);

    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      log.i("$index $text $confidence");
      // if (confidence > 0.65) {
      _labels.add(text);
      // }
    }

    imageLabeler.close();

    return _labels;
  }
}

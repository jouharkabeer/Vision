import 'dart:io';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

import '../app/app.logger.dart';

class ImageProcessingService {
  final log = getLogger('ImageProcessing_Service');

  Future<List<String>> getTextFromImage(File image) async {
    log.i("Getting label");
    final _labels = <String>[];
    print(_labels);

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
  List<String> _emotionLabels = [
    'Smile',
    'Fun',
    'Selfie',
    'Cool',
  ];
  List<String> _personLabels = [
    'Smile',
    'Fun',
    'Mouth',
    'Selfie',
    'Eyelash',
    'Beard',
    'Hand',
    'Moustache',
    'Skin',
    'Cool',
    'Ear',
    'Flesh',
    'Hair',
    'Dude',
  ];
  List<String> _saveLabels = [
    'Smile',
    'Fun',
    'Mouth',
    'Selfie',
    'Eyelash',
    'Beard',
    'Hand',
    'Moustache',
    'Skin',
    'Cool',
    'Ear',
    'Hair',
    'Dude',
  ];

  String processLabels(List<String> labeles) {
    if (labeles.isEmpty)
      return "Not recognized";
    check(String value) => labeles.contains(value); // labels & personlabels
    bool res = _personLabels.any(check); // returns true
    print(labeles);
    if (res) {
      return "Person detected";
    } else {
      if (labeles.contains("Dog")) labeles.remove("Dog");
      if (labeles.contains("Musical instrument"))
        labeles.remove("Musical instrument");
      String text = labeles.first;
      return text;
    }
  }
  String saveLabels(List<String> save) {
    if (save.isEmpty) return "Not recognized ";
    check(String value) => save.contains(value);
    bool res = _saveLabels.any(check); // returns true
    print(save);
    if (res) {
      return "person";
    } else {
      return "object";
    }
  }
  String emotionLabels(List<String> emo) {
    if (emo.isEmpty) return "not emotional";
    check(String value) => emo.contains(value);
    bool res = _emotionLabels.any(check);
    // print("cnhjhklcvgkcvjh");
    // print(emo);
    // print("ghjfftuikufkuuy");// returns true
    if (res) {
      if (emo.contains("Smile")){
        return "is smiling";
      }
      else if (emo.contains("Cool")){
        return "is cool";
      }
      else if( emo.contains("FUn")){
        return "is FUNNYy";
      }
      else{
        return "is not happy";
      }
    }
    else {
      return "the emotion cannot be determined";
    }
  }
}

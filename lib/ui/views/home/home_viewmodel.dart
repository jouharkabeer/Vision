import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vision/app/app.router.dart';
import 'package:vision/ui/setup_snackbar_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision/services/regula_service.dart';
import 'package:vision/services/tts_service.dart';


import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../services/imageprocessing_service.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');

  final _snackBarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();
  final TTSService _ttsService = locator<TTSService>();
  final ImageProcessingService _imageProcessingService =
  locator<ImageProcessingService>();
  final _ragulaService = locator<RegulaService>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  File? _image;
  File? get imageSelected => _image;
  List<String> _labels = <String>[];
  List<String> get labels => _labels;
  List<String> _emo = <String>[];
  List<String> get emo => _emo;


  void openInAppView() {
    _navigationService.navigateTo(Routes.inAppView);
  }

  void openHardwareView() {
    _navigationService.navigateTo(Routes.hardwareView);
  }

  void openFaceTrainView() {
    _navigationService.navigateTo(Routes.faceRecView);
  }

  void openLiveView () {
    getImageCamera();
    }

  getImageCamera() async {
    setBusy(true);
    // picking image
    _imageFile = await _picker.pickImage(source: ImageSource.camera);


    if (_imageFile != null) {
      log.i("CCC");
      // _dlibService.addImageFace(await _imageFile!.readAsBytes());
      _image = File(_imageFile!.path);
      getLabel();
    } else {
      _snackBarService.showCustomSnackBar(
          message: "No images selected", variant: SnackbarType.error);
    }
    setBusy(false);
  }


  void getLabel() async {
    setBusy(true);
    log.i("Getting label");
    _labels = <String>[];

    _labels = await _imageProcessingService.getTextFromImage(_image!);

    setBusy(false);

    String text = _imageProcessingService.processLabels(_labels);
    log.i("SPEAK");
    //await _ttsService.speak(text);
    await Future.delayed(const Duration(milliseconds: 500));
    if (text == "Person detected")
      return processFace();
    else
      await _ttsService.speak(text);
  }

  void processFace() async {
    _ttsService.speak("A Human is founded in front of you. Identifying the person with your database");
    setBusy(true);
    _labels = <String>[];

    _emo = await _imageProcessingService.getTextFromImage(_image!);
    String? person = await _ragulaService.checkMatch(_imageFile!.path);
    setBusy(false);
    if (person != null) {
      _labels.clear();
      _labels.add(person);
      notifyListeners();
      String text = _imageProcessingService.emotionLabels(_emo);
      await _ttsService.speak(person+ "is in front of you and the guy" +text);
      await Future.delayed(const Duration(milliseconds: 1500));
    } else {
      await _ttsService.speak("It is an unknown person!");
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    log.i("Person: $person");
  }

  Future speak(String text) async {
    _ttsService.speak(text);
  }


}

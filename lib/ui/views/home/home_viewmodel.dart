import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vision/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');

  // final _snackBarService = locator<SnackbarService>();
  final _navigationService = locator<NavigationService>();

  void openInAppView() {
    _navigationService.navigateTo(Routes.inAppView);
  }

}

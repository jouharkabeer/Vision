import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vision/services/regula_service.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');

  final _navigationService = locator<NavigationService>();
  final _ragulaService = locator<RegulaService>();
  // final _dbService = locator<DbService>();

  void handleStartupLogic() async {
    log.i('Startup');
    _ragulaService.initPlatformState();

    await Future.delayed(const Duration(milliseconds: 800));
    // if (isUserLoggedIn) {
    //   log.d('Logged in user available');
    _navigationService.replaceWith(Routes.homeView);
    // } else {
    //   log.d('No logged in user');
    // }
  }

}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/services/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'app.dart';
import 'controllers/authentication_controller.dart';


NetworkCaller setUpNetworkClient() {
  return NetworkCaller(
    onUnAuthorize: _onUnAuthorize,
    // TODO token save kora
    accessToken: () {
      return Get.find<AuthenticationController>().accessToken ?? '';
    },
  );
}

Future<void> _onUnAuthorize() async {
  // TODO Redirect to login and remove cache
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.name,
    (predicate) => false,
  );
}

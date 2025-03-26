import 'package:otpless_flutter/otpless_flutter.dart';

abstract class OtplessService {
  Future<OtplessCredintial> signUpWithWhatsup();
}

class OtplessServiceImpl extends OtplessService {
  OtplessServiceImpl({required this.otplessModel});
  final OtplessCredintial otplessModel;
  final otplessFlutterPlugin = Otpless();
  Map<String, dynamic> arg = {
    'appId': 'BBM40CTP782B4FYQGFXR',
  };

  @override
  Future<OtplessCredintial> signUpWithWhatsup() async {
    otplessFlutterPlugin.openLoginPage(
      (result) {
        if (result['data'] != null) {
          otplessModel.token = result['response']['token'];
          otplessModel.phoneNumber =
              result['data']['identities'][0]['identityValue'];
        } else {
          otplessModel.errMessage = result['errorMessage'];
        }
      },
      arg,
    );
    return otplessModel;
  }
}

class OtplessCredintial {
  String? token;
  String? errMessage;
  String? phoneNumber;
  OtplessCredintial(
    this.token,
    this.errMessage,
    this.phoneNumber,
  );
}

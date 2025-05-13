/// from client side
abstract class LocalStatusCodes {
  static const int connectionError = 1000;
  static const int connectionTomeout = 1001;
  static const int sendTimeout = 1002;
  static const int receiveTimeout = 1003;
  static const int badCertificate = 1004;
  static const int cancel = 1005;
  static const int unKnown = 1006;
}

abstract class RemoteStatusCodes {
  static const int badReqest = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int notValidation = 422;
  static const int internalServer = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
}

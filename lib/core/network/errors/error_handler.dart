import 'package:project/core/network/errors/error_model.dart';

abstract class ErrorHandler {
  ErrorModel handle(dynamic e);
}

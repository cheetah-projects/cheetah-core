import 'dart:io';

abstract class CheetahException implements Exception {
  final String message;
  final int? code;
  final Exception? cause;

  CheetahException(this.message, {this.code, this.cause});

  @override
  String toString() {
    return '[CheetahException] Code: ${code ?? "N/A"}, Message: $message, Cause: ${cause?.toString() ?? "None"}';
  }
}

class ConfigurationException extends CheetahException {
  ConfigurationException(super.message, {super.cause})
      : super(code: 1001);
}

class DependencyInjectionException extends CheetahException {
  DependencyInjectionException(super.message, {super.cause})
      : super(code: 1002);
}

class NotFoundException extends CheetahException {
  NotFoundException(super.message, {super.cause})
      : super(code: 1003);
}

class UnauthorizedException extends CheetahException {
  UnauthorizedException(super.message, {super.cause})
      : super(code: 1004);
}

class BadRequestException extends CheetahException {
  BadRequestException(super.message, {super.cause})
      : super(code: 1005);
}

class InternalServerException extends CheetahException {
  InternalServerException(super.message, {super.cause})
      : super(code: 1006);
}

class CheetahErrorHandler {
  static void handle(Exception error, {StackTrace? stackTrace}) {
    if (error is CheetahException) {
      print('[ERROR] ${error.toString()}');
    } else {
      print('[UNKNOWN ERROR] ${error.toString()}');
    }

    if (stackTrace != null) {
      print('[STACKTRACE] $stackTrace');
    }
  }

  static int getHttpStatusCode(Exception error) {
    if (error is NotFoundException) return HttpStatus.notFound;
    if (error is UnauthorizedException) return HttpStatus.unauthorized;
    if (error is BadRequestException) return HttpStatus.badRequest;
    if (error is InternalServerException) return HttpStatus.internalServerError;
    return HttpStatus.internalServerError; // Default for unknown errors
  }
}

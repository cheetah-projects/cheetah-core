import 'dart:io';
import 'package:intl/intl.dart';

enum LogLevel { debug, info, warning, error, critical }

class Logger {
  final String name;
  LogLevel level;

  Logger(this.name, {this.level = LogLevel.info});

  void log(LogLevel logLevel, String message, {Object? error, StackTrace? stackTrace}) {
    if (logLevel.index >= level.index) {
      final timestamp = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now());
      final logMessage = '[$timestamp] [${logLevel.name.toUpperCase()}] [$name] $message';

      if (logLevel.index >= LogLevel.error.index) {
        stderr.writeln(logMessage);
      } else {
        stdout.writeln(logMessage);
      }

      if (error != null) {
        stderr.writeln('Error: $error');
      }
      if (stackTrace != null) {
        stderr.writeln('StackTrace: $stackTrace');
      }
    }
  }

  void debug(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.debug, message, error: error, stackTrace: stackTrace);

  void info(String message) => log(LogLevel.info, message);

  void warning(String message) => log(LogLevel.warning, message);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.error, message, error: error, stackTrace: stackTrace);

  void critical(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.critical, message, error: error, stackTrace: stackTrace);
}

class LoggerFactory {
  static final Map<String, Logger> _loggers = {};

  static Logger getLogger(String name) {
    return _loggers.putIfAbsent(name, () => Logger(name));
  }
}

final logger = LoggerFactory.getLogger('CheetahCore');

import 'package:logger/logger.dart';

// It's not in use
class AppLogger {
  static final Logger _logger = Logger(
    level: Level.debug, // Set the logging level (e.g., verbose, debug, info, warning, error, wtf)
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to display
      errorMethodCount: 8, // Number of error method calls to display
      lineLength: 120, // Width of the log lines
    ),
  );

  static void v(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }
}
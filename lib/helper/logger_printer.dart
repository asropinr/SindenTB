import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    return [color!('$emoji $className - ${event.message}')];
  }
}

class MyProdFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class DiGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();
    for (final element in library.allElements) {
      if (element is ClassElement) {
        for (final annotation in element.metadata) {
          final value = annotation.computeConstantValue();
          if (value != null &&
              value.type?.getDisplayString(withNullability: false) == 'Service') {
            buffer.writeln('register${element.name}();');
          }
        }
      }
    }
    return buffer.toString();
  }
}

Builder diBuilder(BuilderOptions options) =>
    LibraryBuilder(DiGenerator(), generatedExtension: '.di.g.dart');

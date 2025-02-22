import 'dart:async';
import 'package:build_runner/build_runner.dart' as runner;
import 'package:build_runner_core/build_runner_core.dart' as core;
import 'package:build_config/build_config.dart';
import 'package:cheetah_core/src/di_generator/builder.dart' as di_builder;
import 'package:cheetah_core/src/config_generator/builder.dart' as config_builder;

Future<void> main(List<String> args) async {
  final builders = [
    core.apply(
      'cheetah_core|di_builder',
      [di_builder.diBuilder],
      core.toRoot(),
      hideOutput: false,
      defaultGenerateFor: const InputSet(include: ['lib/**']),
    ),
    core.apply(
      'cheetah_core|config_builder',
      [config_builder.configBuilder],
      core.toRoot(),
      hideOutput: false,
      defaultGenerateFor: const InputSet(include: ['lib/**']),
    ),
  ];
  await runner.run(args, builders);
}

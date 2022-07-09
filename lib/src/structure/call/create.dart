import 'package:sudorpc/src/structure/call/base.dart';
import 'package:sudorpc/src/structure/call/v1.dart';

SudoRPCCall createSudoRPCCallFromJson(Map<String, dynamic> json) {
  if (json['version'] == "1.0") {
    return SudoRPCCallV1.fromJson(json);
  }
  throw Exception('Unknown version: ${json['version']}');
}

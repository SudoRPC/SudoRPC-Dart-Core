import 'package:sudorpc/src/structure/return/base.dart';
import 'package:sudorpc/src/structure/return/v1.dart';

SudoRPCReturn createSudoRPCReturnFromJson(Map<String, dynamic> json) {
  if (json['version'] == "1.0") {
    if (json['success']) {
      return SudoRPCReturnV1Success.fromJson(json);
    } else {
      return SudoRPCReturnV1Fail.fromJson(json);
    }
  }
  throw Exception('Unknown version: ${json['version']}');
}

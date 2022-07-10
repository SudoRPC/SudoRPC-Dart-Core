import 'package:sudorpc/src/call/declare.dart';
import 'package:sudorpc/src/structure/return/v1.dart';

class SudoRPCCallCallback {
  final SudoRPCCallCallbackResolver resolver;
  final SudoRPCCallCallbackRejector rejector;

  SudoRPCCallCallback({
    required this.resolver,
    required this.rejector,
  });

  void resolve(Map<String, dynamic> result) {
    resolver(result);
  }

  void reject(List<SudoRPCReturnV1ErrorItem> errors) {
    rejector(errors);
  }
}

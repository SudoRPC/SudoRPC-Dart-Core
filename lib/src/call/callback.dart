import 'package:sudorpc/src/call/declare.dart';
import 'package:sudorpc/src/structure/return/v1.dart';

class SudoRPCCallCallback {
  final SudoRPCCallCallbackResolver resolver;
  final SudoRPCCallCallbackRejector rejector;

  SudoRPCCallCallback({
    required this.resolver,
    required this.rejector,
  });

  void resolve(
    final Map<String, dynamic> result,
  ) {
    resolver(result);
  }

  void reject(
    final List<SudoRPCReturnV1ErrorItem> errors,
  ) {
    rejector(errors);
  }
}

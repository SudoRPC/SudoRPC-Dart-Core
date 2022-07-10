import 'package:sudorpc/src/structure/return/v1.dart';

typedef SudoRPCCallCallbackResolver = void Function(
  Map<String, dynamic> result,
);

typedef SudoRPCCallCallbackRejector = void Function(
  List<SudoRPCReturnV1ErrorItem> errors,
);

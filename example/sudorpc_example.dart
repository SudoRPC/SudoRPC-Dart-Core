import 'package:sudorpc/sudorpc.dart';

void main() {
  // ignore: unused_local_variable
  SudoRPCCall call = createSudoRPCCallFromJson(
    {
      'version': '1.0',
      'resource': 'resource',
      'identifier': 'identifier',
      'metadata': 'metadata',
      'payload': 'payload',
    },
  );
}

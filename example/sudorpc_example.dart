import 'package:sudorpc/sudorpc.dart';

void main() {
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

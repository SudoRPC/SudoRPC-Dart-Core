import 'package:sudorpc/sudorpc.dart';
import 'package:test/test.dart';

void main() {
  group('Given {SudoRPCCall} Class', () {
    test('create a call - sad path', () {
      expect(() {
        createSudoRPCCallFromJson(
          {
            'version': '1.0',
            'resource': 'resource',
            'identifier': 'identifier',
            'metadata': null,
            'payload': {
              'key': 'value',
            },
          },
        );
      }, throwsA(TypeMatcher<SudoRPCInvalidInputException>()));
    });

    SudoRPCCall call = createSudoRPCCallFromJson(
      {
        'version': '1.0',
        'resource': 'resource',
        'identifier': 'identifier',
        'metadata': {
          'key': 'value',
        },
        'payload': {
          'key': 'value',
        },
      },
    );

    test('call is creatable - happy path', () {
      expect(call, isA<SudoRPCCall>());
    });

    test('get metadata value from call', () {
      String value = (call as SudoRPCCallV1).metadata['key'];

      expect(value, equals('value'));
    });

    test('get payload value from call', () {
      String value = (call as SudoRPCCallV1).payload['key'];

      expect(value, equals('value'));
    });
  });
}

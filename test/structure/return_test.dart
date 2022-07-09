import 'package:sudorpc/sudorpc.dart';
import 'package:test/test.dart';

void main() {
  group('Given {SudoRPCReturn} Class', () {
    test('create a return - sad path', () {
      expect(() {
        createSudoRPCReturnFromJson(
          {
            'version': '1.0',
            'identifier': 'identifier',
          },
        );
      }, throwsA(TypeMatcher<SudoRPCInvalidInputException>()));
    });

    SudoRPCReturn successReturn = createSudoRPCReturnFromJson(
      {
        'version': '1.0',
        'identifier': 'identifier',
        'success': true,
        'result': {
          'key': 'value',
        },
      },
    );

    SudoRPCReturn failReturn = createSudoRPCReturnFromJson(
      {
        'version': '1.0',
        'identifier': 'identifier',
        'success': false,
        'errors': [
          {
            'isInternalError': true,
            'error': 'code',
            'message': 'message',
          },
        ],
      },
    );

    test('return is creatable - happy path', () {
      expect(successReturn, isA<SudoRPCReturn>());
      expect(failReturn, isA<SudoRPCReturn>());
    });

    test('get success result value from return', () {
      String value = (successReturn as SudoRPCReturnV1Success).result['key'];

      expect(value, equals('value'));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_cyttek/core/packages/formz_package/description.dart'
    as custom;

void main() {
  group('Description', () {
    test('returns error when empty', () {
      const input = custom.Description.dirty('');
      expect(input.error, custom.DescriptionError.empty);
    });

    test('returns valid when it has text', () {
      const input = custom.Description.dirty('Una descripción');
      expect(input.error, isNull);
    });

    test('returns error when only spaces', () {
      const input = custom.Description.dirty('   ');
      expect(input.error, custom.DescriptionError.empty);
    });
  });
}

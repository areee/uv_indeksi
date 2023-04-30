import 'package:flutter_test/flutter_test.dart';
import 'package:uv_indeksi/uv_service.dart';

void main() {
  group('When fetching UV from API', () {
    test('Data is not null', () async {
      var uv = await fetchUV();

      expect(uv, isNotNull);
      expect(uv.time, isNotNull);
      expect(uv.value, isNotNull);
    });

    test('Data is valid', () async {
      var uv = await fetchUV();

      expect(uv.time, isA<DateTime>());
      expect(uv.value, isA<double>());
    });
  });
}

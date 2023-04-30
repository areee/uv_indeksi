import 'package:flutter_test/flutter_test.dart';
import 'package:uv_indeksi/uv_service.dart';

void main() {
  test('Read UV data from API', () async {
    var uv = await fetchUV();

    expect(uv, isNotNull);
    expect(uv.time, isNotNull);
    expect(uv.value, isNotNull);
  });
}

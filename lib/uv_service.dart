import 'package:http/http.dart' as http;
import 'package:uv_indeksi/uv_class.dart';
import 'package:xml/xml.dart';

/// Fetches UV data from the FMI open data API.
Future<UV> fetchUV() async {
  final response = await http.get(Uri.parse(
      'https://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::radiation::timevaluepair&fmisid=101004&parameters=UVB_U&'));

  if (response.statusCode == 200) {
    final latestUV = XmlDocument.parse(response.body)
        .findAllElements('wml2:MeasurementTVP')
        .last;

    final localTime = DateTime.parse(
            latestUV.getElement('wml2:time')?.text ?? DateTime.now().toString())
        .toLocal();

    final value = double.parse(latestUV.getElement('wml2:value')?.text ?? '-1');

    return UV(localTime, value);
  } else {
    throw Exception('Failed to load UV data');
  }
}

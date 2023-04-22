// Purpose: UVService that gets UV data from the FMI open data API.

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

// Future<UV> fetchUV() async {
Future<void> fetchUV() async {
  final response = await http.get(Uri.parse(
      'https://opendata.fmi.fi/wfs?service=WFS&version=2.0.0&request=getFeature&storedquery_id=fmi::observations::radiation::timevaluepair&fmisid=101004&parameters=UVB_U&timezone=Europe/Helsinki&'));

  if (response.statusCode == 200) {
    final document = XmlDocument.parse(response.body);
    final timeValues = document.findAllElements('wml2:MeasurementTVP');
    // TODO: Get the latest UV value from the timeValues list.
  } else {
    throw Exception('Failed to load UV data');
  }
}

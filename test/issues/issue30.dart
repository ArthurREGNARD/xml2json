import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:xml2json/xml2json.dart';

void main() {
  test('Should be escaped', () {
    var xml = '<post tag="\\m/"/>';
    final xml2json = Xml2Json()..parse(xml);
    final data = xml2json.toGData();
    final expected = '{"post": {"tag": "\\m/"}}';
    expect(data, equals(expected));
  });

  test('Real decode', () async {
    final uri = Uri.parse(
        'https://safebooru.org/index.php?page=dapi&s=post&q=index&tags=%20m/');
    final httpClient = HttpClient();
    final req = await httpClient.getUrl(uri);
    final rsp = await req.close();
    final xml = await rsp.transform(utf8.decoder).join();

    final xml2json = Xml2Json()..parse(xml);
    final data = xml2json.toGData();
    jsonDecode(data);
  });
}

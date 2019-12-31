/*
 * Package : xml2json
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/09/2013
 * Copyright :  S.Hamblett@OSCF
 */

part of xml2json;

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: cascade_invocations
// ignore_for_file: avoid_print

/// The Xml2Json class provides a means of parsing XML data and transforming the
/// resultant element tree into the following popular JSON XML formats :-
///
/// Parker
/// Badgerfish
/// GData
///
/// The XML parser used is the one supplied by the xml package.
///
/// Functionality splits XML parsing out from transformation to JSON
/// so as to allow clients to extract intermediate results if needed
/// and to transform into more than one JSON XML format without re-parsing.
///
/// Note this package is intended for use as a one way transform only,
/// it does not guarantee the resulting JSON string can be parsed back
/// into valid XML.
///
/// See the individual transform classes for further documentation, however, all
/// the transform functions convert XML data into JSON strings, so numbers
/// such as <mynumber>150</mynumber> become { "mynumber" : "150" } not { "mynumber" : 150 }
///
/// If you're translating from ATOM then Badgerfish and GData are the
/// better ones to use as they are less lossy.
///
/// Usage is :-
///
/// Xml2Json jsonTransform = new Xml2Json();
/// jsonTransform.parse(xmlString);
/// String jsonString = jsonTransform.toXxxxxxx();
///
///  Any exceptions thrown by the parser/transformers are re-thrown as instances of
///  Xml2JsonException.
class Xml2Json {
  XmlDocument _result;

  /// The parser result
  XmlDocument get xmlParserResult => _result;

  /// Parse an XML string
  void parse(String xmlString) {
    _result = null;
    final String xmlStringPrep = _Xml2JsonUtils.prepareXmlString(xmlString);
    try {
      _result = xml.parse(xmlStringPrep);
    } on Object {
      const String errorString = 'parse error - invalid XML';
      throw Xml2JsonException(errorString);
    }
  }

  /// Badgerfish transformer
  String toBadgerfish() {
    if (_result == null) {
      throw Xml2JsonException('toBadgerfish - no parse result');
    }

    String json;
    final _Xml2JsonBadgerfish badgerfishTransformer = _Xml2JsonBadgerfish();
    try {
      json = badgerfishTransformer.transform(_result);
    } on Exception catch (e) {
      throw Xml2JsonException('toBadgerfish error => ${e.toString()}');
    }

    return json;
  }

  /// Parker transformer
  String toParker() {
    if (_result == null) {
      throw Xml2JsonException('toParker - no parse result');
    }

    String json;
    final _Xml2JsonParker parkerTransformer = _Xml2JsonParker();
    try {
      json = parkerTransformer.transform(_result);
    } on Exception catch (e) {
      throw Xml2JsonException('toParker error => ${e.toString()}');
    }

    return json;
  }

  /// GData transformer
  String toGData() {
    if (_result == null) {
      throw Xml2JsonException('toGData - no parse result');
    }

    String json;
    final _Xml2JsonGData gDataTransformer = _Xml2JsonGData();
    try {
      json = gDataTransformer.transform(_result);
    } on Exception catch (e) {
      throw Xml2JsonException('toGData error => ${e.toString()}');
    }

    return json;
  }
}

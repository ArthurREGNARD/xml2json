/*
 * Package : xml2json
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/09/2013
 * Copyright :  S.Hamblett@OSCF
 * 
 * The Xml2Json class provids a means of parsing XML data and transforming the
 * resultant element tree into the following popular JSON XML formats :-
 * 
 * Parker
 * Badgerfish
 * GData
 * 
 * The XML parser used is the one supplied by the petitparser package.
 * 
 * Functionality splits XML parsing out from transformation to JSON so as to allow
 * clients to extract intermediate results if needed and to transform into more than
 * one JSON XML format without re-parsing.
 * 
 * Note this package is intended for use as a one way transform only, it does not
 * guarantee the resulting JSON string can be parsed back into valid XML.
 * 
 * See the individual transform classes for further documentation, however, all
 * the transform functions convert XML data into JSON strings, so numbers such as
 * <mynumber>150</mynumber> become { "mynumber" : "150" } not { "mynumber" : 150 }
 * 
 * If your translating from ATOM then Badgerfish and GData are the better ones
 * to use as they are less lossy.
 * 
 * Usage is :-
 * 
 * Xml2Json jsonTransform = new Xml2Json();
 * jsonTransform.parse(xmlString);
 * String jsonString = jsonTransform.toXxxxxxx();
 *  
 *  Any exceptions thrown by the parser/transformers are re-thrown as instances of
 *  Xml2JsonException. 
 */

part of xml2json;

class Xml2Json {
  
  XmlDocument _result = null;
  /**
   * The parser result
   */
  get xmlParserResult => _result;
  
  /**
   * Parse an XML string
   */
  void parse(String xmlString) {
    
    _result = null;
    xmlString = _Xml2JsonUtils.prepareXmlString(xmlString);
    try {
      _result = xml.parse(xmlString);
    } catch(e) {
      String errorString = "parse error - invalid XML, ${e.message}";
      throw new Xml2JsonException(errorString);
    }
      
  }
  
  
  /**
   * Badgerfish transformer
   */
  String toBadgerfish() {
    
    if ( _result == null ) {
      
      throw new Xml2JsonException("toBadgerfish - no parse result");
    }
    
    String json = null;
    _Xml2JsonBadgerfish badgerfishTransformer = new _Xml2JsonBadgerfish();
    try {
      
      json = badgerfishTransformer.transform(_result);
      
    } catch(e) {
      
      throw new Xml2JsonException("toBadgerfish error => ${e.toString()}");
    }
    
    return json;
    
  }
  
  /**
   * Parker transformer
   */
  String toParker() {
    
    if ( _result == null ) {
      
      throw new Xml2JsonException("toParker - no parse result");
    }
        
    String json = null;
    _Xml2JsonParker parkerTransformer = new _Xml2JsonParker();
    try {
      
      json = parkerTransformer.transform(_result);
      
    } catch(e) {
      
      throw new Xml2JsonException("toParker error => ${e.toString()}");
    }
    
    return json;
    
    
  }
  
  /**
   * GData transformer
   */
  String toGData() {
    
    if ( _result == null ) {
      
      throw new Xml2JsonException("toGData - no parse result");
    }
    
    String json = null;
    _Xml2JsonGData GDataTransformer = new _Xml2JsonGData();
    try {
      
      json = GDataTransformer.transform(_result);
      
    } catch(e) {
      
      throw new Xml2JsonException("toGData error => ${e.toString()}");
    }
    
    return json;

  }
  
  
}
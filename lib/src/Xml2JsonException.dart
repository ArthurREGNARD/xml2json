/*
 * Packge : xml2json
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/09/2013
 * Copyright :  S.Hamblett@OSCF
 *
 * This exception is thrown when Xml2Json has an internal error, such as an invalid
 * parameter being passed to a function.
 */

part of xml2json;

class Xml2JsonException implements Exception {
  String _message = 'No Message Supplied';
  Xml2JsonException([this._message]);
  
  String toString() => "Xml2JsonException: message = ${_message}";
}

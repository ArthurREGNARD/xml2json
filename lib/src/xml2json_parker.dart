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
// ignore_for_file: avoid_annotating_with_dynamic

/// Parker transform class, see Transforming Details.md document in the
/// examples directory for further details.
class _Xml2JsonParker {
  /// Parker transformer function.
  Map<dynamic, dynamic> _transform(dynamic node, dynamic objin) {
    Map<dynamic, dynamic> obj = objin;
    if (node is XmlElement) {
      final String nodeName = '"${node.name.qualified}"';
      if (obj[nodeName] is List) {
        obj[nodeName].add(<dynamic, dynamic>{});
        obj = obj[nodeName].last;
      } else if (obj[nodeName] is Map) {
        obj[nodeName] = <dynamic>[obj[nodeName], <dynamic, dynamic>{}];
        obj = obj[nodeName].last;
      } else {
        if (node.children.isNotEmpty) {
          if (node.children[0] is XmlText) {
            final String sanitisedNodeData =
                _Xml2JsonUtils.escapeTextForJson(node.children[0].text);
            String nodeData = '"$sanitisedNodeData"';
            if (nodeData.isEmpty) {
              nodeData = null;
            }
            obj[nodeName] = nodeData;
          } else if (node.children[0] is XmlCDATA) {
            final String sanitisedNodeData =
                _Xml2JsonUtils.escapeTextForJson(node.children[0].text);
            String nodeData = '"$sanitisedNodeData"';
            if (nodeData.isEmpty) {
              nodeData = null;
            }
            obj[nodeName] = nodeData;
          } else {
            obj[nodeName] = <dynamic, dynamic>{};
            obj = obj[nodeName];
          }
        } else {
          /* No children, empty element */
          obj[nodeName] = null;
        }
      }

      for (int j = 0; j < node.children.length; j++) {
        _transform(node.children[j], obj);
      }
    } else if (node is XmlDocument) {
      for (int j = 0; j < node.children.length; j++) {
        _transform(node.children[j], obj);
      }
    }

    return obj;
  }

  /// Transformer function
  String transform(XmlDocument xmlNode) {
    Map<dynamic, dynamic> json;
    try {
      json = _transform(xmlNode, <dynamic, dynamic>{});
    } on Exception catch (e) {
      throw Xml2JsonException(
          'Parker internal transform error => ${e.toString()}');
    }

    return json.toString();
  }
}

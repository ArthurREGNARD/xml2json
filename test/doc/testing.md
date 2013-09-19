# Xml2Json Testing 

Testing of this package is split into two areas, standard unittest driven tests and an interactive
test page allowing arbitrary chunks of XML to be transformed using one og the transformers.

## Unittest Tests

Just run xml2json.html in Dartium, the test page should show all the test as passing.
The test strings for the tests are in the file 'xml2json_test_strings.dart' for the curious.

## Interactive tests

Run xml2json_interactive.html in Dartium, paste your XML into the top text area, select
a transform and press 'Transform', the resulting Json appears in the lower test area.
Any errors detected will appear in red under the button row at the bottom. You can clear the
Json output and the error area using the 'Clear JSON' button.

Beware that if you copy and paste XML from web pages be sure to paste as 'plain text', otherwise
embedded control characters may not allow the XML to be parsed, even if you do this it will 
sometimes fail, characteristically this will fail to parse at 'position 1'.

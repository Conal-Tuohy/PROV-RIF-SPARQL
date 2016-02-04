#!/bin/sh
# The "--fail" option is used to specify that server error reports should be swallowed rather than over-writing an existing CSV file
# Headers specify that the content is SPARQL and that the desired output is CSV.
# The "--data-binary" option specifies that the SPARQL file should be sent as is, without stripping end of line markers as "--data" would.
# The "-X POST" option specifies an HTTP POST.
curl -X POST --fail --header "Accept: text/csv" --header "Content-Type: application/sparql-query" --data-binary "@sparql/nodes.rq" --output "nodes.csv" http://prov-data.conaltuohy.com/fuseki/prov/query
curl -X POST --fail --header "Accept: text/csv" --header "Content-Type: application/sparql-query" --data-binary "@sparql/function-agency-relationships.rq" --output "agency-functions.csv" http://prov-data.conaltuohy.com/fuseki/prov/query

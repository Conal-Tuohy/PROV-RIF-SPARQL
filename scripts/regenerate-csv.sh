#!/bin/sh
# The "--fail" option is used to specify that server error reports should be swallowed rather than over-writing an existing CSV file
# Headers specify that the content is SPARQL and that the desired output is CSV.
# The "--data-binary" option specifies that the SPARQL file should be sent as is, without stripping end of line markers as "--data" would.
# The "-X POST" option specifies an HTTP POST.
curl -X POST --fail --header "Accept: text/csv" --header "Content-Type: application/sparql-query" --data-binary "@nodes.rq" --output "/var/www/html/provisualizer/data/nodes.csv" http://localhost:8080/fuseki/prov/query
curl -X POST --fail --header "Accept: text/csv" --header "Content-Type: application/sparql-query" --data-binary "@edges.rq" --output "/var/www/html/provisualizer/data/edges.csv" http://localhost:8080/fuseki/prov/query

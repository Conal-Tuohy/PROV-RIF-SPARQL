#!/bin/sh
# Starts the OAI-PMH harvester / RDF crosswalk / SPARQL Graph Store depositor
# by making an HTTP POST request to a web application called "harvester", 
# passing in a set of HTML form parameters:
# baseURI = the OAI-PMH repository (Research Data Australia)
# metadataPrefix = the format we want to receive the metadata in (RIF-CS)
# set = the subset of the repository's data we wish to harvest (just PROV's data)
# graphStore = the SPARQL graph store where resulting graphs are to be stored
# resourceBaseURI = a prefix used for minting identifiers for RDF resources
# the final URI is the location of the harvester web application which will process this request.
# The result of the request is a copy of the response which the harvester received from the OAI-PMH server,
# which is simply logged.
curl -X POST \
--output "response.xml"
--data-urlencode "baseURI=https://researchdata.ands.org.au/registry/services/oai" \
--data-urlencode "metadataPrefix=rif" \
--data-urlencode "set=group:Public0x20Record0x20Office0x20Victoria" \
--data-urlencode "graphStore=http://localhost:8080/fuseki/prov/data" \
--data-urlencode "resourceBaseURI=http://metadata.prov.vic.gov.au/resource/" \
http://localhost:8080/harvester/

# PROV-RIF-SPARQL

This software republishes metadata records as Linked Data.

*NB: the acronym PROV here refers to the Public Record Office Victoria, which is the state archive of the Australian State of Victoria; it is not related to the W3C PROV ontology used to model the provenance of digital information.*

The traditional metadata access protocol OAI-PMH is often used in the cultural heritage community to publish metadata records for their collections. The records are expressed as XML documents, and the OAI-PMH protocol provides the records as a long list, which can be downloaded page by page, and can be filtered by date range in order to retrieve only records which were created or updated at particular times. The protocol is optimised for maintaining up-to-date copies of the data in a central repository.

Linked Data, by contrast, is a protocol optimised for providing information related to a set of topics, including links to related topics. The information is expressed using RDF statements.

The software in this repository is a gateway between these protocols. It consumes metadata records published by the Public Record Office Victoria's, using an OAI-PMH server, and converts them from their RIF-CS XML format into RDF, storing the RDF in a graph store.

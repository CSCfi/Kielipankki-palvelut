The two main programs here are ./cgi/que and ./syncmeta, all the rest
being there to support them or their development. The former is to be
available over HTTP, that latter eventually run as a scheduled job to
update the metadata database to mirror changes in a META-SHARE node.

./cgi/que) The OAI-PMH metadata server, configured to serve metadata
	   from an SQLite3 database file data/current -> data/db*.db

./cgi/queconf.{skel,py}) Configuration: .skel is tracked, .py is
           imported but not tracked. To set up a local environment,
           copy .skel as .py and edit at least the path to the
           current database link.

./fresh) creates and populates with some metadata a fresh database
           file, assuming ./syncmeta is configured to mirror a
           META-SHARE note with some content

./check) runs tests to check that ./cgi/que and its database really
           implement OAI-PMH

./syncmeta) configured to replace the current database file with one
           updated from a META-SHARE node

./xsl/) auxiliary transforms used by ./syncmeta, ./check, ...

./xsd/) relevant XML schemas - with XML_CATALOG_FILES=xsd/catalog,
        cache relevant schemas (rewriteURI, relative to xsd/) and
        xmllint will then use the local schema documents (caching the
        W3 xml namespace schema made the difference between 15000 and
        50 milliseconds per META-SHARE CMDI document validation) -

./README) this document

./TODO) known things to do, not necessarily exhaustive

./odds/) contents may or may not become part of the project

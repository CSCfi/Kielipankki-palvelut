CREATE TABLE format
(  metadataPrefix text not null primary key,
   description text not null );

-- xno is for resumption mechanism
CREATE TABLE ix
(  xno integer primary key,
   identifier text not null,
   metadataPrefix text not null references format,
   setSpec text not null references subset,
   stamp integer not null,
   recno integer not null references record  );

CREATE TABLE record
(  recno integer primary key,
   header text not null,
   metadata text not null,
   about text not null );

CREATE TABLE repository
(  secret text not null,
   identification text not null,
   minstamp integer not null,
   maxstamp integer not null );

-- sno is for resumption mechanism
CREATE TABLE subset
(  setSpec text not null primary key,
   sno integer not null,
   description text not null );


CREATE UNIQUE INDEX on_identifier_prefix_set
on ix(identifier, metadataPrefix, setSpec);


CREATE INDEX on_set_prefix_number_stamp
on ix(setSpec, metadataPrefix, recno, stamp);


-- If sourcename is 'http://metashare.csc.fi', identifier consists of
-- 'sh', then the last four characters of sourceid, then the number of
-- older such identifiers in the database in decimal (often 0).

CREATE TABLE origin
(  identifier text not null primary key,
   sourcename text not null,
   sourceid text not null  );

CREATE TABLE condition -- for META-SHARE, checksum
(  identifier text not null primary key,
   code text not null  );

CREATE UNIQUE INDEX on_origin_source
on origin(sourcename, sourceid);


INSERT INTO repository(secret, identification, minstamp, maxstamp)
select '"jupinaa"',
         '<repositoryName>Language Bank of Finland</repositoryName>'
	 || '<baseURL>https://kielipankki.fi/md_api/que</baseURL>'
	 || '<protocolVersion>2.0</protocolVersion>'
	 || '<adminEmail>kielipankki@csc.fi</adminEmail>'
	 || '<earliestDatestamp>2013-05-31T23:59:00Z'
	 || '</earliestDatestamp>'
	 || '<deletedRecord>transient</deletedRecord>'
	 || '<granularity>YYYY-MM-DDThh:mm:ssZ'
	 || '</granularity>'
	 || '<description>'
	 || '<oai-identifier'
	 || ' '
	 || 'xmlns='
	 || '"http://www.openarchives.org/OAI/2.0/oai-identifier"'
	 || ' '
	 || 'xmlns:xsi='
	 || '"http://www.w3.org/2001/XMLSchema-instance"'
	 || ' '
	 || 'xsi:schemaLocation='
	 || '"http://www.openarchives.org/OAI/2.0/oai-identifier'
	 || ' http://www.openarchives.org/OAI/2.0/oai-identifier.xsd"'
	 || '>'
	 || '<scheme>oai</scheme>'
	 || '<repositoryIdentifier>'
	 || 'kielipankki.fi'	
	 || '</repositoryIdentifier>'
	 || '<delimiter>:</delimiter>'
	 || '<sampleIdentifier>'
	 || 'oai:kielipankki.fi:sh31415'
	 || '</sampleIdentifier>'
	 || '</oai-identifier>'
	 ||'</description>',
	 0,
	 0;

INSERT INTO format(metadataPrefix, description)
select
'oai_dc', '<metadataFormat>'
         || '<metadataPrefix>oai_dc</metadataPrefix>'
         || '<schema>'
	 || 'http://www.openarchives.org/OAI/2.0/oai_dc.xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.openarchives.org/OAI/2.0/oai_dc/'
	 || '</metadataNamespace>'
	 || '</metadataFormat>'
union select
'olac', '<metadataFormat>'
	 || '<metadataPrefix>olac</metadataPrefix>'
         || '<schema>'
	 || 'http://www.language-archives.org/OLAC/1.1/olac.xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.language-archives.org/OLAC/1.1/'
	 || '</metadataNamespace>'
	 || '</metadataFormat>'
union select
'info', '<metadataFormat>'
         || '<metadataPrefix>info</metadataPrefix>'
	 || '<schema>'
	 || 'http://metashare.ilsp.gr/META-XMLSchema/v3.0/'
	 || 'META-SHARE-Resource.xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.ilsp.gr/META-XMLSchema'
	 || '</metadataNamespace>'
	 || '</metadataFormat>'
union select
'cmdi0554', '<metadataFormat>' /* languageDescriptionInfo */
         || '<metadataPrefix>cmdi0554</metadataPrefix>'
	 || '<schema>'
	 || 'http://catalog.clarin.eu/ds/ComponentRegistry/rest/'
	 || 'registry/profiles/clarin.eu:cr1:p_1361876010554/xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.clarin.eu/cmd/'
	 || '</metadataNamespace>'
	 || '</metadataFormat>'
union select
'cmdi0571', '<metadataFormat>' /* corpusInfo */
         || '<metadataPrefix>cmdi0571</metadataPrefix>'
	 || '<schema>'
	 || 'http://catalog.clarin.eu/ds/ComponentRegistry/rest/'
	 || 'registry/profiles/clarin.eu:cr1:p_1361876010571/xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.clarin.eu/cmd/'
	 || '</metadataNamespace>'
	 || '</metadataFormat>'
union select
'cmdi9836', '<metadataFormat>' /* toolServiceInfo */
         || '<metadataPrefix>cmdi9836</metadataPrefix>'
	 || '<schema>'
	 || 'http://catalog.clarin.eu/ds/ComponentRegistry/rest/'
	 || 'registry/profiles/clarin.eu:cr1:p_1360931019836/xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.clarin.eu/cmd/'
	 || '</metadataNamespace>'
	 || '</metadataFormat>'
union select
'cmdi2312', '<metadataFormat>' /* otherwise ... */
         || '<metadataPrefix>cmdi2312</metadataPrefix>'
	 || '<schema>'
	 || 'http://catalog.clarin.eu/ds/ComponentRegistry/rest/'
	 || 'registry/profiles/clarin.eu:cr1:p_1355150532312/xsd'
	 || '</schema>'
	 || '<metadataNamespace>'
	 || 'http://www.clarin.eu/cmd/'
	 || '</metadataNamespace>'
	 || '</metadataFormat>';

insert into subset(setSpec, sno, description)
select /* because there must be a set if there are sets */
'empty', 1, '<set>'
	 || '<setSpec>empty</setSpec>'
	 || '<setName>The intentionally empty set</setName>'
	 || '</set>';

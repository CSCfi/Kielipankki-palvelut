<xsd:schema
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"

    targetNamespace="http://www.openarchives.org/OAI/2.0/"
    elementFormDefault="qualified"

    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xsl:version="1.0">

  <!-- Pass $prefix as a parameter. -->

  <!--
This transform makes a specialized OAI-PMH schema document for a given
metadata prefix from an OAI-PMH response to ListMetadataFormats. The
resulting schema includes the OAI-PMH schema and imports the indicated
content schema. The public locations can be rewritten in an XML
catalog for local validation.
  -->

  <xsd:include
      schemaLocation="http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"/>

  <xsd:import>
    <xsl:attribute name="namespace">
      <xsl:value-of
	  select="descendant::oai:metadataFormat
		  [oai:metadataPrefix = $prefix]
		  / oai:metadataNamespace"/>
    </xsl:attribute>
    <xsl:attribute name="schemaLocation">
      <xsl:value-of
	  select="descendant::oai:metadataFormat
		  [oai:metadataPrefix = $prefix]
		  / oai:schema"/>
    </xsl:attribute>
  </xsd:import>

</xsd:schema>

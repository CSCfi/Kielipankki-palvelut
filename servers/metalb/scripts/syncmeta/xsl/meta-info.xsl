<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" version="1.0"
	      encoding="UTF-8"
	      omit-xml-declaration="yes"/>

  <!-- Copy with explicit namespace prefix for OAI-PMH -->

  <xsl:template match="info:resourceInfo"
		xmlns:info="http://www.ilsp.gr/META-XMLSchema">
    <info:resourceInfo>
      <xsl:apply-templates select="@* | node()"/>
    </info:resourceInfo>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>

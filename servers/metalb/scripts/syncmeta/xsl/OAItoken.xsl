<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/">

  <!-- Extracts resumptionToken=xxx, resumptionToken=, or
       noResumptionToken from an OAI-PMH response -->

   <xsl:output method="text" version="1.0" encoding="UTF-8"/>
   <xsl:template match="text()"/>

  <xsl:template match="/oai:OAI-PMH[descendant::oai:resumptionToken]">
    <xsl:apply-templates select="descendant::oai:resumptionToken"/>
  </xsl:template>

  <xsl:template match="/oai:OAI-PMH[not(descendant::oai:resumptionToken)]">
    <xsl:text>noResumptionToken</xsl:text>
  </xsl:template>

  <xsl:template match="oai:resumptionToken">
    <xsl:text>resumptionToken=</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

</xsl:transform>

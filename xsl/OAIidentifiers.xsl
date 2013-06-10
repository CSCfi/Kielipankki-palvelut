<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/">

  <!-- TODO: omit XML declaration, omit spurious empty line -->
  <!-- BECAUSE: no XSL documentation at hand at the moment -->

   <xsl:output method="text" version="1.0" encoding="UTF-8"/>
   <xsl:template match="text()"/>

  <xsl:template match="/">
    <xsl:apply-templates select="descendant::oai:header"/>
  </xsl:template>

  <xsl:template match="oai:header">
    <xsl:value-of select="oai:identifier"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="oai:dateStamp"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@status"/>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

</xsl:transform>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.clarin.eu/cmd/">
<!--
This script fixes some problems with the Metashare XML 
Note that you need to deal with tag attributes here specifially. See <CMD> or <ResourceProxy>.
Attributes introduced in meta-cmdi.xsl need to be reflected here or they will vanish.
Original author of the scripts: Jussi Piitulainen, HY
Modified by Martin Matthiesen, CSC
-->

 <xsl:output method="xml" version="1.0" encoding="UTF-8" />
        <xsl:template match="*">
			<xsl:choose>
				<xsl:when test="local-name()='CMD'">
				<xsl:text>
</xsl:text>
					<xsl:copy>
						<xsl:copy-of select="@CMDVersion"/>
						<xsl:copy-of select="@xsi:schemaLocation"/>						
						<xsl:apply-templates select="@* | node()"/>
					</xsl:copy>
				</xsl:when>
				<xsl:when test="local-name()='ResourceProxy'">
				<xsl:text>
</xsl:text>
					<xsl:copy>
						<xsl:copy-of select="@id"/>
						<xsl:apply-templates select="@* | node()"/>
					</xsl:copy>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="{local-name()}">
						<xsl:apply-templates select="@* | node()"/>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
        </xsl:template>
        <xsl:template match ="@*" >
			<xsl:if test="local-name() = 'lang'">
				<xsl:attribute name ="xml:lang">
					<xsl:value-of select ="." />
				</xsl:attribute>
			</xsl:if>
		</xsl:template>
</xsl:stylesheet>

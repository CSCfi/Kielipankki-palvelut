<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.clarin.eu/cmd/" 
xmlns:ms="http://www.ilsp.gr/META-XMLSchema" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xalan="http://xml.apache.org/xslt"  xmlns:date="http://exslt.org/dates-and-times" 
exclude-result-prefixes="ms xalan date" >
<!--
Metashare-CMDI transformation
Original author(s): ILSP, Athens, Greece
Adapted by Jussi Piitulainen, HY and Martin Matthiesen, CSC
Note: Adapt meta-cmdj.xsl if you introduce tags with attributes here.
-->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" xalan:indent-amount="4"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
		<xsl:apply-templates select="ms:resourceInfo"/>
	</xsl:template>
	<xsl:template name="personOrOrganizationInfo">
		<xsl:choose>
			<xsl:when test="ms:personInfo">
				<xsl:element name="{concat(local-name(), 'Person')}">
					<xsl:element name="role">
						<xsl:value-of select ="local-name()"/>
					</xsl:element>
					<xsl:element name="{local-name(ms:personInfo)}">
						<xsl:for-each select="ms:personInfo/child::*">
							<xsl:sort select="not(child::*)" order="descending"/>
							<xsl:choose>
								<xsl:when test="self::ms:affiliation">
									<xsl:element name="affiliation">
										<xsl:element name="role">
											<xsl:value-of select ="local-name()"/>
										</xsl:element>
										<xsl:element name="organizationInfo">
											<xsl:copy-of select="child::*"/>
										</xsl:element>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="{concat(local-name(), 'Organization')}">
					<xsl:element name="role">
						<xsl:value-of select ="local-name()"/>
					</xsl:element>
					<xsl:copy-of select="child::*"/>
				</xsl:element>			
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reportInfo">
		<xsl:choose>
			<xsl:when test="child::ms:documentUnstructured">
				<xsl:element name="{concat(local-name(), 'Unstructured')}">
					<xsl:element name="role">
						<xsl:value-of select ="local-name()"/>
					</xsl:element>
					<xsl:copy-of select="node()"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="{concat(local-name(), 'Structured')}">
					<xsl:element name="role">
						<xsl:value-of select ="local-name()"/>
					</xsl:element>
					<xsl:copy-of select="node()"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ms:distributionInfo">
		<xsl:copy>
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:iprHolder">
						<xsl:call-template name="personOrOrganizationInfo"/>
					</xsl:when>
					<xsl:when test="self::ms:licenceInfo">
						<xsl:apply-templates select="."/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ms:licenceInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:licensor or self::ms:distributionRightsHolder">
						<xsl:call-template name="personOrOrganizationInfo"/>
					</xsl:when>
					<xsl:when test="self::ms:downloadLocation or self::ms:executionLocation">
						<xsl:choose>
							<xsl:when test="contains(string(preceding-sibling::ms:licence), 'MSCommons')"/>
							<xsl:otherwise>
								<xsl:copy-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:contactPerson | ms:metadataCreator">
		<xsl:param name="info" select="'contactPerson'"/>
		<xsl:element name="{$info}">
			<xsl:element name="role">
				<xsl:value-of select ="local-name()"/>
			</xsl:element>
			<xsl:element name="personInfo">
				<xsl:for-each select="child::*">
					<xsl:sort select="not(child::*)" order="descending"/>
					<xsl:choose>
						<xsl:when test="self::ms:affiliation">
							<xsl:element name="affiliation">
								<xsl:element name="role">
									<xsl:value-of select ="local-name()"/>
								</xsl:element>
								<xsl:element name="organizationInfo">
									<xsl:for-each select="child::*">
										<xsl:copy-of select="."/>
									</xsl:for-each>
								</xsl:element>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>	
	<xsl:template match="ms:metadataInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:metadataCreator">
						<xsl:apply-templates select=".">
							<xsl:with-param name="info" select="'metadataCreator'"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:versionInfo">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="ms:validationInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:sizePerValidation">
						<xsl:element name="{local-name()}">
							<xsl:element name="role">
								<xsl:value-of select="local-name()"/>
							</xsl:element>
							<xsl:element name="sizeInfo">
								<xsl:copy-of select="child::*"/>
							</xsl:element>
						</xsl:element>
					</xsl:when>
					<xsl:when test="self::ms:validationReport">
						<xsl:call-template name="reportInfo"/>
					</xsl:when>
					<xsl:when test="self::ms:validator">
						<xsl:call-template name="personOrOrganizationInfo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
        </xsl:element>
	</xsl:template>
	<xsl:template match="ms:usageInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:actualUseInfo">
						<xsl:element name="{local-name()}">
							<xsl:for-each select="child::*">
								<xsl:sort select="not(child::*)" order="descending"/>
								<xsl:choose>
									<xsl:when test="self::ms:usageReport">
										<xsl:call-template name="reportInfo"/>
									</xsl:when>
									<xsl:when test="self::ms:usageProject">
										<xsl:element name="{local-name()}">
											<xsl:element name="role">
												<xsl:value-of select ="local-name()"/>
											</xsl:element>
											<xsl:element name="projectInfo">
												<xsl:copy-of select="node()"/>
											</xsl:element>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="."/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:resourceDocumentationInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:documentation">
						<xsl:call-template name="reportInfo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
        </xsl:element>
	</xsl:template>
	<xsl:template match="ms:resourceCreationInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:resourceCreator">
						<xsl:call-template name="personOrOrganizationInfo"/>
					</xsl:when>
					<xsl:when test="self::ms:fundingProject">
						<xsl:element name="{local-name()}">
							<xsl:element name="role">
								<xsl:value-of select ="local-name()"/>
							</xsl:element>
							<xsl:element name="projectInfo">
								<xsl:copy-of select="node()"/>
							</xsl:element>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
            </xsl:for-each>
        </xsl:element>
	</xsl:template>
	<xsl:template match="ms:languageInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:sizePerLanguage">
						<xsl:call-template name="sizeInfoPerCategory"/>
					</xsl:when>
					<xsl:when test="self::ms:languageVarietyInfo">
						<xsl:element name="{local-name()}">
							<xsl:for-each select="child::*">
								<xsl:sort select="not(child::*)" order="descending"/>
								<xsl:choose>
									<xsl:when test="self::ms:sizePerLanguageVariety">
										<xsl:call-template name="sizeInfoPerCategory"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="."/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template name="info_with_sizeInfo">
		<xsl:param name="rootElem" select="'modalityInfo'"/>
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="contains(local-name(), 'size')">
						<xsl:call-template name="sizeInfoPerCategory"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:annotationInfo">
		<xsl:element name="annotationInfo">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:annotationManual">
						<xsl:call-template name="reportInfo"/>
					</xsl:when>
					<xsl:when test="self::ms:sizePerAnnotation">
						<xsl:call-template name="sizeInfoPerCategory"/>
					</xsl:when>
					<xsl:when test="self::ms:annotator">
						<xsl:call-template name="personOrOrganizationInfo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:creationInfo">
		<xsl:element name="creationInfo">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:audioContentInfo">
		<xsl:element name="audioContentInfo">
			<xsl:for-each select="child::*">
				<xsl:choose>
					<xsl:when test="self::ms:nonSpeechItems and contains(string(.), 'commercial')">
						<xsl:element name="nonSpeechItems">
							<xsl:text>commercial</xsl:text>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template name="formatInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:sizePerAudioFormat or self::ms:sizePerVideoFormat or self::ms:sizePerImageFormat">
						<xsl:call-template name="sizeInfoPerCategory"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:recordingInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:recorder">
						<xsl:call-template name="personOrOrganizationInfo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:toolServiceOperationInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:choose>
					<xsl:when test="self::ms:runningEnvironmentInfo">
						<xsl:apply-templates select="."/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:runningEnvironmentInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:toolServiceEvaluationInfo">
		<xsl:element name="{local-name()}">
            <xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
					<xsl:choose>
						<xsl:when test="self::ms:evaluationReport">
							<xsl:call-template name="reportInfo"/>
						</xsl:when>
						<xsl:when test="self::ms:evaluator">
							<xsl:call-template name="personOrOrganizationInfo"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="."/>
						</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:toolServiceCreationInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:sort select="not(child::*)" order="descending"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:languageDescriptionOperationInfo">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="ms:runningEnvironmentInfo"/>
			<xsl:if test="ms:relatedLexiconInfo">
				<xsl:copy-of select="ms:relatedLexiconInfo"/>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="sizeInfoPerCategory">
		<xsl:element name="{local-name()}">
            <xsl:element name="role">
				<xsl:value-of select ="local-name()"/>
			</xsl:element>
			<xsl:element name="sizeInfo">
				<xsl:copy-of select="child::*"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:corpusTextInfo| ms:corpusAudioInfo| ms:corpusVideoInfo | ms:corpusImageInfo | ms:corpusTextNumericalInfo | ms:corpusTextNgramInfo | ms:languageDescriptionTextInfo | ms:languageDescriptionVideoInfo | ms:languageDescriptionImageInfo | ms:lexicalConceptualResourceTextInfo | ms:lexicalConceptualResourceAudioInfo |ms:lexicalConceptualResourceVideoInfo | ms:lexicalConceptualResourceImageInfo">
		<xsl:element name="{local-name()}">
			<xsl:for-each select="child::*">
				<xsl:if test="self::ms:mediaType">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:lingualityInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:languageInfo">
					<xsl:apply-templates select="."/>
				</xsl:if>
				<xsl:if test="self::ms:modalityInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:sizeInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:textFormatInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:characterEncodingInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:annotationInfo">
					<xsl:apply-templates select="."/>
				</xsl:if>
				<xsl:if test="self::ms:domainInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:textClassificationInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:timeCoverageInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:geographicCoverageInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:creationInfo">
					<xsl:apply-templates select="."/>
				</xsl:if>
				<xsl:if test="self::ms:linkToOtherMediaInfo">
					<xsl:copy-of select="."/>
				</xsl:if>	
				<xsl:if test="self::ms:audioSizeInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:audioContentInfo">
					<xsl:apply-templates select="."/>
				</xsl:if>
				<xsl:if test="self::ms:settingInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:audioFormatInfo">
					<xsl:call-template name="formatInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:audioClassificationInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:recordingInfo">
					<xsl:apply-templates select="."/>
				</xsl:if>
				<xsl:if test="self::ms:captureInfo">
					<xsl:copy-of select="."/>
				</xsl:if>			
				<xsl:if test="self::ms:videoContentInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:videoFormatInfo">
					<xsl:call-template name="formatInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:videoClassificationInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>			
				<xsl:if test="self::ms:imageContentInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:imageFormatInfo">
					<xsl:call-template name="formatInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:imageClassificationInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>			
				<xsl:if test="self::ms:textNumericalContentInfo">
					<xsl:copy-of select="."/>
				</xsl:if>
				<xsl:if test="self::ms:textNumericalFormatInfo">
					<xsl:call-template name="info_with_sizeInfo"/>
				</xsl:if>
				<xsl:if test="self::ms:ngramInfo">
					<xsl:copy-of select="."/>
				</xsl:if>					
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:corpusInfo">
		<xsl:element name="corpusInfo">
            <xsl:copy-of select="ms:resourceType"/>
            <xsl:element name="corpusMediaType">
				<xsl:for-each select="ms:corpusMediaType/child::*">
					<xsl:if test="self::ms:corpusTextInfo">
						<xsl:apply-templates select="."/>
					</xsl:if>
					<xsl:if test="self::ms:corpusAudioInfo">
						<xsl:apply-templates select="."/>
					</xsl:if>
					<xsl:if test="self::ms:corpusVideoInfo">
						<xsl:apply-templates select="."/>
					</xsl:if>
					<xsl:if test="self::ms:corpusImageInfo">
						<xsl:apply-templates select="."/>
					</xsl:if>
					<xsl:if test="self::ms:corpusTextNumericalInfo">
						<xsl:apply-templates select="."/>
					</xsl:if>
					<xsl:if test="self::ms:corpusTextNgramInfo">
						<xsl:apply-templates select="."/>
					</xsl:if>
				</xsl:for-each>
            </xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:toolServiceInfo">
		<xsl:element name="{local-name()}">
			<xsl:copy-of select="ms:resourceType"/>
			<xsl:copy-of select="ms:toolServiceType"/>
			<xsl:copy-of select="ms:toolServiceSubtype"/>
			<xsl:copy-of select="ms:languageDependent"/>
			<xsl:copy-of select="ms:inputInfo"/>
			<xsl:copy-of select="ms:outputInfo"/>
			<xsl:apply-templates select="ms:toolServiceOperationInfo"/>
			<xsl:apply-templates select="ms:toolServiceEvaluationInfo"/>
			<xsl:apply-templates select="ms:toolServiceCreationInfo"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:languageDescriptionInfo">
		<xsl:element name="{local-name()}">
			<xsl:copy-of select="ms:resourceType"/>
			<xsl:copy-of select="ms:languageDescriptionType"/>
			<xsl:copy-of select="ms:languageDescriptionEncodingInfo"/>
			<xsl:apply-templates select="ms:languageDescriptionOperationInfo"/>
			<xsl:copy-of select="ms:languageDescriptionPerformanceInfo"/>
			<xsl:apply-templates select="ms:creationInfo"/>
			<xsl:element name="languageDescriptionMediaType">
				<xsl:if test="ms:languageDescriptionMediaType/ms:languageDescriptionTextInfo">
						<xsl:apply-templates select="//ms:languageDescriptionTextInfo"/>
					</xsl:if>
					<xsl:if test="ms:languageDescriptionMediaType/ms:languageDescriptionVideoInfo">
						<xsl:apply-templates select="//ms:languageDescriptionVideoInfo"/>
					</xsl:if>
					<xsl:if test="ms:languageDescriptionMediaType/ms:languageDescriptionImageInfo">
						<xsl:apply-templates select="//ms:languageDescriptionImageInfo"/>
					</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:lexicalConceptualResourceInfo">
		<xsl:element name="{local-name()}">
			<xsl:copy-of select="ms:resourceType"/>
			<xsl:copy-of select="ms:lexicalConceptualResourceType"/>
			<xsl:copy-of select="ms:lexicalConceptualResourceEncodingInfo"/>
			<xsl:apply-templates select="ms:creationInfo"/>
			<xsl:element name="lexicalConceptualResourceMediaType">
				<xsl:if test="//ms:lexicalConceptualResourceTextInfo">
						<xsl:apply-templates select="//ms:lexicalConceptualResourceTextInfo"/>
					</xsl:if>
					<xsl:if test="//ms:lexicalConceptualResourceAudioInfo">
						<xsl:apply-templates select="//ms:lexicalConceptualResourceAudioInfo"/>
					</xsl:if>
					<xsl:if test="//ms:lexicalConceptualResourceVideoInfo">
						<xsl:apply-templates select="//ms:lexicalConceptualResourceVideoInfo"/>
					</xsl:if>
					<xsl:if test="//ms:lexicalConceptualResourceImageInfo">
						<xsl:apply-templates select="//ms:lexicalConceptualResourceImageInfo"/>
					</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ms:resourceInfo" name="resourceInfo">
		<xsl:text>
</xsl:text>
		<CMD>
			<xsl:attribute name="CMDVersion">1.1</xsl:attribute>
			<xsl:attribute name="xsi:schemaLocation">
				<xsl:choose>
					<xsl:when test="ms:resourceComponentType/ms:corpusInfo">
						<xsl:text>http://www.clarin.eu/cmd/ http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/profiles/clarin.eu:cr1:p_1361876010571/xsd</xsl:text>
					</xsl:when>
					<xsl:when test="ms:resourceComponentType/ms:toolServiceInfo">
						<xsl:text>http://www.clarin.eu/cmd/ http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/profiles/clarin.eu:cr1:p_1360931019836/xsd</xsl:text>
					</xsl:when>
					<xsl:when test="ms:resourceComponentType/ms:languageDescriptionInfo">
						<xsl:text>http://www.clarin.eu/cmd/ http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/profiles/clarin.eu:cr1:p_1361876010554/xsd</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>http://www.clarin.eu/cmd/ http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/profiles/clarin.eu:cr1:p_1355150532312/xsd</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<Header>
				<MdCreator>metashareToCmdi.xsl remove_metashare_namespace.xsl</MdCreator>
				<MdCreationDate>
					<xsl:value-of select="substring(date:date(), 1, 10)"/>
				</MdCreationDate>
				<!--normalise URNs and Handles, at least Kielipankki's -->
                                <xsl:for-each select="//ms:resourceInfo/ms:identificationInfo/ms:identifier">
                                  <xsl:if test="contains(.,'urn:nbn:fi')">
                                    <MdSelfLink><xsl:value-of select="concat('http://urn.fi/urn:nbn:fi', substring-after(.,'urn:nbn:fi'))" /></MdSelfLink>
                                  </xsl:if>
                                  <xsl:if test="contains(.,'11113/')">
                                    <MdSelfLink><xsl:value-of select="concat('http://hdl.handle.net/11113/', substring-after(.,'11113/'))" /></MdSelfLink>
                                  </xsl:if>
                                </xsl:for-each>
				<MdProfile>
					<xsl:choose>
						<xsl:when test="ms:resourceComponentType/ms:corpusInfo">
							<xsl:text>clarin.eu:cr1:p_1361876010571</xsl:text>
						</xsl:when>
						<xsl:when test="ms:resourceComponentType/ms:toolServiceInfo">
							<xsl:text>clarin.eu:cr1:p_1360931019836</xsl:text>
						</xsl:when>
						<xsl:when test="ms:resourceComponentType/ms:languageDescriptionInfo">
							<xsl:text>clarin.eu:cr1:p_1361876010554</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>clarin.eu:cr1:p_1355150532312</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</MdProfile>
			</Header>
			<Resources>
			  <ResourceProxyList>
                            <!--transform Metashare URL to Resource Proxy references -->
                            <xsl:for-each select="//ms:resourceInfo/ms:identificationInfo/ms:url">
                              <ResourceProxy>
                                <xsl:attribute name="id"><xsl:value-of select="concat('_',position())"/></xsl:attribute>
                                <ResourceType>Resource</ResourceType>
                                <ResourceRef><xsl:value-of select="." /></ResourceRef>
                              </ResourceProxy>
                            </xsl:for-each>
                          </ResourceProxyList>
			  <JournalFileProxyList/>
			  <ResourceRelationList/>
			</Resources>
			<Components>
				<resourceInfo>
					<xsl:copy-of select="ms:identificationInfo"/>
					<xsl:apply-templates select="ms:distributionInfo"/>
					<xsl:apply-templates select="ms:contactPerson"/>
					<xsl:apply-templates select="ms:metadataInfo"/>
					<xsl:apply-templates select="ms:versionInfo"/>
					<xsl:apply-templates select="ms:validationInfo"/>
					<xsl:apply-templates select="ms:usageInfo"/>
					<xsl:apply-templates select="ms:resourceDocumentationInfo"/>
					<xsl:apply-templates select="ms:resourceCreationInfo"/>
					<xsl:copy-of select="ms:relationInfo"/>
					<xsl:if test="ms:resourceComponentType/ms:corpusInfo">
						<xsl:apply-templates select="//ms:corpusInfo"/>
					</xsl:if>
					<xsl:if test="ms:resourceComponentType/ms:toolServiceInfo">
						<xsl:apply-templates select="//ms:toolServiceInfo"/>
					</xsl:if>
					<xsl:if test="ms:resourceComponentType/ms:languageDescriptionInfo">
						<xsl:apply-templates select="//ms:languageDescriptionInfo"/>
					</xsl:if>
					<xsl:if test="ms:resourceComponentType/ms:lexicalConceptualResourceInfo">
						<xsl:apply-templates select="//ms:lexicalConceptualResourceInfo"/>
					</xsl:if>
				</resourceInfo>
			</Components>
		</CMD>
	</xsl:template>
</xsl:stylesheet>

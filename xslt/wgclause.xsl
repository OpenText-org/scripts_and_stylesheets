<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:wg="http://www.opentext.org/ns/word-group"
 xmlns:cl="http://www.opentext.org/ns/clause"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>	
	</xsl:template>	
	
	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>	
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="embeddedClause">
		<xsl:variable name="id" select="@id"/>	
		<xsl:choose>
			<xsl:when test="not(preceding-sibling::embeddedClause[@id=$id])">
				<cl:clause>
					<xsl:copy-of select="@*[not(local-name()='level')]"/>
					<xsl:apply-templates/>
					<xsl:apply-templates select="following-sibling::embeddedClause[@id=$id]/*"/>			
				</cl:clause>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	
</xsl:stylesheet>

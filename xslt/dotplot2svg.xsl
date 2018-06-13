<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
		doctype-system="http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"
		doctype-public="-//W3C//DTD SVG 1.0//EN"
	/>

	<xsl:variable name="yOffset">10</xsl:variable>
	<xsl:variable name="xOffset">10</xsl:variable>
	
	<xsl:template match="/">
 		 
		<svg>

			<g>
				<xsl:apply-templates select="//row"/>
			</g>

		</svg>		

	
	</xsl:template>

	<xsl:template match="row">
		<xsl:variable name="y" select="count(preceding-sibling::row)+$yOffset"/>
		<xsl:apply-templates select="cell">
			<xsl:with-param name="y" select="$y"/>
		</xsl:apply-templates>

	</xsl:template>
	
	<xsl:template match="cell">
		<xsl:param name="y"/>

		<xsl:if test=".=1">
			<xsl:variable name="x" select="count(preceding-sibling::cell)+$xOffset"/>
			<line x1="{$x}" x2="{$x+1}" y1="{$y}" y2="{$y}" style="stroke: black"/>
		</xsl:if>

	</xsl:template>
</xsl:stylesheet>

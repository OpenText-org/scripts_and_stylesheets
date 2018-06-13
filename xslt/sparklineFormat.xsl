<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:ci="http://apache.org/cocoon/include/1.0" xmlns:svg="http://www.w3.org/2000/svg"
	 exclude-result-prefixes="ci"
>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="* | processing-instruction()">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<!--
	<xsl:template match="th[@class='systemLabel']">
		<xsl:copy-of select="."/>
		<th></th>
	</xsl:template>
	-->
	
	<xsl:template match="td[svg:svg]">
		<td class="sparkline">
			<xsl:apply-templates/>
		</td>
		<td class="value">
			<xsl:value-of select="svg:svg//text"/>
		</td>
	</xsl:template>



</xsl:stylesheet>

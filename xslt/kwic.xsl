<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>OpenText.org KWIC search</title>
				<style type="text/css">
				
					.left { text-align: right; }
				
					.w { font-family: Palatino Linotype, Athena, Georgia Greek; }
					
					.keyword { font-weight: bold; padding-left: 20pt; padding-right: 20pt; text-align: center;}
				</style>
			</head>
			<body>
<table>
	<tbody>

			<xsl:apply-templates select="//results"></xsl:apply-templates>
		
	</tbody>
</table>			
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="hit">
		<tr>
			<td><xsl:value-of select="@ref"/></td>
			<td class="left">
				<xsl:apply-templates select="*[following-sibling::keyword]"/>
			</td>
			<td class="keyword">
				<xsl:apply-templates select="keyword"/>
			</td>
			<td class="right">
				<xsl:apply-templates select="keyword/following-sibling::*"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="w">
		<span class="w"><xsl:value-of select="wf"/></span>
		<xsl:text> </xsl:text>
	</xsl:template>
	
</xsl:stylesheet>

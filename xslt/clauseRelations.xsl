<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:cl="http://www.opentext.org/ns/clause"
	xmlns:pl="http://www.opentext.org/ns/paragraph"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
	<xsl:template match="/">
		<html>
			<head>
				<title>Clause relations</title>
				<style type="text/css">
					.clause { margin: 1px; border: 1px solid #707070; margin-bottom: 10px;}
					.embedClause { border: 1px solid #707070; display: inline; vertical-align: middle; margin: 4px; }
					.comp { border-right: 1px solid #707070;  padding: 1px;  vertical-align: middle}
					.lastComp { padding: 1px;  vertical-align: middle}
					.comp-label { color: blue; font-family: Arial; font-size: 8pt; margin-right: 4pt; fonr-weight: bold;}
					.embedComp { display: inline; margin: 1px; border: 1px solid #707070;  }
					.grk { font-family: Palatino Linotype; }
					
					.cid { font-family: Arial; font-size: 8pt; color: green; border-right: 1px solid #707070; }
					
				</style>
			</head>
			<body>
				<xsl:apply-templates/>
			</body>
		</html>
			
	</xsl:template>
	
	<xsl:template match="chapter/cl:clause">
		<table class="clause">
			<!-- determine level of embedding -->		
		
			<tbody>
				<tr>
					<td class="cid"><xsl:value-of select="@id"/></td>
					<xsl:apply-templates/>	
				</tr>
			</tbody>
			
		</table>
	 
	</xsl:template>	
	
	<xsl:template match="cl:clause">
		<table class="embedClause">
			<tbody>
				<tr>
					<td class="cid"><xsl:value-of select="@id"/></td>
					<xsl:apply-templates/>	
				</tr>
			</tbody>
			
		</table>
	</xsl:template>
	
	<xsl:template match="cl:A | cl:C | cl:P | cl:S | pl:conj">
		<xsl:choose>
			<xsl:when test="parent::cl:clause">
				<td>
					<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="not(following-sibling::*)">lastComp</xsl:when>
						<xsl:otherwise>comp</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
				<span class="comp-label"><xsl:value-of select="local-name()"/></span> <xsl:apply-templates/>	</td>

			</xsl:when>
			<xsl:otherwise>
				<table class="embedComp">
					<tbody>
						<tr>
							<td class="comp"><span class="comp-label"><xsl:value-of select="local-name()"/></span> <xsl:apply-templates/>	</td>
						</tr>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	<xsl:template match="wf">
		<span class="grk"><xsl:value-of select="."/>	</span>
		<xsl:text> </xsl:text>
	</xsl:template>
	
	<xsl:template match="domains"/>
	
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:template match="/">
	
		<html>
			<head>
				<title>Synopsis Test</title>
				<style type="text/css">
					.grk { font-family: Cardo; }
					.vnum { font-family: Arial; font-size: 8pt; vertical-align: top;}
					
					td { vertical-align: top; }
				</style>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			</head>
			<body>
			
				<table>
					<tbody>
						<tr>
							<xsl:apply-templates select="//column"/>
						</tr>
					</tbody>
				</table>
			
			</body>
		</html>
	
	</xsl:template>
	
	<xsl:template match="column">
		<td>
			<xsl:apply-templates select=".//verse"/>
		</td>
	</xsl:template>
	
	<xsl:template match="verse">
		<div class="verse">
			<span class="vnum"><xsl:value-of select="@num"/></span>
			<xsl:apply-templates select="w"/>
		</div>
		
	</xsl:template>
	
	<xsl:template match="w">
		 
		<span class="grk" id="{@id}">
			<xsl:if test="//filter/pos/*[name()=name(current()/child::*[1])]">
				<xsl:for-each select="child::*[1]">
				<xsl:call-template name="pos-match">
					<xsl:with-param name="match"><xsl:copy-of select="//filter/pos/*[name()=name(current())]"/></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>
				
				
			</xsl:if>
			
			
			<xsl:apply-templates select="wf"/>
		</span>
		&#160;
	</xsl:template>
	
	
	<xsl:template match="wf">
		<xsl:variable name="form" select="."/>
		<xsl:variable name="lex" select="@betaLex"/>
		<!--
		<xsl:if test="ancestor::column/preceding-sibling::column//wf[.=$form] or ancestor::column/following-sibling::column//wf[.=$form]">
			<xsl:attribute name="style">color: blue </xsl:attribute>
		</xsl:if>
		-->
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template name="pos-match">
		<xsl:param name="match"/>
		
	 
		<xsl:variable name="match-pattern">
		<xsl:for-each select="@*">
		 	<xsl:variable name="att" select="local-name()"/>
		 	 <xsl:choose>
 
			<xsl:when test="xalan:nodeset($match)//@*[name()=$att]">
			
				<xsl:choose>
					<xsl:when test="xalan:nodeset($match)//@*[name()=$att][.=current()]">1</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		
 		</xsl:variable>


		<xsl:if test="not(contains($match-pattern,'0'))"><xsl:attribute name="style"><xsl:value-of select="$match"/></xsl:attribute></xsl:if>
	
	</xsl:template>
	
</xsl:stylesheet>

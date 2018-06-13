<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink"
exclude-result-prefixes="xlink"
>

	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="book">3john</xsl:param>
	
	<xsl:strip-space elements="*"/>
	
	<xsl:variable name="filename">../<xsl:value-of select="$book"/>/wordgroup/<xsl:value-of select="$book"/>-wg-ch<xsl:value-of select="//chapter/@num"/>.xml</xsl:variable>
	<xsl:variable name="wordgroup" select="document($filename)/*"/>


	<xsl:variable name="participant">../<xsl:value-of select="$book"/>/participant/<xsl:value-of select="$book"/>-part.xml</xsl:variable>
	
	<xsl:variable name="base">../<xsl:value-of select="$book"/>/base/<xsl:value-of select="$book"/>.xml</xsl:variable>
	
	<xsl:key name="parts" match="wg:part" use="@xlink:href"/>
	<xsl:key name="words" match="w" use="@id"/>
	
	<xsl:template match="/">
		
		<xsl:apply-templates/>
	
	</xsl:template>
	
	<xsl:template match="*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	
	<xsl:template match="w">
		<xsl:variable name="id" select="@xlink:href"/>
		
			<w id="{@xlink:href}">
				<xsl:copy-of select="@*[not(name()='xlink:href')]"/>
				<xsl:call-template name="wordgroup">
					<xsl:with-param name="id" select="$id"/>
				</xsl:call-template>
				<xsl:for-each select="document($participant)//occurrences">
				<xsl:for-each select="key('parts',$id)">
					<xsl:attribute name="partRef"><xsl:value-of select="@num"/></xsl:attribute>
					<xsl:attribute name="partType"><xsl:value-of select="@type"/></xsl:attribute>
					<xsl:if test="@compound">
						<xsl:attribute name="partCompound"><xsl:value-of select="@compound"/></xsl:attribute>
					</xsl:if>
				</xsl:for-each>
				</xsl:for-each>
				<xsl:for-each select="document($base)">
					<xsl:attribute name="ref"><xsl:value-of select="key('words',$id)/ancestor::chapter/@num"/>.<xsl:value-of select="key('words',$id)/ancestor::verse/@num"/></xsl:attribute>
					<xsl:copy-of select="key('words',$id)/*"/>
				</xsl:for-each>
			</w>
		
		

	</xsl:template>
	
	
	
	<xsl:template name="wordgroup">
		<xsl:param name="id"/>
		
		<xsl:for-each select="$wordgroup//wg:word[@xlink:href=$id]">
		<xsl:attribute name="wg"><xsl:value-of select="ancestor::wg:group[1]/@id"/></xsl:attribute>
		<xsl:attribute name="role"><xsl:value-of select="local-name(parent::*)"/></xsl:attribute>
		
		<xsl:if test="parent::wg:head and count(ancestor::wg:group) &gt; 1">
				<xsl:attribute name="modifies"><xsl:value-of select="ancestor::wg:word[1]/@xlink:href"/></xsl:attribute>
				<xsl:attribute name="embed"><xsl:value-of select="ancestor::wg:group[2]/@id"/></xsl:attribute>
		
				<xsl:attribute name="embedrole"><xsl:value-of select="local-name(ancestor::wg:group[1]/parent::*)"/></xsl:attribute>
		</xsl:if>
		
		<xsl:if test="not(parent::wg:head)">
			<xsl:attribute name="modifies"><xsl:value-of select="ancestor::wg:word[1]/@xlink:href"/></xsl:attribute>
		</xsl:if>
		</xsl:for-each>
		
	</xsl:template>

	
	
</xsl:stylesheet>

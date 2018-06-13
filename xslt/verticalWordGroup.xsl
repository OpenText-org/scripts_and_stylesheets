<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause" xmlns:xlink="http://www.w3.org/1999/xlink" 
exclude-result-prefixes="xlink wg cl pl"
 

>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="id">1Tim.wg1_1</xsl:param>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Word group representation: <xsl:value-of select="//chapter/@book"/> <xsl:value-of select="//chapter/@num"/></title>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<style type="text/css">
		  table { border-collapse: collapse; border: solid 1px #a0a0a0; margin-bottom: 20px;}
		  td { border: solid 1px #ffffff; font-family: Verdana; font-size: 7pt; }		
		  
		  td.spacer { width: 5px; }

		.grk { font-family: Palatino Linotype; font-size: 12pt;}
	  
		  .definer {  background-color: rgb(255,255,153); }
		  .relator { background-color: rgb(255,153,153); }
		  .specifier { background-color: rgb(204,236,255); }
		  .qualifier { background-color: rgb(153,255,204); }		  
		  .connector { background-color: rgb(204,153,255); }		  		
				</style>
			</head>
			<body>
				<xsl:apply-templates select="//wg:group[not(ancestor::wg:group)]"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="wg:group">
	
	
	
		<!-- calculate number of rows -->
		<xsl:variable name="rows" select="count(.//wg:word)"/>
		<!-- calculate number of columns -->
		<xsl:variable name="cols">
			<xsl:call-template name="maxDepth">
				<xsl:with-param name="i" select="count(wg:head/wg:word/descendant::wg:word)"/>
			</xsl:call-template>
		</xsl:variable>
		
	 
		
		<table>
			<tbody>
				<xsl:apply-templates select=".//wg:word[not(ancestor::cl:clause)]">
					<xsl:sort select="substring-after(@xlink:href,'w')" data-type="number" order="ascending"/>
					<xsl:with-param name="cols" select="$cols"/>
				</xsl:apply-templates>
			</tbody>
		</table>
		
		
	</xsl:template>	
	
	<xsl:template match="wg:word">
		<xsl:param name="cols"/>
		
		<!-- check to see if this is the first word in an embedded word group -->
		<xsl:variable name="embedded">
			<xsl:choose>
				<xsl:when test="ancestor::cl:clause"></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		
		
		<tr>
		
		<xsl:variable name="spacing" select="count(ancestor::wg:word)*2"/>
		
		
		<xsl:if test="ancestor::wg:word">
			<xsl:call-template name="buildAncestors">
				<xsl:with-param name="wpos" select="substring-after(@xlink:href,'w')"/>
			</xsl:call-template>
		</xsl:if>
		
		<!--
		<xsl:if test="ancestor::wg:word">
			<xsl:variable name="rel" select="local-name(parent::*)"/>
			<td/>
			<td rowspan="{count(descendant::wg:word)+1}" class="{$rel}"><xsl:value-of select="$rel"/></td>
		</xsl:if>
		-->
 
 		<td class="grk" colspan="{$cols - $spacing}"><xsl:value-of select="@wf"/></td>
		
		</tr>
	</xsl:template>
	
	<!-- EMBEDDED CLAUSE -->
	<xsl:template match="cl:clause">
		<tr>
			<td>A CLAUSE <xsl:value-of select="@id"/></td>
		</tr>
	</xsl:template>
	
	<!-- calculate the depth of word and return value if greater than passed value or 0 -->
	<xsl:template name="maxDepth">
		<xsl:param name="depth">0</xsl:param>
		<xsl:param name="i">0</xsl:param>
		
		<xsl:choose>
			<xsl:when test="$i &gt; 0">
				<xsl:variable name="currentDepth">
					<xsl:value-of select="count(wg:head/wg:word/descendant::wg:word[position()=$i]/ancestor::wg:word)"/>
				</xsl:variable>
				<xsl:call-template name="maxDepth">
					<xsl:with-param name="i" select="number($i - 1)"/>
					<xsl:with-param name="depth">
						<xsl:choose>
							<xsl:when test="$currentDepth &gt; $depth"><xsl:value-of select="$currentDepth"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$depth"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number(($depth + 1) * 2)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		
	</xsl:template>
	
	<xsl:template name="buildAncestors">
		<xsl:param name="wpos"/>
		<xsl:choose>
			<xsl:when test="ancestor::wg:word">
				<xsl:for-each select="ancestor::wg:word[1]">
					<xsl:call-template name="buildAncestors">
						<xsl:with-param name="wpos" select="$wpos"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="not(parent::wg:head)">
		<xsl:variable name="smallestWordId">
			<xsl:call-template name="getSmallestID">
				<xsl:with-param name="id" select="substring-after(@xlink:href,'w')"/>
				<xsl:with-param name="i" select="count(descendant::wg:word)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$smallestWordId=$wpos">
		<xsl:variable name="span" select="count(descendant::wg:word)+1 - count(wg:modifiers/wg:connector)"/>
		<xsl:variable name="headpos" select="number(substring-after(ancestor::wg:word[1]/@xlink:href,'w'))"/>
		<xsl:variable name="span2">
			<xsl:choose>
				<xsl:when test="($headpos - $wpos &lt; $span) and ($headpos - $wpos) &gt; 0"><xsl:value-of select="$span - ($headpos - $wpos)"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<td class="spacer" rowspan="{$span - $span2}"></td>
		<td rowspan="{$span - $span2}" class="{local-name(parent::*)}">
			<xsl:choose>
				<xsl:when test="parent::wg:connector">&#x2195;<xsl:value-of select="local-name(parent::*)"/></xsl:when>
				<xsl:when test="number(substring-after(ancestor::wg:word[1]/@xlink:href,'w')) &lt; number(substring-after(@xlink:href,'w'))">
					&#x2191;
					<br/>
					<xsl:value-of select="local-name(parent::*)"/>
				</xsl:when>
				<xsl:otherwise>					
					<xsl:value-of select="local-name(parent::*)"/>
					<br/>
					&#x2193;
				</xsl:otherwise>
			</xsl:choose>
</td>		
		</xsl:if>
		</xsl:if>

	</xsl:template>
	
	<xsl:template name="getSmallestID">
		<xsl:param name="id"/>
		<xsl:param name="i">0</xsl:param>
		
		<xsl:choose>
			
			<xsl:when test="$i &gt; 0">
				<xsl:call-template name="getSmallestID">
						<xsl:with-param name="i" select="$i - 1"/>
						<xsl:with-param name="id">
							<xsl:variable name="newId" select="number(substring-after(descendant::wg:word[position()=$i]/@xlink:href,'w'))"/>
							<xsl:choose>
								<xsl:when test="$newId &lt; $id and not(descendant::wg:word[position()=$i]/parent::wg:connector)"><xsl:value-of select="$newId"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="$id"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>

				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$id"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 

>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="breaks">no</xsl:param>
	<xsl:param name="types">no</xsl:param>
	<xsl:param name="spacer">no</xsl:param>	
	<xsl:param name="format"/>
	<xsl:param name="header">no</xsl:param>
	<xsl:param name="domain"></xsl:param>
	
	<xsl:template match="/">
			<html>
				<head>
					<title>Clause Display</title>

					<style type="text/css">
						body { margin: 0px; font-family: Arial; font-size: 8pt; }
					
										.cid { font-size: 8pt; vertical-align: middle; font-family: Verdana}
		
						
						.clauseText { 
								<xsl:if test="$breaks='no'">
								white-space: nowrap;
								</xsl:if>
								<xsl:if test="$breaks='yes'">
									margin-left: 50pt;
									text-indent: -50pt;
								</xsl:if>
								font-family: 'Palatino Linotype', Cardo, 'Georgia Greek', Athena;
								font-size: 10pt;
								 margin-bottom: 0pt; margin-top: -2pt;
								 
						}
						
						.headings { font-size: 8pt; }
						
							.types { vertical-align: -2pt; font-size: 7pt; }
						.comp { font-family: Arial; margin-left: 2pt;  }
						.clcomp { font-family: Arial; }
						.emdivider { font-size: 9pt; color: #a0a0a0; vertical-align: middle; }
						.label { vertical-align: middle; font-size: 7pt; color: #0000DD; margin-right: 2pt; }
						.emlabel { vertical-align: middle; font-size: 7pt; color: #00DD00;; margin-right: 2pt; }
						.divider { font-size: 12pt; color: #505050; }
						
						.compspan { white-space: nowrap; }
						
						.verse {  font-weight: bold; width: 20pt; padding-right: 6pt; text-align: right; }
						
						rt { color: red; vertical-align: -5pt; font-size: 7pt;}
				 ruby { padding: 0; }
						
							.title { font-size: 11pt; text-align: center; font-weight: bold; margin-bottom: 12pt}
							
							.domainHighlight { background-color: #88ffff; }
					
					</style>
					
				</head>
				<body>
				
				
				<!-- include header -->
				<xsl:if test="not($header=0)">
	<div class="title">OpenText.org Clause Annotation of <xsl:value-of select="$header"/><xsl:text> </xsl:text><xsl:value-of select="//chapter/@num"/></div>
</xsl:if>

							<xsl:apply-templates select="//chapter/cl:clause"/>	

				</body>
			</html>
	</xsl:template>
	
	<xsl:template match="cl:clause[parent::chapter]">
		<xsl:variable name="vnum" select=".//w[1]/@vs"/>	
		<xsl:variable name="cid" select="substring-after(@id,'_')"/>	

	
<div class="clauseText">
	<span class="verse"><xsl:text> </xsl:text>
	<xsl:if test="not(preceding::cl:clause//w[1]/@vs=$vnum)">
					<xsl:text></xsl:text><xsl:value-of select="$vnum"/>
				</xsl:if>
	</span>
	<span class="cid"><xsl:value-of select="concat('c',$cid)"/></span>
	
	 <span>
			<xsl:if test="@level='secondary' or @level='secondary2'">
			<xsl:attribute name="style">
				<xsl:call-template name="indentLevel"/>
			</xsl:attribute>
			</xsl:if>
					<span class="clcomp"><span class="divider">|</span></span>			
					<xsl:apply-templates/>
					<span class="clcomp"><span class="divider">||</span></span>
				</span>
</div>	
			
			
	</xsl:template>
	
	<xsl:template match="gloss"/>
	
	<xsl:template match="cl:clause[ancestor::cl:clause]">
		
		<span class="compspan">
		<span class="clcomp"><span class="emdivider">[[</span></span>			
		<xsl:apply-templates/>
		<span class="clcomp"><span class="emdivider">]]</span></span>
		</span>
 
	</xsl:template>
	
	<xsl:template match="cl:S | cl:P | cl:C | cl:A | pl:conj">
			<xsl:variable name="compname">
			<xsl:choose>
				<xsl:when test="local-name()='conj'">cj</xsl:when>
				<xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<span >
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="cl:clause"></xsl:when>
					<xsl:otherwise>compspan</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="not(preceding-sibling::cl:* or preceding-sibling::pl:*)">clcomp</xsl:when>
					<xsl:otherwise>comp</xsl:otherwise>	
				</xsl:choose>	
			</xsl:attribute>
			<xsl:variable name="divider">
				<xsl:choose>
					<xsl:when test="parent::cl:*[not(self::cl:clause)]">(</xsl:when>
					<xsl:otherwise>|</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="not(preceding-sibling::cl:* or preceding-sibling::pl:*) and count(ancestor::cl:clause)&gt;1"></xsl:when>
 				<xsl:when test="count(ancestor::cl:clause)&gt;1"><span class="emdivider"><xsl:value-of select="$divider"/></span></xsl:when>
				<xsl:otherwise><span class="divider"><xsl:value-of select="$divider"/></span></xsl:otherwise>	
			</xsl:choose>
		
		
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="count(ancestor::cl:clause)&gt;1">emlabel</xsl:when>
					<xsl:otherwise>label</xsl:otherwise>	
				</xsl:choose>
			</xsl:attribute>	
		
<xsl:value-of select="$compname"/>
			<!-- show process, circumstance, participant types? ( TYPES param) -->
			<xsl:if test="$types='show'">
				<xsl:variable name="type" select="@process | @part | @circum"/>	
				<span class="types"><xsl:value-of select="substring($type,1,3)"/></span>
			</xsl:if>
			
		
			<xsl:if test="$spacer='true'">&#160;</xsl:if>
		</span></span>
		<xsl:apply-templates/>		<xsl:if test="parent::cl:*[not(self::cl:clause)]">
			<xsl:choose>
				<xsl:when test="count(ancestor::cl:clause)&gt;1"><span class="emdivider">)</span></xsl:when>
				<xsl:otherwise><span class="divider">)</span></xsl:otherwise>	
			</xsl:choose>
		</xsl:if>	
		</span>

	</xsl:template>
	
	<xsl:template match="wf">
		<span>
		<xsl:choose>
			<xsl:when test="string-length($domain)&gt;0">
				<xsl:if test="parent::w/sem/*[@majorNum=$domain]">
					<xsl:attribute name="class">domainHighlight</xsl:attribute>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$format='inlineDomains' and preceding-sibling::*[self::NON or self::VBF or self::VBP or self::VBN or self::ADV or self::ADJ]">
				<ruby>
					 <xsl:value-of select="."/> 
					<rt>
						<xsl:for-each select="following-sibling::sem/*">
							<xsl:value-of select="@majorNum"/>
							<xsl:if test="position()!=last()">,</xsl:if>
						</xsl:for-each>
					</rt>					
				</ruby>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="."/>&#160;	</xsl:otherwise>
			
		</xsl:choose>
		</span>
	</xsl:template>
	


<!-- calculate clause indent -->

<xsl:template name="indentLevel">
	<xsl:param name="cnt">0</xsl:param>
	<xsl:param name="indent">10</xsl:param>
	<xsl:variable name="connect" select="@connect"/>	
	<xsl:variable name="level" select="@level"	/>
	<xsl:choose>
		<xsl:when test="//chapter/cl:clause[@id=$connect]/@level='primary' or $cnt &gt; 10">
			margin-left: <xsl:value-of select="$indent"/>px;
		</xsl:when>
		<xsl:when test="//chapter/cl:clause[@id=$connect]">
			<xsl:for-each select="//chapter/cl:clause[@id=$connect]">
				<xsl:call-template name="indentLevel">
					<xsl:with-param name="indent">
						<xsl:choose>
							<xsl:when test="$level='secondary'"><xsl:value-of select="$indent"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="number($indent+10)"/></xsl:otherwise>	
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="cnt"><xsl:value-of select="number($cnt)+1"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>margin-left: <xsl:value-of select="$indent"/>px;</xsl:otherwise>	
	</xsl:choose>
</xsl:template>
	

	
</xsl:stylesheet>

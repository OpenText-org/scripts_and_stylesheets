<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:xalan="http://xml.apache.org/xalan"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="wrap">no</xsl:param>
	<xsl:param name="types">no</xsl:param>
	<xsl:param name="showDomains">20</xsl:param>
	
	<xsl:template match="/">
			<html>
				<head>
					<title>Functional Clause Display</title>

					<style type="text/css">
						body { margin: 0px; font-family: Arial; font-size: 8pt; }
					
						.cid { font-size: 7pt; vertical-align: top;}
						
						.clauseText { 
						
							<xsl:choose>
								<xsl:when test="$wrap='no'">white-space: nowrap;</xsl:when>
								<xsl:otherwise>margin-left: 50pt; text-indent: -50pt;</xsl:otherwise>
							</xsl:choose>
								
								font-family: 'Palatino Unicode', Cardo, 'Georgia Greek', Athena;
								font-size: 9pt;
								 
						}
						
						.lc { font-size: 7pt; border: 1px #c0c0c0 solid; vertical-align: top; 
							text-align: center
						}
						.lc2 { font-size: 7pt; border: 1px #c0c0c0 solid; text-align: center;
							vertical-align: top; background-color: #f8f8f8; }						
						
						.types { vertical-align: -2pt; font-size: 7pt; }
						
						table { border-collapse: collapse; } 
						
						.headings { font-size: 8pt;  font-weight: bold;}
						
						.comp { font-family: Arial; margin-left: 2pt;  }
						.clcomp { font-family: Arial; }
						.emdivider { font-size: 9pt; color: #a0a0a0; vertical-align: middle; }
						.label { vertical-align: middle; font-size: 7pt; color: #0000DD; margin-right: 2pt; }

						.emlabel { vertical-align: middle; font-size: 7pt; color: #00DD00;; margin-right: 2pt; }
						.divider { font-size: 12pt; color: #505050; }
						
						.compspan { white-space: nowrap; }
						
						.asp-pf, .cause-act, .att-ass { background-color: #8888FF }
						.asp-ipf, .cause-pas, .att-proj-nc { background-color: #FFFF88}
						.asp-stat, .cause-erg, .att-dir { background-color: #FF8888 }

						.att-proj-c { background-color: green }
						
						.pro-rel { background-color: #FFFF88 }
						.pro-ver { background-color: #88FF88 }
						.pro-men { background-color: #8888FF }
						.pro-beh { background-color: #FF88FF }
						.pro-mat { background-color: #FF8888 }
						.pro-ext { background-color: #FFAA66 }
						
						 .dom {  } 
					 .domgrk { text-decoration: underline; }
					 .domnum { font-family: Arial; font-size: 7pt; vertical-align: 2pt; }
				
					.partTable {  margin: 6pt;
							margin-left: 28pt; 
							border: 1pt #707070 solid;  font-size: 8pt; padding: 4pt;
							margin-bottom: 20pt;					 
					 }
					 
	 
					.partTable th { padding-right: 4pt;  background-color: #88ff88;}
					 
					 
					.partTable td { padding-left: 4pt; padding-right: 4pt; }
					
					h4 { text-align: center; margin-top: 12pt; text-decoration: underline; }
					 
					</style>
					
				</head>
				<body>
				
		<h4>Lexical Cohesion in Mark ch. <xsl:value-of select="//chapter/@num"/></h4>
	
				<div >
					<table class="partTable">
						<thead>
							<tr>
								<th>Num.</th>
								<th>Domain</th>
								<th>Total</th>
							
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
								<xsl:variable name="dnum" select="@num"/>	
								<tr>
									<td><xsl:value-of select="@num"/></td>
									<td class="partName"><xsl:value-of select="."/></td>
									<td><xsl:value-of select="@cnt"/></td>
							 
									
								</tr>
							</xsl:for-each>
						</tbody>	
					</table>
				</div>
	
						
				
				
					<table>
						<thead class="headings">
							<tr>
								<th colspan="2"></th>
							 	<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
								 
									<th><xsl:value-of select="@num"/></th>
								</xsl:for-each>	
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="//chapter/cl:clause"/>	
						</tbody>
						<tfoot class="headings">
							<tr>
								<th colspan="2"></th>
							 	<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
								 
									<th><xsl:value-of select="@num"/></th>
								</xsl:for-each>	
							</tr>
						</tfoot>
					</table>
				</body>
			</html>
	</xsl:template>
	
	<xsl:template match="cl:clause[parent::chapter]">
	
		<tr>
			<td class="cid"><xsl:value-of select="substring-after(@id,'.')"/></td>
			<td>
			<div class="clauseText">
					<span class="clcomp"><span class="divider">|</span></span>			
					<xsl:apply-templates/>
					<span class="clcomp"><span class="divider">||</span></span>
				</div>
			</td>

			<xsl:variable name="cid" select="@id"></xsl:variable>	
			<xsl:variable name="clnode"><xsl:copy-of select="parent::chapter"/></xsl:variable>	

			<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
				<xsl:variable name="class">
					<xsl:choose>
						<xsl:when test="position() mod 2 = 1">lc</xsl:when>
						<xsl:otherwise>lc2</xsl:otherwise>	
					</xsl:choose>
				</xsl:variable>
			
			
				<xsl:variable name="dom" select="@num"/>	
				<xsl:for-each select="xalan:nodeset($clnode)/chapter/cl:clause[@id=$cid]">
				<td class="{$class}">
					
						
					
				<xsl:if test=".//domain[@majorNum=$dom][@select or count(parent::*/domain)=1]">
					<xsl:value-of select="count(.//domain[@majorNum=$dom][@select or count(parent::*/domain)=1])"/><xsl:text>:</xsl:text>
					<xsl:call-template name="clauseDistance">
						<xsl:with-param name="domain"><xsl:value-of select="$dom"/></xsl:with-param>
					</xsl:call-template>
					
		</xsl:if>
		
		</td>			
		</xsl:for-each>
			 </xsl:for-each>	
			
		</tr>
	
	</xsl:template>
	
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
			<xsl:choose>
				<xsl:when test="not(preceding-sibling::cl:* or preceding-sibling::pl:*) and count(ancestor::cl:clause)&gt;1"></xsl:when>
				<xsl:when test="count(ancestor::cl:clause)&gt;1"><span class="emdivider">|</span></xsl:when>
				<xsl:otherwise><span class="divider">|</span></xsl:otherwise>	
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
		
		</span></span>
		<xsl:apply-templates/>	
		</span>		
		
 
	</xsl:template>
	
	
	<xsl:template match="w[VBF|VBN|VBP|ADJ|NON|ADV|PAR]">
	
		<xsl:variable name="dom" select="sem/domain[@select]/@majorNum | sem[count(domain)=1]/domain/@majorNum"/>	
		<xsl:variable name="wf" select="wf"/>	
		
		<xsl:choose>
			<xsl:when test="//domains/dom[@num=$dom and count(preceding-sibling::dom)&lt;$showDomains]">
			<span class="dom">
		<span class="domgrk">
			<xsl:value-of select="$wf"/></span>	
			<span class="domnum"><xsl:value-of select="$dom"/></span>		
		</span>
		&#160;		
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>	
			</xsl:otherwise>	
		</xsl:choose>
	

	</xsl:template>		
	
	
	<xsl:template match="wf">
		<span id="{generate-id()}"><xsl:value-of select="."/>&#160;</span>	
	</xsl:template>
	
	
	<xsl:template name="aspect">

			<td>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="cl:P/w/*[self::VBF or self::VBP or self::VBN]/@tf='aor'">asp-pf</xsl:when>
						<xsl:when test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='pre' or @tf='imp']">asp-ipf</xsl:when>
						<xsl:when test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='per' or @tf='plu']">asp-stat</xsl:when>
					</xsl:choose>
				</xsl:attribute>

			</td>	
	
	</xsl:template>
	
	<xsl:template name="causality">

			<!-- act. -->
			<td>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="cl:P/w/*[self::VBF or self::VBP or self::VBN]/@voc='act'">cause-act</xsl:when>
						<xsl:when test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='pas']">cause-pas</xsl:when>
						<xsl:when test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='mid']">cause-erg</xsl:when>
					</xsl:choose>
				</xsl:attribute>			

			</td>	
		
	
	</xsl:template>
	
	<xsl:template name="process">
	
		<!-- process -->
 
	
			<td >
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="cl:P/@process='relational'">pro-rel</xsl:when>
						<xsl:when test="cl:P/@process='verbal'">pro-ver</xsl:when>
						<xsl:when test="cl:P/@process='mental'">pro-men</xsl:when>
						<xsl:when test="cl:P/@process='behavioural'">pro-beh</xsl:when>
						<xsl:when test="cl:P/@process='material'">pro-mat</xsl:when>
						<xsl:when test="cl:P/@process='existential'">pro-ext</xsl:when>
					</xsl:choose>
				</xsl:attribute>
			</td>							
	</xsl:template>
	
	<xsl:template name="polarity">
		<td/>
	</xsl:template>	
	
	
	<xsl:template name="attitude">

			 
			<td>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="cl:P/w/VBF/@mod='ind'">att-ass</xsl:when>
						<xsl:when test="cl:P/w/VBF/@mod='sub'">att-proj-nc</xsl:when>
						<xsl:when test="cl:P/w/VBF/@mod='opt'">att-proj-c</xsl:when>
						<xsl:when test="cl:P/w/VBF/@mod='imp'">att-dir</xsl:when>
						<xsl:when test="cl:P/w/VBF/@tf='fut'">att-exp</xsl:when>
					</xsl:choose>
				</xsl:attribute>			

			</td>	
		<td/>
	</xsl:template>	

	
		<xsl:template name="clauseDistance">
			<xsl:param name="domain"/>
			<xsl:param name="distance">0</xsl:param>
			
			<xsl:choose>
				<xsl:when test="preceding::cl:clause[parent::chapter][1]//domain[@select]/@majorNum=$domain or preceding::cl:clause[parent::chapter][1]//sem[count(domain)=1]/domain/@majorNum=$domain">
					<xsl:value-of select="$distance"/>
				</xsl:when>
				<xsl:when test="not(preceding::cl:clause[parent::chapter])">x</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="preceding::cl:clause[parent::chapter][1]">
						<xsl:call-template name="clauseDistance">
							<xsl:with-param name="domain"><xsl:value-of select="$domain"/></xsl:with-param>
							<xsl:with-param name="distance"><xsl:value-of select="number($distance)+1"/></xsl:with-param>	
						</xsl:call-template>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
</xsl:stylesheet>

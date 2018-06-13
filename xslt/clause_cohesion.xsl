<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:xalan="http://xml.apache.org/xalan"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="breaks">no</xsl:param>
	<xsl:param name="types">no</xsl:param>
	<xsl:param name="spacer">no</xsl:param>	
	
	<xsl:template match="/">
			<html>
				<head>
					<title>Clause Display</title>

					<style type="text/css">
						body { margin: 0px; font-family: Arial; font-size: 8pt; }
					
										.cid { font-size: 9pt; vertical-align: middle;}
		
						
						.clauseText { 
								<xsl:if test="$breaks='no'">
								white-space: nowrap;
								</xsl:if>
								<xsl:if test="$breaks='yes'">
									margin-left: 50pt;
									text-indent: -50pt;
								</xsl:if>
								font-family: 'Palatino Unicode', Cardo, 'Georgia Greek', Athena;
								font-size: 9pt;
								 margin-bottom: 6pt;
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
						
					 .partHead { font-size: 8pt; }
					 
					 table { border-collapse: collapse; }
					 
					 .ptd { font-size: 7pt; vertical-align: top; border: 1px #c0c0c0 solid; 
					 padding: 0pt; text-align: center;}
					 
					 .part {  } 
					 .partgrk { text-decoration: underline; }
					 .pref { font-family: Arial; font-size: 7pt; vertical-align: 2pt; }
					 
					 .partTotal { font-size: 7pt; color: green; background-color: #f0f0f0; }
					 
					 .cid { font-size: 8pt; color: green }
					 
					 .pocc_G { background-color: #ff8888; color: #505050;}
					 .pocc_R { background-color: #ffff88;  color: #505050;}
					 .pocc_I { background-color: #8888ff;  color: #505050;}
					 
					.partTable {  margin: 6pt;
						margin-left: 28pt; 
					 border: 1pt #707070 solid;  font-size: 8pt; padding: 4pt;}
					 
					 
					.partTable th { padding-right: 4pt;  background-color: #88ff88;}


					.partTable td { text-align: right; }
										
					.partName { padding-right: 10pt; padding-left: 10pt;  text-align: left; }
					
					h4 { text-align: center; margin-top: 12pt; text-decoration: underline; }
						
					</style>
					
				</head>
				<body>
	
				<h4>Participant Reference in Mark ch. <xsl:value-of select="//chapter/@num"/></h4>
	
				<div >
					<table class="partTable">
						<thead>
							<tr>
								<th>#</th>
								<th>Participant</th>
								<th>Total</th>
								<th>Gram.</th>
								<th>Red.</th>
								<th>Impl.</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="//data/participants/part">
								<xsl:variable name="p" select="@num"/>	
								<tr>
									<td><xsl:value-of select="@num"/></td>
									<td class="partName"><xsl:value-of select="@name"/></td>
									<td><xsl:value-of select="count(//w[@pnum=$p or contains(concat('_',@pnum,'_'),concat('_',$p,'_'))])"/></td>
									<td><xsl:value-of select="count(//w[@pnum=$p or contains(concat('_',@pnum,'_'),concat('_',$p,'_'))][@type='G'])"/></td>
									<td><xsl:value-of select="count(//w[@pnum=$p or contains(concat('_',@pnum,'_'),concat('_',$p,'_'))][@type='R'])"/></td>
									<td><xsl:value-of select="count(//w[@pnum=$p or contains(concat('_',@pnum,'_'),concat('_',$p,'_'))][@type='I'])"/></td>
									
								</tr>
							</xsl:for-each>
						</tbody>	
					</table>
				</div>
	
					<table>
						<thead>
							<tr>
								<th></th>
								<th></th>
								<xsl:for-each select="//data/participants/part">
									<th class="partHead"><xsl:value-of select="@num"/></th>
								</xsl:for-each>
							</tr>
							<tr>
								<th></th>
								<th></th>
								<xsl:for-each select="//data/participants/part">
									<td class="partTotal"><xsl:value-of select="@total"/></td>
								</xsl:for-each>
							</tr>
						</thead>
						<tbody>
							 <xsl:apply-templates select="//chapter/cl:clause"/>	
						</tbody>
						<tfoot>
							<tr>
								<th></th>
								<th></th>
								<xsl:for-each select="//data/participants/part">
									<td class="partTotal"><xsl:value-of select="@total"/></td>
								</xsl:for-each>
							</tr>
							<tr>
								<th></th>
								<th></th>
								<xsl:for-each select="//data/participants/part">
									<th class="partHead"><xsl:value-of select="@num"/></th>
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
		
		<xsl:variable name="clnode"><xsl:copy-of select=".//w[@pnum]"/></xsl:variable>	
		<!-- participant references -->
		<xsl:for-each select="//data/participants/part">
			<xsl:variable name="p" select="@num"/>
			<td class="ptd">
				<xsl:for-each select="xalan:nodeset($clnode)//w[@pnum=$p or contains(concat('_',@pnum,'_'),concat('_',$p,'_'))]">
				<div class="pocc_{@type}"><xsl:value-of select="@type"/><xsl:value-of select="substring(@refType,1,1)"/></div>
				</xsl:for-each>
			</td>
		</xsl:for-each>		
		
	</tr>
	</xsl:template>
	
	<xsl:template match="cl:clause[ancestor::cl:clause]">
		<span >
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
		
			<xsl:if test="$spacer='true'">&#160;</xsl:if>
		</span></span>
		<xsl:apply-templates/>	
		</span>
	</xsl:template>
	
	<xsl:template match="w[@pnum]">
	
		<span class="part">
		<span class="partgrk">
			<xsl:value-of select="wf"/></span>	
			<span class="pref"><xsl:value-of select="@pnum"/></span>		
		</span>
		&#160;
	</xsl:template>	
	
	<xsl:template match="wf">
		<xsl:value-of select="."/>&#160;	
	</xsl:template>
	

	
</xsl:stylesheet>

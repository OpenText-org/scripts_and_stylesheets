<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:xalan="http://xml.apache.org/xalan"  
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="wrap">yes</xsl:param>
	<xsl:param name="showDomains">10</xsl:param>
 <xsl:param name="showCounts">0</xsl:param>
	<xsl:param name="process">no</xsl:param>
	<xsl:variable name="processColumns"><xsl:choose><xsl:when test="$process='yes'">5</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
	
 
	
	<xsl:template match="/">
<!--
			<html>
				<head>
					<title>Functional Clause Display</title>
 -->
 <!-- JavaScript : Include and embedded version  
<script src="js/prototype.js" type="text/javascript"></script>
<script src="js/scriptaculous.js" type="text/javascript"></script>
<script src="js/behaviour.js" type="text/javascript"></script>
<script src="js/rules.js" type="text/javascript"></script>-->
	<!--
					<link rel="stylesheet" href="fdisplay.css" type="text/css"/> 
				</head>
			
				<body onload="alert(); Behaviour.apply(); ">
-->


					<table>
						<thead class="headings">
						
						<!-- key -->
						<tr>
							<th colspan="2"></th>
							<td>
							
							</td>
						</tr>
						
						
							<tr>
							<th></th>
								<th colspan="2" class="book-heading">
								
								
		</th>
								<th class="ftm" colspan="{6 + $processColumns}">FIELD</th>
								<th class="ftm" colspan="9">TENOR</th>
								<th class="ftm" colspan="{4 + $showDomains}">MODE</th>
							</tr>
							<tr>
								<th colspan="3"	></th>
								<!-- FIELD -->
								<xsl:if test="$process='yes'">
								<th class="subgroup" colspan="5">PROCESS</th>
								</xsl:if>
								<th class="subgroup" colspan="3">ASPECT</th>
								<th class="subgroup" colspan="3">CAUSAL.</th>
								
								<!-- TENOR -->
								<th class="subgroup" colspan="2">POL.</th>
								<th class="subgroup" colspan="4">ATTITUDE</th>
								<th class="subgroup" colspan="3">PART.</th>	
							<!--	<th class="subgroup" colspan="4">ROLE/COMMODITY</th> -->
								<!-- MODE -->
								<!--
								<th class="subgroup" colspan="3">LEVELS</th>
-->
								<th class="subgroup" colspan="4">THEME</th>
								<th class="subgroup" colspan="{$showDomains}">DOMAINS</th>
							</tr>
							<tr>
								<th>vs.</th>
								<th colspan="2" align="left">clause no.</th>
								<!-- FIELD -->
								<xsl:if test="$process='yes'">
								<!-- process -->
								<th class="subgroup">rel</th>
								<th>ver</th>
								<th>men</th>
								<th>beh</th> 
								<th>mat</th>
						<!--		<th>ext</th> -->
								</xsl:if>
								<!-- aspect -->
								<th class="subgroup">Pf</th>
								<th>If</th>
								<th>St</th>
								<!-- causality -->
								<th class="subgroup">A</th>
								<th>P</th>
								<th>E</th>
								
					
								<!-- TENOR -->
								<!-- polarity -->
								<th class="subgroup">+</th>
								<th>-</th>
								<!-- attitude -->
								<th class="subgroup">ass</th>
								<th>pro</th>
								
								
								<th>dir</th>
								<th>exp</th>
								
								<!-- part. -->
								<th class="subgroup">3</th>
								<th>2</th>
								<th>1</th>
								<!-- role 
								<th class="subgroup">stat</th>
								<th>ques</th>
								 
								<th>off</th>
								<th>com</th>
								-->
								
								<!-- MODE -->
								<!-- level 
								<th class="subgroup">P</th>
								<th>S</th>
								<th>E</th>
								-->
								
								<!-- theme -->
								<th class="subgroup">P</th>
								<th>A</th>
								<th>S</th>
								<th>C</th>
																								
								<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
								 
									<th>
									<xsl:attribute name="class">
										<xsl:choose>
											<xsl:when test="position()=1">subgroup</xsl:when>
											<xsl:otherwise>domlabel</xsl:otherwise>
										</xsl:choose>					
									</xsl:attribute>
									<xsl:value-of select="@num"/></th>
								</xsl:for-each>	
								
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="//chapter/cl.clause"/>	
						

	<!-- reversed headings -->
<span class="headings">
							<tr style="font-size: 7pt;" >
								<th> </th>
								<th colspan="2" align="left"> </th>
								<!-- FIELD -->
								
								<xsl:if test="$process='yes'">
								<!-- process -->
								<th class="subgroup">rel</th>
								<th>ver</th>
								<th>men</th>
								<th>beh</th> 
								<th>mat</th>
						<!--		<th>ext</th> -->
								</xsl:if>
								
								<!-- aspect -->
								<th class="subgroup">Pf</th>
								<th>If</th>
								<th>St</th>
								<!-- causality -->
								<th class="subgroup">A</th>
								<th>P</th>
								<th>E</th>
								
					
								<!-- TENOR -->
								<!-- polarity -->
								<th class="subgroup">+</th>
								<th>-</th>
								<!-- attitude -->
								<th class="subgroup">ass</th>
								<th>pro</th>
								
								
								<th>dir</th>
								<th>exp</th>
								
								<!-- part. -->
								<th class="subgroup">3</th>
								<th>2</th>
								<th>1</th>
								<!-- role 
								<th class="subgroup">stat</th>
								<th>ques</th>
								 
								<th>off</th>
								<th>com</th>
								-->
								
								<!-- MODE -->
								<!-- level 
								<th class="subgroup">P</th>
								<th>S</th>
								<th>E</th>
-->								
								<!-- theme -->
								<th class="subgroup">P</th>
								<th>A</th>
								<th>S</th>
								<th>C</th>			
													
								<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
								 
									<th>
									<xsl:attribute name="class">
										<xsl:choose>
											<xsl:when test="position()=1">subgroup</xsl:when>
											<xsl:otherwise>domlabel</xsl:otherwise>
										</xsl:choose>					
									</xsl:attribute>
									<xsl:value-of select="@num"/></th>
								</xsl:for-each>	
								
							</tr>

							<tr>
								<th colspan="3"	></th>
								<!-- FIELD -->
								<xsl:if test="$process='show'">
								<th class="subgroup" colspan="5">PROCESS</th>
								</xsl:if>
								<th class="subgroup" colspan="3">ASPECT</th>
								<th class="subgroup" colspan="3">CAUSAL.</th>
								
								<!-- TENOR -->
								<th class="subgroup" colspan="2">POL.</th>
								<th class="subgroup" colspan="4">ATTITUDE</th>
								<th class="subgroup" colspan="3">PART.</th>	
							<!--	<th class="subgroup" colspan="4">ROLE/COMMODITY</th> -->
								<!-- MODE -->
								<!--
								<th class="subgroup" colspan="3">LEVELS</th>
-->
								<th class="subgroup" colspan="4">THEME</th>
								<th class="subgroup" colspan="{$showDomains}">DOMAINS</th>
							</tr>

								<tr>
								<th colspan="3"></th>
								<th class="ftm" colspan="{6 + $processColumns}">FIELD</th>
								<th class="ftm" colspan="9">TENOR</th>
								<th class="ftm" colspan="{4 + $showDomains}">MODE</th>
							</tr>
</span>
<!-- ======== total ======== -->
</tbody>
					
<xsl:if test="$showCounts=1">
	<xsl:call-template name="summaryCounts"/>
</xsl:if>					
					
					</table>
	
	<!--
 	</body>
			</html>  
-->
	</xsl:template>
	
	<xsl:template name="summaryCounts">
						<!-- summary counts -->
						<tfoot>

							<tr >
								<th colspan="3" style="text-align:right">TOTALS&#160; &#160;</th>
										<!-- FIELD -->
								<xsl:if test="$process='yes'">
								<!-- process types -->
								<th class="subgroup">
									<xsl:value-of select="count(//cl.P[count(ancestor::cl.clause)=1][@process='relational'  or @process='existential'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//cl.P[count(ancestor::cl.clause)=1][@process='verbal'])"/>
								</th>
								<th>
										<xsl:value-of select="count(//cl.P[count(ancestor::cl.clause)=1][@process='mental'])"/>
								</th>
								<th>
<xsl:value-of select="count(//cl.P[count(ancestor::cl.clause)=1][@process='behavioural'])"/>								
								</th> 
								<th>
<xsl:value-of select="count(//cl.P[count(ancestor::cl.clause)=1][@process='material'])"/>								
								</th>
								</xsl:if>
									<!-- aspect -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@tf='aor'])"/>								
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@tf='pre' or @tf='imp'])"/>										
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@tf='per' or @tf='plu'])"/>
								</th>
								<!-- causality -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@voc='act'])"/>	
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@voc='pas'])"/>	
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@voc='mid'])"/>	
								</th>
								
					
								<!-- TENOR -->
								<!-- polarity -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl.clause[@polarity='positive'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause[@polarity='negative'])"/>
								</th>
								<!-- attitude -->
								<th class="subgroup"> 
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/VBF[@mod='ind'][not(@tf='fut')])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/VBF[@mod='sub'])"/>
								</th>
								
								
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/VBF[@mod='imp'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/cl.P/w/pos/VBF[@tf='fut'])"/>
								</th>
								
								<!-- part. -->
								<th class="subgroup">
									<xsl:value-of select="count(//w/pos/*[@per='3rd'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//w/pos/*[@per='2nd'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//w/pos/*[@per='1st'])"/>
								</th>
									
								<!-- MODE -->
								<!-- level 
								<th class="subgroup"></th>
								<th></th>
								<th></th>
								-->
								
								<!-- theme -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl.clause/*[self::cl.S or self::cl.A or self::cl.P or self::cl.C][1][name()='cl.P'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/*[self::cl.S or self::cl.A or self::cl.P or self::cl.C][1][name()='cl.A'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/*[self::cl.S or self::cl.A or self::cl.P or self::cl.C][1][name()='cl.S'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl.clause/*[self::cl.S or self::cl.A or self::cl.P or self::cl.C][1][name()='cl.C'])"/>		
								</th>										
								
								<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
									 <xsl:variable name="dom" select="@num"/>	
									<th>
									<xsl:attribute name="class">
										<xsl:choose>
											<xsl:when test="position()=1">subgroup</xsl:when>
											<xsl:otherwise>domlabel</xsl:otherwise>
										</xsl:choose>					
									</xsl:attribute>
									
									
									<xsl:value-of select="count(//w[pos/*[1][self::VBN or self::VBF or self::VBP or self::NON or self::ADJ or self::ADV]]/sem/domain[@majorNum=$dom][@select or count(parent::*/domain)=1][1])"/>									
									</th>
								</xsl:for-each>	
								
							</tr>
							-->
							<tr>
								<td><div style="height: 40px;">&#160;</div></td>
							</tr>
							

		
						</tfoot>	
					
						
	
	</xsl:template>
	
	<xsl:template match="cl.clause[parent::chapter]">
		<xsl:variable name="vnum" select=".//w[1]/@ref"/>	
		<xsl:variable name="cid" select="@xml:id"/>	
		<tr>
			<td class="vnum">
				<xsl:if test="not(preceding-sibling::cl.clause//w[1]/@ref=$vnum)">
					<xsl:text></xsl:text><xsl:value-of select="substring-after(substring-after($vnum,'.'),'.')"/>
				</xsl:if>
			</td>
			<td class="cid">
				
				<xsl:text></xsl:text><xsl:value-of select="substring-after(@xml:id,'_')"/>
			
			</td>
			<td class="texttd">		
			
			<xsl:if test="@level='secondary' or @level='secondary2'"> <span >
			<xsl:attribute name="style">
				<xsl:call-template name="indentLevel"/>
			</xsl:attribute></span >
		</xsl:if>
		
			<div class="clauseText">
					<span class="clcomp"><span class="divider">|</span></span>			
					<xsl:apply-templates/>
					<span class="clcomp"><span class="divider">||</span></span>
				</div>
			</td>
			<xsl:if test="$process='yes'">
				<xsl:call-template name="process"/>
			</xsl:if>
			<xsl:call-template name="aspect"/>
			<xsl:call-template name="causality"/>
		
			
			<xsl:call-template name="polarity"/>
			<xsl:call-template name="attitude"/>	
			<xsl:call-template name="part"/>
			
		 
			<xsl:call-template name="mode"/>
			
			
		</tr>
	
	</xsl:template>
	
	<xsl:template match="cl.clause[ancestor::cl.clause]">
		<span class="compspan">
		<span class="clcomp"><span class="emdivider">[[</span></span>			
		<xsl:apply-templates/>
		<span class="clcomp"><span class="emdivider">]]</span></span>
		</span>
	</xsl:template>
	
	<xsl:template match="cl.S | cl.P | cl.C | cl.A | pl.conj |cl.add |cl.gap">
		<xsl:variable name="cname">
			<xsl:choose>
				<xsl:when test="name()='pl.conj'">cj</xsl:when>
				<xsl:when test="name()='cl.gap'"></xsl:when>
				<xsl:otherwise><xsl:value-of select="substring-after(name(),'.')"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<span >
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="cl.clause"></xsl:when>
					<xsl:otherwise>compspan</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="not(preceding-sibling::*[starts-with(name(),'cl.')] or preceding-sibling::*[starts-with(name(),'pl.')])">clcomp</xsl:when>
					<xsl:otherwise>comp</xsl:otherwise>	
				</xsl:choose>	
			</xsl:attribute>
			<xsl:variable name="divider">
				<xsl:choose>
 					<xsl:when test="parent::*[starts-with(name(),'cl.') and not(self::cl.clause)]">(</xsl:when>
					<xsl:otherwise>|</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
					<xsl:when test="not(preceding-sibling::*[starts-with(name(),'cl.')] or preceding-sibling::*[starts-with(name(),'pl.')]) and count(ancestor::cl.clause)&gt; 1 and parent::cl.clause"></xsl:when>
  				<xsl:when test="count(ancestor::cl.clause)&gt;1"><span class="emdivider"><xsl:value-of select="$divider"/></span></xsl:when>
	<xsl:when test="not(preceding-sibling::*[starts-with(name(),'cl.')] or preceding-sibling::*[starts-with(name(),'pl.')]) and count(ancestor::cl.clause)&gt;1"></xsl:when>				
				<xsl:otherwise><span class="divider"><xsl:value-of select="$divider"/></span></xsl:otherwise>	
			</xsl:choose>
		

		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="count(ancestor::cl.clause)&gt;1">emlabel</xsl:when>
					<xsl:otherwise>label</xsl:otherwise>	
				</xsl:choose>
			</xsl:attribute>	
		<xsl:value-of select="$cname"/></span></span>
		<xsl:apply-templates/>	
		<xsl:if test="parent::*[starts-with(name(),'cl.')][not(self::cl.clause)]">
			<xsl:choose>
				<xsl:when test="count(ancestor::cl.clause)&gt;1"><span class="emdivider">) </span></xsl:when>
				<xsl:otherwise><span class="divider">) </span></xsl:otherwise>	
			</xsl:choose>
		</xsl:if>	
		</span>		
		
 
	</xsl:template>
	
	
	<xsl:template match="wf[ancestor::pl.conj/ancestor::cl.clause[1]/parent::chapter]">
		<span class="conj"><xsl:value-of select="."/></span>&#160;	
	</xsl:template>	
	
	<xsl:template match="wf">
		<span class="word" id="{parent::w/@xml:id}"><xsl:value-of select="."/></span>&#160;	
	</xsl:template>
	
	<!--
	<xsl:template match="w[pos/*[self::VBF or self::VBN or self::VBP or self::ADJ or self::NON or self::ADV or self::PAR]]">
	
		<xsl:variable name="dom" select="sem/domain[@select]/@majorNum | sem[count(domain)=1]/domain/@majorNum"/>	
		<xsl:variable name="wf" select="wf"/>	
		
		<xsl:choose>
			<xsl:when test="//domains/dom[@num=$dom and count(preceding-sibling::dom)&lt;$showDomains]">
			<span class="dom">
		<span class="domgrk">
			<xsl:if test="ancestor::pl.conj/ancestor::cl.clause[1]/parent::chapter"><xsl:attribute name="class">domgrk-conj</xsl:attribute></xsl:if>
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
	-->
	
	<!-- glosses -->
	<xsl:template match="gloss"/>
	
	
	<!-- named templates -->
	
	<xsl:template name="aspect">
			<!-- Pf. -->
			<td class="subgroup">
				<xsl:if test="cl.P/w/pos/*[self::VBF or self::VBP or self::VBN]/@tf='aor'">
					<xsl:attribute name="class">asp-pf showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>
				</xsl:if>
			</td>
			<!-- Impf. -->
			<td >
				<xsl:if test="cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@tf='pre' or @tf='imp']">
					<xsl:attribute name="class">asp-ipf showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>
				</xsl:if>
			</td>
			<!-- Stat. -->
			<td >
				<xsl:if test="cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@tf='per' or @tf='plu']">
					<xsl:attribute name="class">asp-stat showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>	
	
	</xsl:template>
	
	<xsl:template name="causality">

			<!-- act. -->
			<td class="subgroup">
				<xsl:if test="cl.P/w/pos/*[self::VBF or self::VBP or self::VBN]/@voc='act'">
					<xsl:attribute name="class">cause-act showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>
			<!-- Pass. -->
			<td >
				<xsl:if test="cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@voc='pas']">
					<xsl:attribute name="class">cause-pas showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>
			<!--Erg. -->
			<td >
				<xsl:if test="cl.P/w/pos/*[self::VBF or self::VBP or self::VBN][@voc='mid']">
					<xsl:attribute name="class">cause-erg showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>	
		
	
	</xsl:template>
	
	<xsl:template name="process">
	
		<!-- process -->
 
	
			<td class="subgroup">
			<xsl:choose>
				<xsl:when test="cl.P[@process='relational' or @process='existential']">
					<xsl:attribute name="class">pro-rel</xsl:attribute>
				</xsl:when>
	<!--			<xsl:when test=".//cl.clause/cl.P[@process='relational' or @process='existential']">
					<xsl:attribute name="class">pro-rel2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>	
			<td >
				<xsl:choose>
				<xsl:when test="cl.P/@process='verbal'">
					<xsl:attribute name="class">pro-ver</xsl:attribute>
				</xsl:when>
	<!--			<xsl:when test=".//cl.clause/cl.P[@process='verbal']">
					<xsl:attribute name="class">pro-ver2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>		
			<td >
			<xsl:choose>
				<xsl:when test="cl.P/@process='mental'">
					<xsl:attribute name="class">pro-men</xsl:attribute>
				</xsl:when>
		<!--		<xsl:when test=".//cl.clause/cl.P[@process='mental']">
					<xsl:attribute name="class">pro-men2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>
		
			<td >
				<xsl:choose>
				<xsl:when test="cl.P/@process='behavioural'">
					<xsl:attribute name="class">pro-beh</xsl:attribute>
				</xsl:when>
	<!--			<xsl:when test=".//cl.clause/cl.P[@process='behavioural']">
					<xsl:attribute name="class">pro-beh2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>
				
			<td >
				<xsl:choose>
				<xsl:when test="cl.P/@process='material'">
					<xsl:attribute name="class">pro-mat</xsl:attribute>
				</xsl:when>
		<!--		<xsl:when test=".//cl.clause/cl.P[@process='material']">
					<xsl:attribute name="class">pro-mat2</xsl:attribute>
				</xsl:when>  -->
				</xsl:choose>
			</td>
			<!--
			<td >
				<xsl:if test="cl.P/@process='existential'">
					<xsl:attribute name="class">pro-ext</xsl:attribute>
				</xsl:if>
			</td>		-->					
	</xsl:template>
	
	<xsl:template name="polarity">
		<td class="subgroup">
			<xsl:if test="@polarity='positive'">
				<xsl:attribute name="class">polarity-plus</xsl:attribute>
			</xsl:if>
		</td>
		<td>
			<xsl:if test="@polarity='negative'">
				<xsl:attribute name="class">polarity-</xsl:attribute>
			</xsl:if>		
		</td>
	</xsl:template>	
	
	
	<xsl:template name="attitude">

			<!-- ass. -->
			<td class="subgroup">
				<xsl:if test="cl.P/w/pos/VBF[@mod='ind'][not(@tf='fut')]">
					<xsl:attribute name="class">att-ass showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>
			<!-- proj - nc -->
			<td >
				<xsl:if test="cl.P/w/pos/VBF/@mod='sub'">
					<xsl:attribute name="class">att-proj-nc showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>
			<!-- proj - c 
			<td >
				<xsl:if test="cl.P/w/pos/VBF/@mod='opt'">
					<xsl:attribute name="class">att-proj-c</xsl:attribute>
				</xsl:if>
			</td>
-->
			<!-- dir -->	
			<td>
				<xsl:if test="cl.P/w/pos/VBF/@mod='imp'">
					<xsl:attribute name="class">att-dir showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>	
			
			<!-- exp -->	
			<td>
				<xsl:if test="cl.P/w/pos/VBF/@tf='fut'">
					<xsl:attribute name="class">att-exp showWord</xsl:attribute>
					<xsl:attribute name="onmouseover">sw('<xsl:value-of select="cl.P/w/@xml:id"/>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				</xsl:if>
			</td>	
	
	</xsl:template>	
	
	<xsl:template name="part">
				<!-- 3rd -->	
			<td class="subgroup">
				<xsl:if test=".//w/pos/*/@per='3rd'">
					<xsl:attribute name="class">p3 showWord</xsl:attribute>
				
					<xsl:attribute name="onmouseover">sw('<xsl:for-each select=".//w[pos/*/@per='3rd']"><xsl:value-of select="@xml:id"/><xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if></xsl:for-each>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>				
				 
				</xsl:if>
			</td>	
			
			<!-- 2nd -->	
			<td>
				<xsl:if test=".//w/pos/*/@per='2nd'">
					<xsl:attribute name="class">p2 showWord</xsl:attribute>
									<xsl:attribute name="onmouseover">sw('<xsl:for-each select=".//w[pos/*/@per='2nd']"><xsl:value-of select="@xml:id"/><xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if></xsl:for-each>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>		
				</xsl:if>
			</td>	
			
			<!-- 1st -->	
			<td>
				<xsl:if test=".//w/pos/*/@per='1st'">
					<xsl:attribute name="class">p1 showWord</xsl:attribute>
										<xsl:attribute name="onmouseover">sw('<xsl:for-each select=".//w[pos/*/@per='1st']"><xsl:value-of select="@xml:id"/><xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if></xsl:for-each>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>		
				</xsl:if>
			</td>				
	
	</xsl:template>	
	
	
	<xsl:template name="role">
		<td class="subgroup"	/>
		<td/>
		<td/>
		<td/>
	</xsl:template>		
	
	<xsl:template name="mode">
<!--
		<td class="subgroup">
			<xsl:if test="@level = 'primary'">
				<xsl:attribute name="class">cl-pri</xsl:attribute>
			</xsl:if>
		</td>
		<td>	
			<xsl:if test="starts-with(@level, 'secondary')">
				<xsl:attribute name="class">cl-sec</xsl:attribute>
			</xsl:if>
		</td>
		<td>	
			<xsl:if test=".//cl.clause/@level = 'embedded'">
				<xsl:attribute name="class">cl-emb</xsl:attribute>
			</xsl:if>
		</td>
	-->	
		<xsl:variable name="compname"	select="substring-after(name(*[self::cl.S or self::cl.A or self::cl.P or self::cl.C][1]),'.')" />
		
		<xsl:variable name="comp"	select="*[self::cl.S or self::cl.A or self::cl.P or self::cl.C][1]" />
		
		<!--
		<xsl:variable name="compatt"	select="substring(xalan:nodeset($comp)/@process | xalan:nodeset($comp)/@circum | xalan:nodeset($comp)/@part,1,3)" />
		-->
		<xsl:variable name="compatt"></xsl:variable>
				
		<td class="subgroup">
			<xsl:if test="$compname='P'">
				<xsl:attribute name="class">th-P</xsl:attribute>
				<xsl:value-of  select="$compatt"/> 
			</xsl:if>
		</td>
		<td>
			<xsl:if test="$compname='A'">
				<xsl:attribute name="class">th-A</xsl:attribute>
				<xsl:value-of  select="$compatt"/> 
			</xsl:if>
		</td>
		<td>
			<xsl:if test="$compname='S'">
				<xsl:attribute name="class">th-S</xsl:attribute>
				<xsl:value-of  select="$compatt"/> 
			</xsl:if>
		</td>
		<td>
			<xsl:if test="$compname='C'">
				<xsl:attribute name="class">th-C</xsl:attribute>
				<xsl:value-of  select="$compatt"/> 
			</xsl:if>
		</td>		
		
		
			<xsl:variable name="cid" select="@xml:id"></xsl:variable>	
			<xsl:variable name="clnode"><xsl:copy-of select="."/></xsl:variable>	
<!-- domains -->
	<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
				<xsl:variable name="class">
					<xsl:choose>
						<xsl:when test="position()=1">subgroup</xsl:when>
						<xsl:when test="position() mod 2 = 1">lc</xsl:when>
						<xsl:otherwise>lc2</xsl:otherwise>	
					</xsl:choose>
				</xsl:variable>
			
			
				<xsl:variable name="dom" select="@num"/>	
				<xsl:for-each select="xalan:nodeset($clnode)">
				<td class="{$class}">
				<xsl:if test=".//w[pos/*[self::VBN or self::VBF or self::VBP or self::NON or self::ADJ or self::ADV]]/sem/domain[@majorNum=$dom][@select or count(parent::*/domain)=1]">
				<xsl:attribute name="class"><xsl:value-of select="$class"/> showWord</xsl:attribute>
				 
				
					<xsl:attribute name="onmouseover">sw('<xsl:for-each select=".//w[pos/*[self::VBN or self::VBF or self::VBP or self::NON or self::ADJ or self::ADV]]/sem/domain[@majorNum=$dom][@select or count(parent::*/domain)=1][1]"><xsl:value-of select="ancestor::w/@xml:id"/><xsl:if test="not(position()=last())"><xsl:text> </xsl:text></xsl:if></xsl:for-each>')</xsl:attribute>
					<xsl:attribute name="onmouseout">hw()</xsl:attribute>						
				
				<xsl:text/>
					<xsl:value-of select="count(.//w[pos/*[self::VBN or self::VBF or self::VBP or self::NON or self::ADJ or self::ADV]]/sem/domain[@majorNum=$dom][@select or count(parent::*/domain)=1][1])"/>

		
		</xsl:if>
		
		</td>			
		</xsl:for-each>
			 </xsl:for-each>			
		
	</xsl:template>
	
	
	
		<xsl:template name="clauseDistance">
			<xsl:param name="domain"/>
			<xsl:param name="distance">0</xsl:param>
			
			<xsl:choose>
				<xsl:when test="preceding::cl.clause[parent::chapter][1]//domain[@select]/@majorNum=$domain or preceding::cl.clause[parent::chapter][1]//sem[count(domain)=1]/domain/@majorNum=$domain">
					<xsl:value-of select="$distance"/>
				</xsl:when>
				<xsl:when test="not(preceding::cl.clause[parent::chapter])">x</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="preceding::cl.clause[parent::chapter][1]">
						<xsl:call-template name="clauseDistance">
							<xsl:with-param name="domain"><xsl:value-of select="$domain"/></xsl:with-param>
							<xsl:with-param name="distance"><xsl:value-of select="number($distance)+1"/></xsl:with-param>	
						</xsl:call-template>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	
	
<xsl:template name="indentLevel">
	<xsl:param name="cnt">0</xsl:param>
	<xsl:param name="indent">10</xsl:param>
	<xsl:variable name="connect" select="@connect"/>	
	<xsl:variable name="level" select="@level"	/>
	<xsl:choose>
		<xsl:when test="//chapter/cl.clause[@xml:id=$connect]/@level='primary' or $cnt &gt; 10">
			margin-left: <xsl:value-of select="$indent"/>px;
		</xsl:when>
		<xsl:when test="//chapter/cl.clause[@xml:id=$connect]">
			<xsl:for-each select="//chapter/cl.clause[@xml:id=$connect]">
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

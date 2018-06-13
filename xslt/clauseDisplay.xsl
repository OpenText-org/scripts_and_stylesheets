<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:xalan="http://xml.apache.org/xalan" xmlns:ot="http://www.opentext.org/data"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="wrap">no</xsl:param>
	<xsl:param name="showDomains">10</xsl:param>
	
	<ot:styles>
	
		<styleSet id="disciples-active">
			background-color: rgb(255, 230, 204)
		</styleSet>
		
		<styleSet id="disciples-passive">
			background-color: rgb(206, 255, 234)
		</styleSet>
		
	
	</ot:styles>
	
	<xsl:template match="/">
			<html>
				<head>
					<title>Functional Clause Display</title>

					<style type="text/css">
						body { margin: 0px; font-family: Arial; font-size: 8pt; }
						
							.ftm { font-size: 12pt; font-weight: bold; border-left: 1px solid #909090;}
						
						.vnum { font-size: 11pt; font-weight: bold; vertical-align: top; border: 0}
					
						.cid { font-size: 7pt; vertical-align: top; border: 0; color: #202020;}
						
						.texttd { border: 0 }
						
						td { border-top: solid 1px #f0f0f0; }
						
						.subgroup { border-left: 1px solid #909090; font-size: 7pt;}
						
							.grk { font-family: 'Palatino Linotype', Cardo, 'Georgia Greek', Athena;
								font-size: 10pt;}
						
						.clauseText { 
						
							<xsl:choose>
								<xsl:when test="$wrap='no'">white-space: nowrap;</xsl:when>
								<xsl:otherwise>margin-left: 50pt; text-indent: -50pt;</xsl:otherwise>
							</xsl:choose>
								
								font-family: 'Palatino Linotype', Cardo, 'Georgia Greek', Athena;
								font-size: 10pt;
								 border-top: solid 1px #f0f0f0;
						}
						
						table { border-collapse: collapse; } 
						
						.headings { font-size: 7pt; }
						
						.headings th { vertical-align: bottom;}
						
						.comp { font-family: Arial; margin-left: 2pt;  }
						.clcomp { font-family: Arial; }
						.emdivider { font-size: 9pt; color: #a0a0a0; vertical-align: middle; }
						.label { vertical-align: middle; font-size: 7pt; color: #0000DD; margin-right: 2pt; }

						.emlabel { vertical-align: middle; font-size: 7pt; color: #00DD00;; margin-right: 2pt; }
						.divider { font-size: 12pt; color: #505050; }
						
						.compspan { white-space: nowrap; }
						
						.asp-pf, .cause-act, .att-ass, .polarity-plus, .p3 { background-color: #AAAAFF; border-left: 1px solid #909090; width: 8px;}
						.asp-ipf, .cause-pas, .att-dir, .p2 { background-color:  rgb(250,238,95); width: 10px;}
						.asp-stat, .cause-erg, .att-exp, .polarity-, .p1 { background-color: #FF8888; width: 10px; }

						.att-proj-nc { background-color: #88CCAA; width: 10px; }
						
						.pro-rel { background-color: #d0d0d0; border-left: 1px solid #909090;  width: 8px;}
						.pro-ver { background-color: #d0d0d0; width: 8px; }
						.pro-men { background-color: #d0d0d0; width: 8px; }
						.pro-beh { background-color: #d0d0d0; width: 8px; }
						.pro-mat { background-color: #d0d0d0; width: 8px;}
						.pro-ext { background-color: #d0d0d0; width: 8px; }
						
						.pro-rel2 { background-color: #e0e0e0; border-left: 1px solid #909090;  width: 8px;}
						.pro-ver2 { background-color: #e0e0e0; width: 8px; }
						.pro-men2 { background-color: #e0e0e0; width: 8px; }
						.pro-beh2 { background-color: #e0e0e0; width: 8px; }
						.pro-mat2 { background-color: #e0e0e0; width: 8px;}
						.pro-ext2 { background-color: #e0e0e0; width: 8px; }
						
							.pro-bl { border: 0; background-color: #d0d0d0; width: 8px; }
							
							
						.cl-pri { background-color: #d0d0d0; border-left: 1px solid #909090;  width: 8px;}
						 .cl-sec, .cl-emb {  background-color: #d0d0d0; width: 8px; }

						.th-P { background-color: #AAAAFF; border-left: 1px solid #909090; 
									width: 8px; font-size: 8pt;}
						.th-S { background-color: rgb(250,238,95); }
						.th-A { background-color: #88CCAA; } 
						.th-C  {  background-color: #FF8888; }
						 
						 
						.lc { font-size: 7pt;   vertical-align: top; 
							text-align: center; width: 8px;
						}
						.lc2 { font-size: 7pt;   text-align: center;
							vertical-align: top; background-color: #f8f8f8; width: 8px;}					
							
							
								 .dom {  } 
					 .domgrk { text-decoration: underline; }
					.domgrk-conj { text-decoration: underline; background-color: #FFCCCC; }
					.conj { background-color: #FFCCCC; } 
					 .domnum { font-family: Arial; font-size: 7pt; vertical-align: 2pt; }
					 
					 .domlabel { border-left: 1px solid #f0f0f0; }
					 
					 tfoot th { font-size: 8pt; border-top: 2px solid #707070; }
					
					tfoot .subgroup { border-left: 1px solid #909090; font-size: 8pt;}
						
					.key-domains, .key-tenor,  .key-process, .key-field { font-size: 8pt; font-weight: normal; }
					
					.key-domains td, .key-tenor td, .key-process td, .key-field td { vertical-align: top; border: 0; padding-left: 1px;}
						
					.key-gloss { font-weight: normal; }
					
					.key td, .key th { vertical-align: top; }
					
					.key { background-color: rgb(255,240,240) }
					
					
					.cl-label { font-size: 8pt; color: black}
					
					.norule { border: 0; }
					
					.keyrule { border-top: 4px double red; }
					
					.book-heading { font-size: 12pt; font-family: Times; text-decoration: underline; }
						
						
					.indent { margin-left: 10pt; }
					</style>
					
				</head>
				<body>
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
								<th colspan="2" class="book-heading"><xsl:value-of select="//chapter/@book"/>. Ch. <xsl:value-of select="//chapter/@num"/></th>
								<th class="ftm" colspan="11">FIELD</th>
								<th class="ftm" colspan="9">TENOR</th>
								<th class="ftm" colspan="{4 + $showDomains}">MODE</th>
							</tr>
							<tr>
								<th colspan="3"	></th>
								<!-- FIELD -->
								<th class="subgroup" colspan="5">PROCESS</th>
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
								
								<!-- process -->
								<th class="subgroup">rel</th>
								<th>ver</th>
								<th>men</th>
								<th>beh</th> 
								<th>mat</th>
						<!--		<th>ext</th> -->
								
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
							<xsl:apply-templates select="//chapter/cl:clause"/>	
						

	<!-- reversed headings -->
<span class="headings">
							<tr style="font-size: 7pt;" >
								<th> </th>
								<th colspan="2" align="left"> </th>
								<!-- FIELD -->
								
								<!-- process -->
								<th class="subgroup">rel</th>
								<th>ver</th>
								<th>men</th>
								<th>beh</th> 
								<th>mat</th>
						<!--		<th>ext</th> -->
								
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
								<th class="subgroup" colspan="5">PROCESS</th>
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
								<th class="ftm" colspan="11">FIELD</th>
								<th class="ftm" colspan="9">TENOR</th>
								<th class="ftm" colspan="{4 + $showDomains}">MODE</th>
							</tr>
</span>
<!-- ======== total ======== -->
</tbody>
						<!-- summary counts -->
						<tfoot>

							<tr >
								<th colspan="3" style="text-align:right">TOTALS&#160; &#160;</th>
										<!-- FIELD -->
								
								<!-- process types -->
								<th class="subgroup">
									<xsl:value-of select="count(//cl:P[count(ancestor::cl:clause)=1][@process='relational'  or @process='existential'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//cl:P[count(ancestor::cl:clause)=1][@process='verbal'])"/>
								</th>
								<th>
										<xsl:value-of select="count(//cl:P[count(ancestor::cl:clause)=1][@process='mental'])"/>
								</th>
								<th>
<xsl:value-of select="count(//cl:P[count(ancestor::cl:clause)=1][@process='behavioural'])"/>								
								</th> 
								<th>
<xsl:value-of select="count(//cl:P[count(ancestor::cl:clause)=1][@process='material'])"/>								
								</th>
								
									<!-- aspect -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='aor'])"/>								
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='pre' or @tf='imp'])"/>										
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='per' or @tf='plu'])"/>
								</th>
								<!-- causality -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='act'])"/>	
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='pas'])"/>	
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='mid'])"/>	
								</th>
								
					
								<!-- TENOR -->
								<!-- polarity -->
								<th class="subgroup">
									<xsl:value-of select="count(//chapter/cl:clause[@polarity='positive'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause[@polarity='negative'])"/>
								</th>
								<!-- attitude -->
								<th class="subgroup"> 
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/VBF[@mod='ind'][not(@tf='fut')])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/VBF[@mod='sub'])"/>
								</th>
								
								
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/VBF[@mod='imp'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//chapter/cl:clause/cl:P/w/VBF[@tf='fut'])"/>
								</th>
								
								<!-- part. -->
								<th class="subgroup">
									<xsl:value-of select="count(//w/*[@per='3rd'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//w/*[@per='2nd'])"/>
								</th>
								<th>
									<xsl:value-of select="count(//w/*[@per='1st'])"/>
								</th>
									
								<!-- MODE -->
								<!-- level 
								<th class="subgroup"></th>
								<th></th>
								<th></th>
								-->
								
								<!-- theme -->
								<th class="subgroup"></th>
								<th></th>
								<th></th>
								<th></th>										
								
								<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
									 <xsl:variable name="dom" select="@num"/>	
									<th>
									<xsl:attribute name="class">
										<xsl:choose>
											<xsl:when test="position()=1">subgroup</xsl:when>
											<xsl:otherwise>domlabel</xsl:otherwise>
										</xsl:choose>					
									</xsl:attribute>
									
									
									<xsl:value-of select="count(//domain[@majorNum=$dom][@select or count(parent::*/domain)=1][1])"/>									
									</th>
								</xsl:for-each>	
								
							</tr>
							<tr>
								<td><div style="height: 40px;">&#160;</div></td>
							</tr>
							
<!-- ================= KEY ======================== -->							
<tr class="key">
  <td colspan="2" class="keyrule"> &#160;
    </td>
    <td  class="keyrule"> <!-- text key -->  
    
  
	  <table width="100%">
			  <thead>
						<tr>
							<th class="norule" colspan="2">CLAUSE STRUCTURE &amp; COMPONENTS</th>
							<th class="norule" colspan="2">PROCESS TYPES</th>
						</tr>
					</thead>
				<tbody>
					<tr>
					
	<td>
		<div><span class="divider">|</span><span class="label">cj</span> <span class="cl-label"> conjunction </span> <span class="divider">|</span></div>
		<div><span class="divider">|</span><span class="label">S</span> <span class="cl-label"> subject </span> <span class="divider">|</span></div>
		<div><span class="divider">|</span><span class="label">P</span> <span class="cl-label">predicator (verbal process) </span> <span class="divider">|</span></div>
		<div><span class="divider">|</span><span class="label">C</span> <span class="cl-label">complement (object) </span> <span class="divider">|</span></div>
		<div><span class="divider">|</span><span class="label">A</span> <span class="cl-label"> adjunct (circumstance) </span> <span class="divider">|</span></div>
	</td>					
					
						<td>
						
							<div>
<span class="clcomp"><span class="divider">|</span></span><span class="compspan"><span class="clcomp"><span class="divider">|</span></span></span>	
 <span class="cl-label"> INDEPEDENT CLAUSE BOUNDARIES </span>
<span class="clcomp"><span class="divider">|</span></span><span class="compspan"> <span class="divider">|</span>	</span>						
							</div>
						
						<div>
<span class="emdivider">[[</span> 
 <span class="cl-label"> EMBEDDED CLAUSE BOUNDARIES </span>
<span class="emdivider">]]</span> 						
						</div>
						
						<div>
<span class="emdivider">|</span><span class="emlabel">S/P/C/A</span>		
<span class="cl-label">embedded clause component</span>
<span class="emdivider">|</span>				
						</div>
						<div>
								<span class="dom"><span class="grk"><span class="domgrk">λέγει</span></span><span class="domnum">33</span> <span class="cl-label"> word from domain 33</span></span>
						</div>
						<div>
							<span class="grk"><span class="conj">καὶ</span></span> <span class="cl-label"> conjunctive cohesive word</span>
						</div>
						</td>
	

	
	<td   >
	
	  <!-- process key -->
	
		<table class="key-process">
		 
			<tbody>
				<tr>
					<th class="pro-bl">rel</th>
					<td>relational</td>
				</tr>
				<tr>
					<th  class="pro-bl">ver</th>
					<td>verbal</td>
				</tr>
				<tr>
					<th  class="pro-bl">men</th>
					<td  >mental</td>
				</tr>
				<tr>
					<th  class="pro-bl">beh</th>
					<td>behavioural</td>
				</tr>
				<tr>
					<th  class="pro-bl">mat</th>
					<td>material</td>
				</tr>
			</tbody>
		</table>
	</td>
	
</tr>
<tr>
	<td>&#160;</td>
</tr>
<tr>
<!--
	<td colspan="2">
		<xsl:attribute name="style">
			<xsl:value-of select="document('')//styleSet[@id='disciples-active']"/>;
			border: 1px #707070 solid;
		</xsl:attribute>		
	 <span class="cl-label"> clause containing reference to disciples as active participants</span></td>
-->
</tr>
<tr>
<!--
	<td colspan="2">
		<xsl:attribute name="style">
			<xsl:value-of select="document('')//styleSet[@id='disciples-passive']"/>;
			 border: 1px #707070 solid;
		</xsl:attribute>		
	 <span class="cl-label" > clause containing reference to disciples as passive participants (recipients)</span></td>
-->
</tr>
				</tbody>
			</table>
	  	
	</td>
	<!-- FIELD keys -->
	<!-- aspect + causality key -->
	<td colspan="11"  class="keyrule">

		<table class="key-field">
			<tbody>
			<tr>
				<th colspan="2" class="norule" >ASPECT <span class="key-gloss">(tense-form)</span></th>
				</tr>
				<tr>
					<td class="asp-pf">Pf</td>
					<td>perfective (aorist)</td>
				</tr>
				 <tr>
					<td class="asp-ipf">If</td>
					<td>imperfective (present/ imperfect)</td>
				</tr>
				<tr>
					<td class="asp-stat">St</td>
					<td>stative (perfect/ pluperfect)</td>
				</tr>
				
			<tr>
				<th colspan="2">CAUSALITY <span class="key-gloss">(voice)</span></th>
				
				</tr>
				<tr>
					<td class="cause-act">A</td>
					<td>active</td>
				</tr>
				<tr>
					<td class="cause-pas">P</td>
					<td>passive</td>
				</tr>
				<tr>
					<td class="cause-erg">E</td>
					<td>ergative (middle)</td>
				</tr>
				
				
				</tbody>
			</table>
	</td>

	<!-- TENOR -->
	<td colspan="9"  class="keyrule">
	

	<table class="key-tenor">
		<tbody>

<tr>
				<th class="norule" colspan="2">POL. 
				<span class="key-gloss">(polarity)</span></th>
				</tr>
							<tr>
				<td class="polarity-plus">+</td>
				<td>positive</td>
			</tr>
								<tr>
				<td class="polarity-">-</td>
				<td>negative</td>
			</tr>
			
		 
		
<tr>
				<th colspan="2">ATTITUDE
				<span class="key-gloss">(mood)</span></th>
				
			</tr>
			<tr>
				<td class="att-ass">ass</td>
				<td>assertive (indicative)</td>
			</tr>
			<tr>
				<td class="att-proj-nc">pro</td>
				<td>subjective (subjunctive)</td>
			</tr>
			<tr>
				<td class="att-dir">dir</td>
				<td>directive (imperative)</td>
			</tr>
			<tr>
				<td class="att-exp">exp</td>
				<td>expectative (future)</td>
			</tr>			
 	
		
			<tr>
				<th colspan="2">PARTICIPATION <span class="key-gloss">(person)</span></th>
				
			</tr>
			<tr>
				<td class="p3">3</td><td>3rd per.</td>
			</tr>
			<tr>
				<td class="p2">2</td><td>2nd per.</td>
			</tr>
			<tr>
				<td class="p1">1</td><td>1st per.</td>
			</tr>
		</tbody>
	</table>	
	
	</td>
			
	<!-- MODE -->
	<td colspan="10"  class="keyrule">

		<table class="key-domains">
			<thead>
				<tr>
					<th colspan="2" class="norule" >SEMANTIC DOMAINS</th>
				</tr>
			</thead>
			<tbody>
			
			<xsl:for-each select="//data/domains/dom[position()&lt;=$showDomains]">
				<xsl:variable name="dom" select="@num"/>
				<tr>
					<td align="right"><xsl:value-of select="$dom"/>. </td>
					<td><xsl:value-of select="//domains/dom[@num=$dom]"/></td>
				</tr>
			</xsl:for-each>
			</tbody>
		</table>
	
	</td>  
  
  </tr>
							
	<!-- ============= END OF KEY ============== -->					
						</tfoot>	
					
						
					</table>
				</body>
			</html>
	</xsl:template>
	
	<xsl:template match="cl:clause[parent::chapter]">
		<xsl:variable name="vnum" select=".//w[1]/@vs"/>	
		<xsl:variable name="cid" select="@id"/>	
		<tr>
			<td class="vnum">
				<xsl:if test="not(preceding::cl:clause//w[1]/@vs=$vnum)">
					<xsl:text></xsl:text><xsl:value-of select="$vnum"/>
				</xsl:if>
			</td>
			<td class="cid">
				
				<xsl:text>c</xsl:text><xsl:value-of select="substring-after(@id,'_')"/>
			
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
			
				<xsl:call-template name="process"/>
			<xsl:call-template name="aspect"/>
			<xsl:call-template name="causality"/>
		
			
			<xsl:call-template name="polarity"/>
			<xsl:call-template name="attitude"/>	
			<xsl:call-template name="part"/>
			
		 
			<xsl:call-template name="mode"/>
			
			
		</tr>
	
	</xsl:template>
	
	<xsl:template match="cl:clause[ancestor::cl:clause]">
		<span class="compspan">
		<span class="clcomp"><span class="emdivider">[[</span></span>			
		<xsl:apply-templates/>
		<span class="clcomp"><span class="emdivider">]]</span></span>
		</span>
	</xsl:template>
	
	<xsl:template match="cl:S | cl:P | cl:C | cl:A | pl:conj |cl:add">
		<xsl:variable name="cname">
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
		<xsl:value-of select="$cname"/></span></span>
		<xsl:apply-templates/>	
		</span>		
		
 
	</xsl:template>
	
	
	<xsl:template match="wf[ancestor::pl:conj/ancestor::cl:clause[1]/parent::chapter]">
		<span class="conj"><xsl:value-of select="."/></span>&#160;	
	</xsl:template>	
	
	<xsl:template match="wf">
		<xsl:value-of select="."/>&#160;	
	</xsl:template>
	
	
	<xsl:template match="w[VBF|VBN|VBP|ADJ|NON|ADV|PAR]">
	
		<xsl:variable name="dom" select="sem/domain[@select]/@majorNum | sem[count(domain)=1]/domain/@majorNum"/>	
		<xsl:variable name="wf" select="wf"/>	
		
		<xsl:choose>
			<xsl:when test="//domains/dom[@num=$dom and count(preceding-sibling::dom)&lt;$showDomains]">
			<span class="dom">
		<span class="domgrk">
			<xsl:if test="ancestor::pl:conj/ancestor::cl:clause[1]/parent::chapter"><xsl:attribute name="class">domgrk-conj</xsl:attribute></xsl:if>
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
	
	<!-- glosses -->
	<xsl:template match="gloss"/>
	
	
	<!-- named templates -->
	
	<xsl:template name="aspect">
			<!-- Pf. -->
			<td class="subgroup">
				<xsl:if test="cl:P/w/*[self::VBF or self::VBP or self::VBN]/@tf='aor'">
					<xsl:attribute name="class">asp-pf</xsl:attribute>
				</xsl:if>
			</td>
			<!-- Impf. -->
			<td >
				<xsl:if test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='pre' or @tf='imp']">
					<xsl:attribute name="class">asp-ipf</xsl:attribute>
				</xsl:if>
			</td>
			<!-- Stat. -->
			<td >
				<xsl:if test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@tf='per' or @tf='plu']">
					<xsl:attribute name="class">asp-stat</xsl:attribute>
				</xsl:if>
			</td>	
	
	</xsl:template>
	
	<xsl:template name="causality">

			<!-- act. -->
			<td class="subgroup">
				<xsl:if test="cl:P/w/*[self::VBF or self::VBP or self::VBN]/@voc='act'">
					<xsl:attribute name="class">cause-act</xsl:attribute>
				</xsl:if>
			</td>
			<!-- Pass. -->
			<td >
				<xsl:if test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='pas']">
					<xsl:attribute name="class">cause-pas</xsl:attribute>
				</xsl:if>
			</td>
			<!--Erg. -->
			<td >
				<xsl:if test="cl:P/w/*[self::VBF or self::VBP or self::VBN][@voc='mid']">
					<xsl:attribute name="class">cause-erg</xsl:attribute>
				</xsl:if>
			</td>	
		
	
	</xsl:template>
	
	<xsl:template name="process">
	
		<!-- process -->
 
	
			<td class="subgroup">
			<xsl:choose>
				<xsl:when test="cl:P[@process='relational' or @process='existential']">
					<xsl:attribute name="class">pro-rel</xsl:attribute>
				</xsl:when>
	<!--			<xsl:when test=".//cl:clause/cl:P[@process='relational' or @process='existential']">
					<xsl:attribute name="class">pro-rel2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>	
			<td >
				<xsl:choose>
				<xsl:when test="cl:P/@process='verbal'">
					<xsl:attribute name="class">pro-ver</xsl:attribute>
				</xsl:when>
	<!--			<xsl:when test=".//cl:clause/cl:P[@process='verbal']">
					<xsl:attribute name="class">pro-ver2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>		
			<td >
			<xsl:choose>
				<xsl:when test="cl:P/@process='mental'">
					<xsl:attribute name="class">pro-men</xsl:attribute>
				</xsl:when>
		<!--		<xsl:when test=".//cl:clause/cl:P[@process='mental']">
					<xsl:attribute name="class">pro-men2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>
		
			<td >
				<xsl:choose>
				<xsl:when test="cl:P/@process='behavioural'">
					<xsl:attribute name="class">pro-beh</xsl:attribute>
				</xsl:when>
	<!--			<xsl:when test=".//cl:clause/cl:P[@process='behavioural']">
					<xsl:attribute name="class">pro-beh2</xsl:attribute>
				</xsl:when> -->
				</xsl:choose>
			</td>
				
			<td >
				<xsl:choose>
				<xsl:when test="cl:P/@process='material'">
					<xsl:attribute name="class">pro-mat</xsl:attribute>
				</xsl:when>
		<!--		<xsl:when test=".//cl:clause/cl:P[@process='material']">
					<xsl:attribute name="class">pro-mat2</xsl:attribute>
				</xsl:when>  -->
				</xsl:choose>
			</td>
			<!--
			<td >
				<xsl:if test="cl:P/@process='existential'">
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
				<xsl:if test="cl:P/w/VBF[@mod='ind'][not(@tf='fut')]">
					<xsl:attribute name="class">att-ass</xsl:attribute>
				</xsl:if>
			</td>
			<!-- proj - nc -->
			<td >
				<xsl:if test="cl:P/w/VBF/@mod='sub'">
					<xsl:attribute name="class">att-proj-nc</xsl:attribute>
				</xsl:if>
			</td>
			<!-- proj - c 
			<td >
				<xsl:if test="cl:P/w/VBF/@mod='opt'">
					<xsl:attribute name="class">att-proj-c</xsl:attribute>
				</xsl:if>
			</td>
-->
			<!-- dir -->	
			<td>
				<xsl:if test="cl:P/w/VBF/@mod='imp'">
					<xsl:attribute name="class">att-dir</xsl:attribute>
				</xsl:if>
			</td>	
			
			<!-- exp -->	
			<td>
				<xsl:if test="cl:P/w/VBF/@tf='fut'">
					<xsl:attribute name="class">att-exp</xsl:attribute>
				</xsl:if>
			</td>	
	
	</xsl:template>	
	
	<xsl:template name="part">
				<!-- 3rd -->	
			<td class="subgroup">
				<xsl:if test=".//w/*/@per='3rd'">
					<xsl:attribute name="class">p3</xsl:attribute>
				</xsl:if>
			</td>	
			
			<!-- 2nd -->	
			<td>
				<xsl:if test=".//w/*/@per='2nd'">
					<xsl:attribute name="class">p2</xsl:attribute>
				</xsl:if>
			</td>	
			
			<!-- 1st -->	
			<td>
				<xsl:if test=".//w/*/@per='1st'">
					<xsl:attribute name="class">p1</xsl:attribute>
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
			<xsl:if test=".//cl:clause/@level = 'embedded'">
				<xsl:attribute name="class">cl-emb</xsl:attribute>
			</xsl:if>
		</td>
	-->	
		<xsl:variable name="compname"	select="local-name(*[self::cl:S or self::cl:A or self::cl:P or self::cl:C][1])" />
		
		<xsl:variable name="comp"	select="*[self::cl:S or self::cl:A or self::cl:P or self::cl:C][1]" />
		
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
		
		
			<xsl:variable name="cid" select="@id"></xsl:variable>	
			<xsl:variable name="clnode"><xsl:copy-of select="parent::chapter"/></xsl:variable>	
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
				<xsl:for-each select="xalan:nodeset($clnode)/chapter/cl:clause[@id=$cid]">
				<td class="{$class}">
					
						
					
				<xsl:if test=".//domain[@majorNum=$dom][@select or count(parent::*/domain)=1]">
				<xsl:text/>
					<xsl:value-of select="count(.//domain[@majorNum=$dom][@select or count(parent::*/domain)=1][1])"/>
<!--					
					<xsl:text>:</xsl:text>
					<xsl:call-template name="clauseDistance">
						<xsl:with-param name="domain"><xsl:value-of select="$dom"/></xsl:with-param>
					</xsl:call-template>
		-->			
		</xsl:if>
		
		</td>			
		</xsl:for-each>
			 </xsl:for-each>			
		
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

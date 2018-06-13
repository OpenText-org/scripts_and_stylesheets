<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:cl="http://www.opentext.org/ns/clause"
	xmlns:pl="http://www.opentext.org/ns/paragraph"
	xmlns:wg="http://www.opentext.org/ns/word-group"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
	<xsl:param name="id"/>
	<xsl:param name="view"/>
	<xsl:param name="sunit"/>
	
	<xsl:param name="mode">view</xsl:param>
	
<xsl:param name="showIDs">0</xsl:param>

  <xsl:param name="modifier-names">
    <modifiers>
      <modifier name="specifier" abbrev="sp"/>
      <modifier name="definer" abbrev="df"/>
      <modifier name="qualifier" abbrev="ql"/>
      <modifier name="relator" abbrev="rl"/>
      <modifier name="connector" abbrev="cn"/>
    </modifiers>
  </xsl:param>
	
	
	
	
	<xsl:variable name="displayMode">
		<xsl:choose>
			<xsl:when test="//view[@id=$view]"><xsl:value-of select="//view[@id=$view]/@displayMode"/></xsl:when>
			<xsl:otherwise>word</xsl:otherwise>	
		</xsl:choose>	
	</xsl:variable>
	
	<xsl:variable name="num">123456789</xsl:variable>
	<xsl:variable name="char">abcdefghij</xsl:variable>
	
	<xsl:template match="/">
	
		<html>
			<head>
				<title>Synopsis Test</title>
				<style type="text/css">

					body { font-family: Arial; 
					<xsl:if test="$mode!='print'">
					background-color: #f0f0f0;  
					</xsl:if>
					
					margin: 0px; margin-left: 4px; margin-right: 5px;				
					}
					
					.inlinecomp { display: inline;  margin-left: 2px; margin-right: 2px;}
				
					.vid { margin-top: 2pt; margin-bottom: 4pt;  }
					.cid { font-style: italic; }
				
					.grk, .clauseGrk { font-family: Cardo, 'Georgia Greek',  'Palatino Linotype',  'Arial Unicode MS' }
					.clauseGrk { font-size: 9pt;}
					.clauseid { font-family: Arial; font-size: 7pt;  vertical-align:top}
					.vnum { font-family: Arial; font-size: 8pt; vertical-align: top;}
					
					.clause { border: 1px solid #707070; padding: 0pt; border-collapse: collapse;
						margin-bottom: 12pt; text-align: left;
						page-break-inside: avoid; 
					}
					
					.process { font-family: Arial Narrow; font-weight: normal; font-size: 7pt; vertical-align: -2px; }
					
					table { border-collapse: collapse;}
					
					.clause td { padding: 1pt;   }
					
					.comptd {  border: 1px solid #707070; padding: 1px; text-align: left; }
					
						.compcontent { vertical-align: top; }
					
					.compheading { font-size: 8pt; font-weight: bold; font-family: Arial; vertical-align: top; }
					
					td { vertical-align: top; }
					
					.sunitID {   font-size: 9pt;   font-weight: bold;  padding: 2px; margin-bottom: 10px; display: block;
					 }
					
					.sunitTR { page-break-inside: avoid;  }
				
					.sunitTD { border: 1px #707070 dotted; padding: 10px;
							page-break-inside: avoid; 
					}
					
					.text { position: relative;
					
					.padding-right: 10pt;
					
					<xsl:choose>
						<xsl:when test="$mode='edit'">height: 200px;</xsl:when>
						<xsl:otherwise>height: 500px;</xsl:otherwise>	
					</xsl:choose>
			 
		 

 
						<xsl:if test="$mode!='print'">
						scrollbar-base-color: MEDIUM;
						scrollbar-face-color: MEDIUM;
						scrollbar-track-color: BACKGROUND;
						scrollbar-highlight-color: LIGHT;
						scrollbar-3dlight-color: MEDIUM;
						scrollbar-shadow-color: DARK;
						scrollbar-darkshadow-color: MEDIUM;
						scrollbar-arrow-color: DARK;
							overflow: auto; 
						</xsl:if>
				
					
					width:100% }
					
					#synopticUnits { margin-top: 20pt; border-top: 1px solid black; }
					
					 
					.subody { position: relative; overflow: auto; height: 30%; }
					
					.comp {} 
					
					.label{  font-size: 10pt;  }
					
					#units th { font-family: Arial }
					
					.sulabel { font-family: Arial; margin-top: 0px; background-color: #bbffbb }
					
					.viewTitle { 	margin: 4px;
	background-color: rgb(120,210,104);
	padding: 10px; font-weight: bold; }
					 
					 
					<xsl:if test="string-length($sunit)>0 and $mode='view'">
						.text-parallels
						{
							position: relative;
							height: 500px;
							overflow: auto;
						}
					</xsl:if>
					 
					#filters { background-color: #ff8888; margin: 2px; }
					 
					
					#sunits { background-color: rgb(255,188,155); margin: 2px; }
					  
					  
	.group .wid { font-family: Arial; font-size: 8pt; color: green}
	.group td {   padding: 2px}
        .modHead { font-family: Arial; background-color: #c0c0c0; 
                   color: blue; font-size: 8pt; text-align: center}
	.group {  margin-bottom: 20px;}
	.word { border: 1px #303030 solid}
        .group-label { font-family: Arial; font-size: 9pt;
                       text-align: left;
                       color: red; vertical-align: center;
                     }					  
					  
					 .titleSection { margin-bottom: 12pt;  width: 100%; padding: 6pt; border-bottom: 1px solid #000000; }
					 .titleSection-title { font-size: 14pt; font-weight: bold; text-align: left; }
					 .titleSection-crossref { font-size: 10pt; text-align: right; }
					 
					 
	.clid2  { color: #ffffff; background-color: #000000; font-family: Arial; font-size: 8pt; }
	
	
	.emclause
	{
		border: 2px #909090 solid; padding: 4px;
		
	}
	
				</style>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				
				 
				<script src="synopsis.js"> &#160; </script>
				
				<script>
				
				<!-- create order array capturing the ordering of components in selected view  -->
				<xsl:text>var order = new Array(</xsl:text>
				<xsl:for-each select="//views/view[@id=$view]/components/col">
					<xsl:text>"</xsl:text>
					<xsl:value-of select="substring(@ref,1,3)"/>
					<xsl:text>"</xsl:text>
					<xsl:if test="not(position()=last())"><xsl:text>, </xsl:text>	</xsl:if>
				</xsl:for-each>	
				<xsl:text>);</xsl:text>
				
				
				<!-- ref array -->
				<xsl:text>var ref = new Array(</xsl:text>
				<xsl:for-each select="//views/view[@id=$view]/components/col">
					<xsl:text>"</xsl:text>
					<xsl:value-of select="@ref"/>
					<xsl:text>"</xsl:text>
					<xsl:if test="not(position()=last())"><xsl:text>, </xsl:text>	</xsl:if>
				</xsl:for-each>	
				<xsl:text>);</xsl:text>				
				
				</script>
				
				
				
			</head>
			<body>
			
		 
 
			<xsl:if test="$mode='view'">
			<div class="viewTitle">View <xsl:value-of select="//views/view[@id=$view]/@id"/> - <xsl:value-of select="//views/view[@id=$view]/test"/>
			
				<span style="width:50px;"/>
				<span><a href="parallel?id={$id}">UNIT</a></span>
				<span style="width:50px;"/>
				<span><a href="menu">MENU</a></span>
			</div>
			<div id="filters">
				<div onclick="showHide(this)"><span class="plusMinus">+</span> FILTERS</div>
				<div style="display: none; font-size: 12pt">
<form action="view">	
				<input type="hidden" name="id" value="{$id}"/>
				
				<input type="hidden" name="view" value="{$view}"/>
				
				<xsl:if test="string-length($sunit)&gt;0">
				<input type="hidden" name="sunit" value="{$sunit}"/>
				
				</xsl:if>
			 
				<input type="checkbox" name="filter-f1"><xsl:if test="//filter[@id='f1']"><xsl:attribute name="checked">1</xsl:attribute></xsl:if></input> aorist forms in blue
<br/>				
				<input type="checkbox" name="filter-f2"><xsl:if test="//filter[@id='f2']"><xsl:attribute name="checked">1</xsl:attribute></xsl:if></input> present forms in red
<br/>		
				<input type="checkbox" name="filter-f3"><xsl:if test="//filter[@id='f3']"><xsl:attribute name="checked">1</xsl:attribute></xsl:if></input> perfect forms in green
<br/>		
				<input type="checkbox" name="filter-f4"><xsl:if test="//filter[@id='f4']"><xsl:attribute name="checked">1</xsl:attribute></xsl:if></input> highlight forms of SPEIRW forms in green
		<br/>	
				<input type="submit" value="apply"/>
</form>
				
				
				</div>
			</div>

			<div id="sunits">
				<div onclick="showHide(this)"><span class="plusMinus">+</span> SYNOPTIC UNITS</div>
				<div style="display: none;">
				
					<xsl:apply-templates select="/parallelUnit/synopticUnits/synopticUnitSet[@mode=$displayMode]" mode="select"/>		
 
		<button onclick="window.location='view?id={$id}&amp;view={$view}&amp;mode=edit'">Add New Set</button>
	
				</div>
			</div>
			
			</xsl:if>
			
			<!-- TITLE SECTION -->
			<div >
			<table class="titleSection">
				<tbody>
					<tr>
						<td class="titleSection-title">
					<xsl:value-of select="/parallelUnit/thesisref"/><xsl:text>: </xsl:text>
					<xsl:value-of select="/parallelUnit/title"/>
			 						
						</td>
						<td class="titleSection-crossref">
											<xsl:text>Aland: </xsl:text><xsl:value-of select="substring-after(/parallelUnit/synopsiscrossref/aland,'Pericope ')"/>
					<xsl:text> / Greeven: </xsl:text><xsl:value-of select="substring-after(/parallelUnit/synopsiscrossref/greeven,'Pericope ')"/>
						</td>
					</tr>
				</tbody>
			</table>

 
			</div>
			
			<!-- end of title section -->
			
			<xsl:choose>
				<xsl:when test="$mode='print'">
				<xsl:apply-templates select="//views/view[@id=$view]"/>
				</xsl:when>
				<xsl:otherwise>
					<div class="text-parallels">
						<xsl:apply-templates select="//views/view[@id=$view]"/>
					</div>					
				</xsl:otherwise>	
			</xsl:choose>

			
			</body>
		</html>
	
	</xsl:template>
	
	<!-- =================================================

	template to handle selected view and format text in column display
	using appropriate templates for specified mode

    ==================================================== -->
	<xsl:template match="view">
	
				<table width="100%">
					<thead>
						<tr>
							<xsl:if test="($mode='view' or $mode='print') and contains($sunit,'su')">
								<th/>
							</xsl:if>
						
							<xsl:apply-templates select="components/col" mode="label"/>		
						</tr>
					</thead>
					<tbody>
						<!-- if sunit is selected and in view mode then display
							  components in table with rows matching synoptic units
						-->
						<xsl:choose>
							<xsl:when test="$mode!='edit' and //synopticUnitSet[@id=$sunit]">
								<xsl:apply-templates select="//synopticUnitSet[@id=$sunit]"/>		
							</xsl:when>
							<xsl:otherwise>

								<tr>
									<xsl:apply-templates select="components/col"/>		
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</tbody>
				</table>


		<xsl:if test="$mode='edit'">

				<div id="synopticUnits">
				<div class="sulabel">Synoptic Units
				<button onclick="addSynopticUnit()">Create synoptic unit</button>
				<button onclick="outputSUnits()">Output</button>
				</div>	
				<div class="subody">	
				<table id="units" width="100%" border="0"	>
					<thead>
						<tr>
							<xsl:apply-templates select="components/col" mode="label"/>		
						</tr>
					</thead>
					<tbody >
						 <xsl:apply-templates select="//synopticUnitSet[@id=$sunit]"/>		
					</tbody>
				</table>
				</div>
				</div>
		
		</xsl:if>		
				
	</xsl:template>
	
	<!-- ====================================
		template for col element in selected view
	    creates column in parallel tex t table and
        fires appropriate templates for text reference in ref attribute,

		e.g. <col ref="Mark"/>

	    pulls the text from component with id equal 'Mark'
        and formats according to view display mode
	====================================== -->
	
	<xsl:template match="col">
		<xsl:variable name="ref" select="@ref"/>	

		<td class="comp">
			 <div class="text">
				<xsl:apply-templates select="//parallelUnit/components/component[@id=$ref]/*[not(self::label)]"/>	
			</div>
		</td>
	</xsl:template>
	
	<!-- label for column (pulled from label in component definition -->
	<xsl:template match="col" mode="label">
		<xsl:variable name="ref" select="@ref"/>	

		<th class="label">
			<xsl:apply-templates select="//parallelUnit/components/component[@id=$ref]/label"/>
		</th>
	</xsl:template>	
	
	<xsl:template match="component/text"/>
	
	 <xsl:template match="label">
			 <xsl:apply-templates/>	
	 </xsl:template>
	
	


	<!-- templates for main text unit, i.e. either clauses or verses -->
	
	<xsl:template match="clauses">
	
		<xsl:apply-templates select="cl:clause"/>		
	
	</xsl:template>

	<!-- if wordgroup is view mode, use word group templates -->
	<xsl:template match="wordgroups">
		<xsl:apply-templates select="wg:group"/>
	</xsl:template>
	
	<xsl:template match="verse">
		<div class="verse">
			
			<xsl:apply-templates select="w">
					<xsl:with-param name="vn" select="@num"/>		
			</xsl:apply-templates>
		</div>
		
	</xsl:template>
	
	<xsl:template match="w">
		  
		<span class="grk" id="{@id}">

		<xsl:call-template name="filters"></xsl:call-template>
		
			<xsl:if test="$mode='edit'"><xsl:attribute name="onclick">select(this)</xsl:attribute></xsl:if>
			<xsl:if test="not(preceding-sibling::w)"><span class="vnum"><xsl:value-of select="parent::verse/@num"/></span></xsl:if>
			 <xsl:value-of select="wf"/>
		</span>
		&#160;
	</xsl:template>
	
	<xsl:template match="synopticUnit">
		<xsl:if test="@page-break-before='yes'">
		<tr class="sunitTR" style="page-break-before: always; margin-top: 20pt;">
			<th><div/></th>
		</tr>
		</xsl:if>
		<tr class="sunitTR">
<!--				<xsl:if test="@page-break-before='yes'"><xsl:attribute name="style">page-break-before: always</xsl:attribute></xsl:if> -->
				<xsl:variable name="sunit" select="."/>	
				<xsl:variable name="suid">
					<xsl:choose>
						<xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="count(preceding-sibling::synopticUnit)+1"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>  
	 
			 	
				<xsl:for-each select="//view[@id=$view]/components/col">
					<xsl:variable name="comp" select="@ref"/>	

<xsl:if test="position()=1"> <td><span class="sunitID"><xsl:value-of select="$suid"/></span> </td></xsl:if>					
					
					<td class="sunitTD"> 
						<div style="page-break-inside: avoid">
					
						<xsl:apply-templates select="xalan:nodeset($sunit)//component[@ref=$comp]" mode="sunit"/>		</div>	
					</td>
				</xsl:for-each>
			
		</tr>
	</xsl:template>
	
	<xsl:template match="component" mode="sunit">
		<xsl:apply-templates mode="sunit"/>
				
	</xsl:template>
	 
	
	<xsl:template match="w" mode="sunit">
		<xsl:variable name="id" select="@xlink:href"/>
		 <xsl:choose>
				<xsl:when test="ancestor::synopticUnitSet/@mode='clause'">
					<xsl:apply-templates select="//cl:clause[@id=$id]"/>	
				</xsl:when>
				<xsl:when test="ancestor::synopticUnitSet/@mode='wordgroup'">
					<xsl:apply-templates select="//wg:group[@id=$id]"/>	
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="//w[@id=$id]"/>	
				</xsl:otherwise>
			</xsl:choose>
						
	</xsl:template>	
	
	
	<!-- ==========================================================
	
				CLAUSE MODE TEMPLATES 
	
	n.b. templates for modes should probably be imported into stylesheet

	============================================================ -->
	
	<xsl:template match="cl:clause">
		<xsl:variable name="id" select="@id"/>

		<xsl:choose>
			<xsl:when test="parent::clauses">
			
			<span id="{$id}">
				<xsl:if test="$mode='edit'"><xsl:attribute name="onclick">select(this)</xsl:attribute></xsl:if>
	 
		

					<table class="clause">
						 
						<tr>
							<th class="clauseid">
								<!-- calculate chap-verse ref for clause -->
								<div class="vid">
									<xsl:value-of select="substring-before(@id,'.')"/>
									<xsl:text>.</xsl:text>
									 <xsl:call-template name="calculateVID"/>
							 	 </div>
							 	 <div class="cid">
								<xsl:value-of select="concat('c', substring-after(@id,'_'))"/>
								</div>
							</th>
							<xsl:apply-templates/>
						</tr>
					</table>

	</span>	
	
			
			</xsl:when>
			<xsl:otherwise>
			

					<table  class="clause">
						 
						<tr>
							<th class="clauseid">		 <br/>	 <div class="cid">
								<xsl:value-of select="concat('c', substring-after(@id,'_'))"/>
							</div>
							 
							</th>
							<xsl:apply-templates/>
						</tr>
					</table>

			</xsl:otherwise>
		</xsl:choose>
	
		
	</xsl:template>
	
	
	
	<xsl:template match="cl:S|cl:P|cl:A|cl:C|cl:F|cl:add|cl:gap">
		 <xsl:variable name="cname">
			 <xsl:choose>
					<xsl:when test="self::cl:gap"></xsl:when>
					<xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
				</xsl:choose>
		 </xsl:variable>
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P' or local-name() = 'F']">
				<table class="comptd" style="display: inline; margin-left: 2px; margin-right: 2px;">
					<td  >
						<table border="0">
							<tr>
								<th class="compheading">
									 
										<xsl:value-of select="$cname"/>
										<xsl:if test="@process | @circum | @part">
											<span class="process"><xsl:value-of select="substring(@process | @circum | @part,1,3)"/></span>
										</xsl:if>
								</th>
							</tr>
							<tr>
								<td class="compcontent">
									<xsl:apply-templates select="text()|*[not(@connect)]"/>
								</td>
							</tr>
						</table>
					</td>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td valign="top" class="comptd">
					<table border="0">
						<tr>
							<th class="compheading">
								 
									<xsl:value-of select="$cname"/>
								 										<xsl:if test="@process | @circum | @part">
											<span class="process"><xsl:value-of select="substring(@process | @circum | @part,1,3)"/></span>
										</xsl:if>
							</th>
						</tr>
						<tr>
							<td class="compcontent">
								<xsl:apply-templates select="text()|*[not(@connect)]"/>
							</td>
						</tr>
					</table>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="pl:conj">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name()='A' or local-name()='C' or local-name()='P' or local-name() = 'F']">

<table class="inlinecomp">
	<tbody>
		<tr>
			<td class="comptd" >
					<table>
						<tbody>
							<tr>
								<th class="compheading">cj</th>
							</tr>
							<tr>
								<td class="compcontent"><xsl:apply-templates/></td>
							</tr>
						</tbody>
					</table>
					
				</td>

		</tr>
	</tbody>
</table>

				
						</xsl:when>
			<xsl:otherwise>
				<td class="comptd" >
					<table>
						<tbody>
							<tr>
								<th class="compheading">cj</th>
							</tr>
							<tr>
								<td><xsl:apply-templates/></td>
							</tr>
						</tbody>
					</table>
					
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="cl:conj">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name()='A' or local-name()='C' or local-name()='P' or local-name()='F']">
				<table>
					<tr>
						<th>
							<xsl:text/>
						</th>
					</tr>
					<tr>
						<td>
							<xsl:apply-templates/>
						</td>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td >
					<table>
						<tr>
							<th>
								<xsl:text/>
							</th>
						</tr>
						<tr>
							<td>
								<xsl:apply-templates/>
							</td>
						</tr>
					</table>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!--
	 if word elements do not have content by an xlink to the the w element in the base text file
      pull value from correct location
-->
	
	<xsl:template match="w[@xlink:href]">
		<span class="clauseGrk">
			
			<xsl:for-each select="//w[@id=current()/@xlink:href]">
				<span class="grk" id="{@id}">
				<xsl:call-template name="filters"></xsl:call-template>
				<xsl:apply-templates/><xsl:text> </xsl:text>
				</span>
			</xsl:for-each>
		 </span>
	</xsl:template>
	
	<xsl:template match="synopticUnits" mode="select">
		<div>
		</div>
	</xsl:template>
	
	<xsl:template match="synopticUnitSet" mode="select">
		<xsl:if test="@id!=$sunit">
		<div>
		 <a href="view?id={$id}&amp;sunit={@id}&amp;view={$view}" ><xsl:value-of select="@id"/><xsl:text> </xsl:text><xsl:value-of select="label"/>
		 </a></div>
		 </xsl:if>
	</xsl:template>
	
		<xsl:template match="synopticUnitSet/label"/>
	
	
		<xsl:template name="filters">
				<xsl:variable name="wd" ><xsl:copy-of select="."/></xsl:variable>
				<xsl:attribute name="style">
					
				<xsl:if test="//filter[@id='f1'] and *[1][self::VBF or self::VBP or self::VBN]/@tf='aor'">color: blue;</xsl:if>
				<xsl:if test="//filter[@id='f2'] and *[1][self::VBF or self::VBP or self::VBN]/@tf='pre'">color: red;</xsl:if>
				<xsl:if test="//filter[@id='f3'] and *[1][self::VBF or self::VBP or self::VBN]/@tf='per'">color: green</xsl:if>
			
<!--			
				<xsl:if test="//filter[@id='f2'] and sem/domain/@majorNum='33'">background-color: #f0fff0</xsl:if>
-->				
				<xsl:if test="//filter[@id='f4'] and wf/@betaLex='spei/rw'">background-color: rgb(255,255,190)</xsl:if>
				
				<!--
				<xsl:if test="//filter[@id='f5'] and sem/domain/@majorNum='15'">background-color: rgb(255,213,234)</xsl:if>
-->

				</xsl:attribute>
		</xsl:template>
		
		
		<!-- calculate verse id for current clause 
			 by locating ch-vs nums for first word in clause and then
			looking for preceding clauses with same ch-vs ref.
		-->
		<xsl:template name="calculateVID">
			<xsl:param name="refid"/>
			<xsl:param name="cnt">0</xsl:param>
			<xsl:variable name="wid" select=".//w[1]/@xlink:href"/>
			<xsl:variable name="ref" select="concat(//w[@id=$wid]/ancestor::chapter/@num,'.',//w[@id=$wid]/ancestor::verse/@num)"/>
				
			<xsl:choose>
				<xsl:when test="string-length($refid)=0 or $ref = $refid">
					<xsl:for-each select="preceding-sibling::cl:clause[1]">
						<xsl:call-template name="calculateVID">
							<xsl:with-param name="refid" select="$ref"/>
							<xsl:with-param name="cnt" select="number($cnt)+1"/>
						</xsl:call-template>
					</xsl:for-each>
					<xsl:if test="not(preceding-sibling::cl:clause[1])">
				 
						<xsl:value-of select="concat($ref,translate($cnt +1,$num,$char))"/>
					</xsl:if>
				</xsl:when>
 
				<xsl:otherwise>
					 
					<xsl:value-of select="concat($refid,translate($cnt,$num,$char))"/>
				</xsl:otherwise>
			</xsl:choose>	
			
		</xsl:template>
	
	
	
<!--
========================
WORD GROUP TEMPLATES
=========================
(should be from an include! - nasty ugly code!)
-->	
	


  <xsl:template match="wg:group">
<span id="{@id}">
	<xsl:if test="$mode='edit'"><xsl:attribute name="onclick">select(this)</xsl:attribute></xsl:if>
<table class="group">

<xsl:apply-templates/>
</table>	

    </span>
  </xsl:template>

  <xsl:template match="wg:head">
    <tbody>
      <tr>
        <td class="group-label"><xsl:value-of select="concat('wg', substring-after(parent::wg:group/@id,'_'))"/></td>
        <td><xsl:apply-templates/></td>
      </tr>
    </tbody>
  </xsl:template>

  <xsl:template match="wg:word">
    <xsl:variable name="id" select="@id"/>
    <xsl:choose>
    <xsl:when test="wg:modifiers">
      <table class="word">
        <tbody>
          <tr>
            <td>
              <xsl:attribute name="colspan">
                <xsl:value-of select="count(wg:modifiers/*)"/>
              </xsl:attribute>
              <xsl:if test="$showIDs=1">
              <span class="wid"><xsl:value-of select="substring-after(@xlink:href,'.')"/></span></xsl:if>
              <span class="grk"> <xsl:value-of select="//w[@id=current()/@xlink:href]/wf"/></span>
            </td>
          </tr>
          <tr>
            <xsl:call-template name="modifier-heading">
              <xsl:with-param name="modifiers" select="wg:modifiers"/>
            </xsl:call-template>
          </tr>
          <tr>
            <xsl:apply-templates/>
          </tr>
        </tbody>
      </table>
    </xsl:when>      
    <xsl:otherwise>
      <span class="word">
      <xsl:if test="$showIDs=1">
      <span class="wid"><xsl:value-of select="substring-after(@xlink:href,'.')"/></span>
      </xsl:if>
      <span class="grk">
		  <xsl:value-of select="//w[@id=current()/@xlink:href]/wf"/>
      </span>
</span>
    </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <xsl:template match="wg:specifier|wg:definer|wg:qualifier|wg:relator|wg:connector">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template name="modifier-heading">
    <xsl:param name="modifiers"/>
    
     
    <xsl:for-each select="$modifiers/*">
      <xsl:variable name="local" select="local-name()"/>
      
   		 <td class="modHead">
   		 	<xsl:choose>
   		 		<xsl:when test="$local = 'specifier'">sp</xsl:when>
     		 		<xsl:when test="$local = 'qualifier'">ql</xsl:when>
       		 	<xsl:when test="$local = 'relator'">rl</xsl:when>
            		 	<xsl:when test="$local = 'definer'">df</xsl:when>
                 		<xsl:when test="$local = 'connector'">cn</xsl:when>
   		 	</xsl:choose>
   		 </td>  
    </xsl:for-each>
    
    <!-- <xsl:value-of select="$modifier-names//modifier[@name=$local]/@abbrev"/> -->
    
  </xsl:template>

	<xsl:template match="cl:clause[ancestor::wordgroups]">
<xsl:variable select="@id | @xlink:href" name="id"/>
		<table class="emclause">
		
			<tbody>
				<tr>
					<th class="clid2"><xsl:value-of select="$id"/></th>
				</tr>
				<tr>
					<th><xsl:apply-templates select="wg:group"/></th>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	

<!-- ignore gloss element --> 
<xsl:template match="gloss"/>
	
</xsl:stylesheet>

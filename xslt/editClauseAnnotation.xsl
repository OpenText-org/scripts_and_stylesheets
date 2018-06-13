<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:ot="http://www.opentext.org/ns/ot"
>

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	
	<xsl:param name="book"/>
	<xsl:param name="include"/>
	<xsl:param name="mode"/>
	<xsl:param name="showFV">0</xsl:param>
	<xsl:param name="uid">null</xsl:param>
	<xsl:param name="jsSuffix"/>
	
	<ot:values>

<!--
independent	

dependent		
			purpose
			result
			causal
			content
			locative
			temporal
			comparative
			conditional - protasis

relative
			definite
			indefinite
participle
			substantival
			attributive
			predicative
			genitive absolute
			adverbial - concessive
			adverbial - causal
			adverbial - conditional
			adverbial - instrumental
			adverbial - purpose
infinitive
			substantival
			appositional
			purpose/result
			causal
			temporal
-->

		<component name="clause">
		<!--
		<select name="type">
				<option>-</option>
				<option value="independent">independent</option>
				<option value="dependent">dependent</option>
				<option value="relative">relative</option>
				<option value="participle">participle</option>
				<option value="infinitive">infinitive</option>
			</select>
-->
			<select name="subtype" onclick="bubbleCancel()">
				<option>---</option>
				<optgroup label="INDEPENDENT">
					 
				</optgroup>	
				<optgroup label="DEPENDENT">
					<option value="dep_purpose">purpose</option>
					<option value="dep_causal">causal</option>
					<option value="dep_content">content</option>
					<option value="dep_locative">locative</option>
					<option value="dep_temporal">temporal</option>
					<option value="dep_comparative">comparative</option>
					<option value="dep_conditional-protasis">conditional - protasis</option>
				</optgroup>	
				<optgroup label="RELATIVE">
					<option value="rel_definite">definite</option>
					<option value="rel_indefinite">indefinite</option>
				</optgroup>					
				<optgroup label="PARTICIPLE">
					<option value="par_substantival">substantival</option>
					<option value="par_attributive">attributive</option>
					<option value="par_predicative">predicative</option>
					<option value="par_genitive absolute">genitive absolute</option>
					<option value="par_adverbial-concessive">adverbial - concessive</option>
					<option value="par_adverbial-causal">adverbial - causal</option>
					<option value="par_adverbial-conditional">adverbial - conditional</option>
					<option value="par_adverbial-instrumental">adverbial - instrumental</option>
					<option value="par_adverbial-purpose">adverbial - purpose</option>
				</optgroup>
				<optgroup label="INFINITIVE">
					<option value="inf_substantival">substantival</option>
					<option value="inf_appositional">appositional</option>
					<option value="inf_substantival">substantival</option>
					<option value="inf_purpose/result">purpose/result</option>
					<option value="inf_causal">causal</option>
					<option value="inf_temporal">temporal</option>
				</optgroup>	
			</select>
		</component>
	
	
		<component name="S">
			<select name="part">
				<option>---</option>
				<option value="actor">actor</option>
				<option value="behaver">behaver</option>
				<option value="senser">senser</option>
				<option value="sayer">sayer</option>
				<option value="carrier">carrier</option>
				<option value="identified">indentified</option>
				<option value="existent">existent</option>
				<option value="goal">goal (passive clause)</option>
			</select>
		</component>
	
		<component name="P">
			<select name="process">
				<option>---</option>
				<option value="material">material</option>
				<option value="behavioural">behavioural</option>
				<option value="mental">mental</option>
				<option value="verbal">verbal</option>
				<option value="relational">relational</option>				
				<option value="existential">existential</option>
			</select>
		</component>

		<component name="C">
			<select name="part">
				<option>---</option>
				<option value="goal">goal</option>
				<option value="verbiage">verbiage</option>
				<option value="receiver">receiver</option>
				<option value="recipient">recipient</option>
				<option value="target">target</option>
				<option value="attribute">attribute</option>
				<option value="identifier">identifier</option>
				<option value="phenomenon">phenomenon</option>
				<option value="scope">scope</option>
			</select>
		</component>
	
		
		<component name="A">
			<select name="circum">
				<option>---</option>
				<option value="extent">extent (how far? how long?)</option>
				<option value="location">location (where? when?)</option>
				<option value="manner">manner (how?)</option>
				<option value="cause">cause (why? what/who for?)</option>
				<option value="contingency">contingency (why?)</option>
				<option value="accompaniment">accompaniment (who/what with?)</option>
				<option value="role">role (what as/into?)</option>
				<option value="matter">matter (what about?)</option>
				<option value="angle">angle</option>
				
				<option value="actor">actor (passive clause)</option>
			</select>
		</component>
	
<!--
ELABORATION
            apposition
            clarifcation
    EXTENSION
            addition
            variation
    ENHANCEMENT
            spatio-temporal
            manner
            causal-conditional
            matter
	PROJECTION
			idea
			locution
-->	
	
		<component name="conj">
			<select name="conj">
				<option>---</option>
				<optgroup label="ELABORATION">
					<option value="apposition">apposition</option>
					<option value="clarification">clarification</option>
				</optgroup>	
				<optgroup label="EXTENSION">
					<option value="addition">addition</option>
					<option value="variation">variation</option>
				</optgroup>	
				<optgroup label="ENHANCEMENT">
					<option value="spatio-temporal">spatio-temporal</option>
					<option value="manner">manner</option>
					<option value="causal-conditional">causal-conditional</option>
					<option value="matter">matter</option>
				</optgroup>
				<optgroup label="PROJECTION">
					<option value="idea">idea</option>
					<option value="locution">locution</option>
				</optgroup>	
			</select>
		</component>		
	
	</ot:values>
	
	<xsl:template match="/">
	
		<html>
			<head>
				<title>Clause annotation editor</title>
				<link rel="stylesheet" type="text/css" href="/opentext/clause.css"/>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
				<script src="/opentext/clauseAnnotateEdit{$jsSuffix}.js">
					&#160;
				</script>
				
				<script>
				
				<xsl:choose>
					 <xsl:when test="string-length($book)&gt;0">
						 var filename = '<xsl:value-of select="$book"/>' + '-cl-ch' + <xsl:value-of select="//chapter/@num"/>;
						<xsl:choose>
							<xsl:when test="$uid='null'">
								var col = '/<xsl:value-of select="$book"/>/clause';
							</xsl:when>
							<xsl:otherwise>
								var col = '/user/<xsl:value-of select="$uid"/>/clause';							
							</xsl:otherwise>
						</xsl:choose>
						 
					 </xsl:when>
					<xsl:when test="//chapter/@col">
						var filename = '<xsl:value-of select="//chapter/@filename"/>';
						var col = '<xsl:value-of select="//chapter/@col"/>';
					</xsl:when>
					<xsl:otherwise>
						var filename = 'mark-cl-ch' + <xsl:value-of select="//chapter/@num"/>;
						var col = '/mark/clause';
					</xsl:otherwise>	
				</xsl:choose>
				
				var mode = '<xsl:value-of select="$mode"/>';	
				var chnum = '<xsl:value-of select="//chapter/@num"/>';
				var bookid = '<xsl:value-of select="//chapter/@book"/>';
				
				<xsl:for-each select="document('')//component">
				
					<xsl:text>function atts</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>()</xsl:text>
					{
						var sel = document.createElement('select');
						sel.name='<xsl:value-of select="select/@name"/>';
						<xsl:for-each select="select/option">
						<xsl:variable name="opt" select="concat('opt',position())"/>
						var <xsl:value-of select="$opt"/>=document.createElement('option');
						<xsl:value-of select="$opt"/>.value='<xsl:value-of select="@value"/>';
						var txt = document.createTextNode('<xsl:value-of select="."/>');
						<xsl:value-of select="$opt"/>.appendChild(txt);
						sel.appendChild(<xsl:value-of select="$opt"/>);
						</xsl:for-each>
						return sel;
					}
				</xsl:for-each>
				
				
				
				</script>
				<style type="text/css">
.gap-comp { background-color: #fff; border: 0; }				
				</style>
				
			</head>
			<body>
			
			     <span id="menu">
         <div class="button" style="font-weight: bold; text-align: center">Actions</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="addNewClause(cnum++)" onmouseout="this.style.background='#c0c0c0'">Add Clause</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="output(DOMOutput())" onmouseout="this.style.background='#c0c0c0'">Output</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="postXML()" onmouseout="this.style.background='#c0c0c0'">Submit</div>
      </span>

	  <span id="menu2">
		  <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="unembed('after')" onmouseout="this.style.background='#c0c0c0'">Unembed +</div>
		  <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="unembed('before')" onmouseout="this.style.background='#c0c0c0'">Unembed -</div>
		  <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="moveClause('up')" onmouseout="this.style.background='#c0c0c0'">Move up</div>
		  <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="moveClause('down')" onmouseout="this.style.background='#c0c0c0'">Move down</div>
	  </span>
      
      <div id="words">
	 
			<xsl:apply-templates select="//data/words"/>
		 
	</div>
	
	<div id="clauses">			
			<xsl:apply-templates select="//chapter/cl:clause"/>
	</div>		
			</body>
		</html>
	
	</xsl:template>
	
	<xsl:template match="cl:clause" >
		<table id="{@id}" onclick="select(this)" class="clause-{@level}" border="1">
	
			<tbody>
				<tr>
					<td class="ccell" >
					<span>
					<span><xsl:value-of select="@id"/></span>
					<span class="controlImages" id="{concat('con',@id)}">
					<img src="/opentext/img/S.gif" alt="Add S component" comp="S" onclick="addComponent(this)">
						<xsl:if test="cl:S"><xsl:attribute name="width">0</xsl:attribute></xsl:if>
					</img>
					
					<img src="/opentext/img/P.gif" alt="Add P component" comp="P"  onclick="addComponent(this)">
					<xsl:if test="cl:P"><xsl:attribute name="width">0</xsl:attribute></xsl:if>
					</img>
					<img src="/opentext/img/C.gif" alt="Add C component" comp="C" onclick="addComponent(this)"/>
					<img src="/opentext/img/A.gif" alt="Add A component" comp="A" onclick="addComponent(this)"/>
					<img src="/opentext/img/conj.gif" alt="Add conjunction component" comp="conj" onclick="addComponent(this)"/>
					<span class="compButton" onclick="javascript:addComponent(this)" comp="gap">gap</span>
					<span class="compButton" onclick="javascript:addComponent(this)" comp="add">a</span>
					<img src="/opentext/img/x.gif" alt="Remove clause and empty content" cl="{@id}" onclick="removeClause(this)"/>
					</span>
				 
					<form >
					
						<select onclick="event.cancelBubble = true;" onchange="changeLevel(this)"	>
							<xsl:choose>
								<xsl:when test="ancestor::cl:clause and not(parent::cl:gap)"><option value="embedded">Embedded</option></xsl:when>
							
								
								<xsl:otherwise>
 									<option value="primary"><xsl:if test="@level='primary'"><xsl:attribute name="selected">1</xsl:attribute></xsl:if>Primary</option>
									<option value="secondary"><xsl:if test="@level='secondary'"><xsl:attribute name="selected">1</xsl:attribute></xsl:if>Secondary</option>
									<option value="secondary2"><xsl:if test="@level='secondary2'"><xsl:attribute name="selected">1</xsl:attribute></xsl:if>Secondary (dep)</option>	
								</xsl:otherwise>
							</xsl:choose>
							
							
						</select>
						<xsl:if test="not(ancestor::cl:clause) or parent::cl:gap">
							<!-- connect value input -->
							<input type="text" size="8" name="connect" class="connectInput" onclick="event.cancelBubble=true">
								<xsl:attribute name="value">	
									<xsl:choose>
										<xsl:when test="string-length(@connect)&gt;0"><xsl:value-of select="@connect"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="preceding-sibling::cl:clause[1]/@id"/></xsl:otherwise>	
									</xsl:choose>
								</xsl:attribute>
							</input>
							
							<!-- projected clause checkbox  -->
							<span class="projectedInput">
							proj<input type="checkbox" name="projected" onclick="setProjected(this)">
								<xsl:if test="@projected='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							 
							</input>
							</span> 
						</xsl:if>
					</form>
				 
					<xsl:if test="$include='clause'">
					<div>
					<xsl:copy-of select="document('')//component[@name='clause']/select"/>
					</div>
					
					</xsl:if>
					</span>
					<span class="glossControl" onclick="showGloss(this)">GLOSS <span>+</span></span>
					</td>
					
					<xsl:apply-templates/>
				</tr>

	
				<tr>
					<td class="gloss" colspan="10" style="display: none" onclick="event.cancelBubble=true;"><input value="{gloss}" type="text" size="100" /></td>
				</tr>		</tbody>
		</table>
	</xsl:template>
	
	<xsl:template match="cl:A | cl:S | cl:P | cl:C | pl:conj | cl:conj | cl:gap | cl:add">
	
		<xsl:choose>
			<xsl:when test="parent::*[self::cl:A or self::cl:P or self::cl:S or self::cl:C]">
				<table border="1" style="display:inline; ">
				
					<tbody>
						<tr>
		<td   comp="{local-name()}" onclick="insert(this)" cl="{ancestor::cl:clause[1]/@id}">
			
			<table>
				<tbody>
					<tr>
						<th class="compHeader">
						
							<xsl:choose>
								<xsl:when test="self::cl:A or self::cl:C or self::cl:S">
									 <span onclick="changeComp(this)"><xsl:value-of select="local-name()"/></span> 
								</xsl:when>
								<xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
							</xsl:choose>						
						
							<xsl:choose>
							<xsl:when test="$mode='process' and (@part or @process or @circum or @conj)">
								<xsl:apply-templates  select="document('')//component[@name=local-name(current())]/select" mode="select">
									<xsl:with-param name="value" select="@part | @process | @circum | @conj"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:when test="$mode='process'"	>
								<xsl:copy-of select="document('')//component[@name=local-name(current())]/select"/>
							</xsl:when>
						</xsl:choose>						
						<img src="/opentext/img/x.gif" alt="Remove component" onclick="removeComponent(this)" class="removeComponent" cl="{parent::cl:clause/@id}" comp="{local-name()}"/>
						
						<xsl:if test="self::cl:P and not(cl:v and cl:f) and $showFV=1"><span class="addFV" onclick="addFinite(this)">add FV</span></xsl:if>
						</th>
					</tr>
					<tr>
						<td><xsl:apply-templates/></td>
					</tr>
				</tbody>
			</table>
		</td>
							 
						</tr>
					</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
			
		<td comp="{local-name()}" onclick="insert(this)" cl="{ancestor::cl:clause[1]/@id}">
		<xsl:if test="self::cl:gap"><xsl:attribute name="class">gap-comp</xsl:attribute></xsl:if>
			<table>
				<tbody>
					<tr>
						<th  class="compHeader">
							<xsl:choose>
								<xsl:when test="self::cl:A or self::cl:C or self::cl:S">
									 <span onclick="changeComp(this)"><xsl:value-of select="local-name()"/></span>
								</xsl:when>
								<xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
							</xsl:choose>
						
						
						<xsl:choose>
							<xsl:when test="$mode='process' and (@part or @process or @circum or @conj)">
								<xsl:apply-templates  select="document('')//component[@name=local-name(current())]/select" mode="select">
									<xsl:with-param name="value" select="@part | @process | @circum | @conj"/>
								</xsl:apply-templates>

							</xsl:when>
							<xsl:when test="$mode='process'">
								<xsl:copy-of select="document('')//component[@name=local-name(current())]/select"/>
							</xsl:when>
						</xsl:choose>
						
						
						<img src="/opentext/img/x.gif" alt="Remove component" onclick="removeComponent(this)" class="removeComponent" cl="{parent::cl:clause/@id}" comp="{local-name()}"/>
						
						<xsl:if test="self::cl:P and not(cl:v and cl:f) and $showFV=1"><span class="addFV" onclick="addFinite(this)">add FV</span></xsl:if>
						</th>
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
	
	<xsl:template match="cl:v | cl:f">
 
				 
				<table comp="{local-name()}" onclick="insert(this)" style="display:inline; border: 1px solid black">
			<tbody>
				<tr>
					<th><xsl:value-of select="local-name()"/>
<img src="/opentext/img/x.gif" alt="Remove component" onclick="removeComponent(this)" class="removeComponent" cl="{parent::cl:clause/@id}" comp="{local-name()}"/>					
					</th>
				</tr>
				<tr>
					<td><xsl:apply-templates/>	</td>
				</tr>
			</tbody>
		</table>
				 
		 
		
	
	</xsl:template>
	
	<xsl:template match="gloss"/>
	
	<xsl:template match="w">
		<span class="grk" id="{@id}" onclick="select(this)">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="ancestor::words">grk2</xsl:when>
					<xsl:otherwise>grk</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
		 	<xsl:value-of select="wf"/>
			<xsl:if test="ancestor::words"><xsl:text>&#x20;</xsl:text> </xsl:if>
		 	
		 </span>
	</xsl:template>
	
	<xsl:template match="select | optgroup" mode="select">
		<xsl:param name="value"/>
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="select">
				<xsl:with-param name="value" select="$value"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="option" mode="select">
		<xsl:param name="value"/>
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="$value=@value"><xsl:attribute name="selected">1</xsl:attribute></xsl:if>
			<xsl:apply-templates/>		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:ot="http://www.opentext.org/ns/ot"
>

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	
	<xsl:param name="book"/>
	<xsl:param name="include"/>
	
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
				<option value="target">target</option>
				<option value="attribute">attribute</option>
				<option value="phenomenon">phenomenon</option>
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
				<link rel="stylesheet" type="text/css" href="clause.css"/>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
				<script src="clauseAnnotateEdit.js">
					&#160;
				</script>
				
				<script>
				
				<xsl:choose>
					 <xsl:when test="string-length($book)&gt;0">
						 var filename = <xsl:value-of select="$book"/> + '-cl-ch' + <xsl:value-of select="//chapter/@num"/>;
						 var col = '/<xsl:value-of select="$book"/>/clause';
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
				
				var chnum = <xsl:value-of select="//chapter/@num"/>;
				
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
				
				
			</head>
			<body>
			
			     <span id="menu">
         <div class="button" style="font-weight: bold; text-align: center">Actions</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="addNewClause(cnum++)" onmouseout="this.style.background='#c0c0c0'">Add Clause</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="output(DOMOutput())" onmouseout="this.style.background='#c0c0c0'">Output</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="postXML()" onmouseout="this.style.background='#c0c0c0'">Submit</div>
      </span>
      <div id="words">
		<span></span>
	</div>
	
	<div id="clauses">			
			<xsl:apply-templates select="//chapter/cl:clause"/>
	</div>		
			</body>
		</html>
	
	</xsl:template>
	
	<xsl:template match="cl:clause" >
		<table id="{@id}" onclick="select(this)" class="clause" border="1">
			<xsl:if test="ancestor::cl:clause"><xsl:attribute name="style">background-color: #e0e0e0</xsl:attribute></xsl:if>
			<tbody>
				<tr>
					<td class="ccell"><span><xsl:value-of select="@id"/></span>
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
					<img src="/opentext/img/x.gif" alt="Remove clause and empty content" cl="{@id}" onclick="removeClause(this)"/>
					</span>
					<form >
						<select onclick="event.cancelBubble = true;">
							<xsl:choose>
								<xsl:when test="ancestor::cl:clause"><option value="embedded">Embedded</option></xsl:when>
								<xsl:otherwise><option value="primary">Primary</option></xsl:otherwise>
							</xsl:choose>
							
							
						</select>
					</form>
					<xsl:if test="$include='clause'">
					<div>
					<xsl:copy-of select="document('')//component[@name='clause']/select"/>
					</div>
					
					</xsl:if>
					</td>
					
					<xsl:apply-templates/>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	
	<xsl:template match="cl:A | cl:S | cl:P | cl:C | pl:conj | cl:conj">
	
		<xsl:choose>
			<xsl:when test="parent::*[self::cl:A or self::cl:P or self::cl:S or self::cl:C]">
				<table border="1">
					<tbody>
						<tr>
		<td comp="{local-name()}" onclick="insert(this)">
			<table>
				<tbody>
					<tr>
						<th class="compHeader"><xsl:value-of select="local-name()"/>
						
							<xsl:choose>
							<xsl:when test="@part or @process or @circum or @conj">
								<xsl:apply-templates  select="document('')//component[@name=local-name(current())]/select" mode="select">
									<xsl:with-param name="value" select="@part | @process | @circum | @conj"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="document('')//component[@name=local-name(current())]/select"/>
							</xsl:otherwise>
						</xsl:choose>						
						<img src="/opentext/img/x.gif" alt="Remove component" onclick="removeComponent(this)" class="removeComponent" cl="{parent::cl:clause/@id}" comp="{local-name()}"/>
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
			
		<td comp="{local-name()}" onclick="insert(this)">
			<table>
				<tbody>
					<tr>
						<th  class="compHeader"><xsl:value-of select="local-name()"/>
						
						<xsl:choose>
							<xsl:when test="@part or @process or @circum or @conj">
								<xsl:apply-templates  select="document('')//component[@name=local-name(current())]/select" mode="select">
									<xsl:with-param name="value" select="@part | @process | @circum | @conj"/>
								</xsl:apply-templates>

							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="document('')//component[@name=local-name(current())]/select"/>
							</xsl:otherwise>
						</xsl:choose>
						
						
						<img src="/opentext/img/x.gif" alt="Remove component" onclick="removeComponent(this)" class="removeComponent" cl="{parent::cl:clause/@id}" comp="{local-name()}"/>
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
	
	<xsl:template match="w">
		<span class="grk" id="{@id}" onclick="select(this)"><span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
		 	<xsl:value-of select="wf"/>
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

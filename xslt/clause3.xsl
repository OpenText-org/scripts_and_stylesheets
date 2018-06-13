<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xalan="http://xml.apache.org/xalan"
                   exclude-result-prefixes="xalan"
>
 
 	<xsl:output method="xml" encoding="UTF-8" version="1.0"/>
 
	<xsl:param name="book">mark</xsl:param>	
		
	 <xsl:param name="start"/>

	 <xsl:param name="showIDs">0</xsl:param>
	 <xsl:param name="showProcess">0</xsl:param>
	 <xsl:param name="showVerseNums">1</xsl:param>
	 <xsl:param name="header">0</xsl:param>
	<xsl:param name="showGloss">1</xsl:param>
	<xsl:param name="format">basic</xsl:param>
	<xsl:param name="key">0</xsl:param>
 
	<xsl:template match="/">
		<html>
			<head>
				<title>Clause</title>
				<style type="text/css">
					.wid { font-family:Arial; font-size: 9pt; color: green; margin-right: 1pt;}
					
									table { border-collapse: collapse;}
					
					.clause td { padding: 1pt; text-align: left; }
					
					.comptd {  border: 1px solid #909090; padding: 2px; margin: 0px; text-align: left;}
					
					
					.compheading { font-size: 8pt; font-weight: bold; font-family: Arial}
					
					td { vertical-align: top; }
					
					.clauseid { font-family: Arial; font-size: 8pt; color: green }
					
					
					.grk, .clauseGrk { font-family: Cardo, 'Georgia Greek',  'Palatino Linotype',  'Arial Unicode MS'; font-size: 12pt; text-align: left; }
					.clauseGrk { font-size: 9pt;}
					
					
					.clause {  padding: 0pt; border-collapse: collapse;
						margin-bottom: 0; text-align: left;  keep-together: always;  
					}
					
					table { border-collapse: collapse; }
					
					.embedComp2 { display: inline; margin-right: 8pt;}
					
					.projectedClause { background-color: rgb(210,255,210); padding: 10px;}
					
					.clauseDiv { margin-bottom: 5px;  margin-top: 5px;}
					
					.vnum {  font-family: Arial; font-size: 9pt; font-weight: bold; vertical-align: top; width: 30px;}
					
					.connect { color: rgb(64,128,128) }
					
							body { font-family: Verdana, Arial; font-size: 12pt; }
					
					.copyright { margin-top: 6px; border-bottom: 1px gray solid; margin-bottom: 6px; font-size: 8pt; text-align: center;}
					
					.usage { text-align: center; font-size: 10pt; font-weight: bold; background-color: #f0fff0; }
					
					.title { font-size: 11pt; text-align: center; font-weight: bold; margin-bottom: 12pt}
					
					.key { font-size: 9pt; margin-top: 6pt; margin-bottom: 12pt; border-collapse: collapse;}
					.key td, .key th { border: 1px #c0c0c0 solid; padding: 1pt;}
					.keylink { font-size: 9pt; }
					.kname { font-style: italic; }
					
					.gloss { font-size: 8pt; color: #505050; font-style: italic}
					
					.popupnote { position: absolute; visibility: hidden;
	background-color: #ffffff; width: 200px; height; 200px; overflow: auto;
	border: 2px outset #505050; padding: 2px;
	font-family: Tahoma, Verdana, Arial; font-size: 9pt;
}


	.popupnote .head { background-color: #707070; color: #ffffff; }
	.popupnote .grk { font-weight: bold; }
	.popupnote .wid { color: #ffffff; padding-right: 6pt; padding-left: 2pt; }
	.popupnote .label { text-decoration: underline; }
	.popupnote .domOcc { margin-left: 6pt; }
	.popupnote .lex .grk { font-size: 10pt; font-weight: normal; }
	
	.line { border-top: 4px #ff7777 solid; padding-left: 20px; width: 100%;}
	.oe1 { background-color: #ddddff; }
	.lineRef { vertical-align: top; font-size: 10pt; width: 70px; text-align: left;}
	.ref { font-size: 8pt; font-weight: normal; padding-top: 20px; }
	
				</style>
				<xsl:if test="$format='combined'">
					<script src="clauseDisplay.js">
					
					</script>
				</xsl:if>
			</head>
			<body>
			
				<!-- include header -->
				<xsl:if test="not($header=0)">
	<div class="title">OpenText.org Clause Annotation of <xsl:value-of select="$header"/><xsl:text> </xsl:text><xsl:value-of select="//chapter/@num"/></div>
	<xsl:if test="not($key=0)">
	<div><a class="keylink" href="clauseKey.jpeg" target="_key">Show full key for clause annotation diagram</a>
	<table class="key">
		<thead>
			<tr>
				<th>slot</th>
				<th>name</th>
				<th>function in clause</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>cj</th><td class="kname">conjunction</td><td>forms conjection to other clause(s)</td>
			</tr>
			<tr>
				<th>S</th><td class="kname">subject</td> <td>actor of process</td>
			</tr>
			<tr>
				<th>P</th><td class="kname">predicator</td><td>contains process/action (verbal element) of clause</td>
			</tr>
			<tr>
				<th>C</th><td class="kname">complement</td><td>participant that completes process, often receipt/object of action</td>
			</tr>
			<tr>
				 
				<th>A</th><td class="kname">adjunct</td><td>circumstances associated with process</td>
			</tr>
		</tbody>
	</table>
	</div>
 			</xsl:if>
				</xsl:if>
				<xsl:apply-templates/>	
				<xsl:if test="not($header=0)">
				<div>
	<div class="usage">*** For NON-COMMERICAL, personal and academic use only ***</div>
	<div class="copyright">Clause annotation of <xsl:value-of select="$header"/> (Draft ver. 0.1) - Copyright (c) OpenText.org 2005</div>
</div>
				</xsl:if>
			</body>
		</html>
	</xsl:template>	 
	
		<xsl:template match="cl:clause">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="vs" select=".//w[1]/@vs"/>
	<div >
		<xsl:attribute name="class">
		<xsl:choose>
			<xsl:when test="parent::chapter and @projected='yes'">projectedClause</xsl:when>
			<xsl:otherwise>clauseDiv</xsl:otherwise>	
		</xsl:choose>
		</xsl:attribute>

		<!-- anchor for linking -->
		<a name="{@id}" id="{@id}"/>
		
		<!-- verse number -->
		<xsl:if test="parent::chapter and $showVerseNums=1 and not(preceding::cl:clause//w[1]/@vs = $vs)">
		<div class="vnum">
			 
				<xsl:text>v</xsl:text><xsl:value-of select="$vs"/><xsl:text>.</xsl:text>
		 
		</div>
		</xsl:if>
		
		<table class="clause">
		<xsl:if test="@level='secondary' or @level='secondary2'">
			<xsl:attribute name="style">
				<xsl:call-template name="indentLevel"/>
			</xsl:attribute>
		</xsl:if>
		<tbody>
			<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="@level='primary'">background-color: rgb(255,210,230)</xsl:when>
					<xsl:when test="@level='embedded'">background-color: #f0f0f0;</xsl:when>
					<xsl:otherwise>background-color: #f0f0f0; </xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			 
			<tr>
				<td >
					<table class="comptd">
					
						<tr>
							<th class="clauseid">
								<xsl:value-of select="@id"/>
								<xsl:if test="string-length(@connect)&gt;0">
								<div class="connect">
									
									<xsl:choose>
										<xsl:when test="preceding::cl:clause[@id = current()/@connect]">&#8598;</xsl:when>
										<xsl:otherwise>&#8601;</xsl:otherwise>
									</xsl:choose>
								
									<xsl:value-of select="substring-after(@connect,'.')"/>
								</div>
								</xsl:if>
							</th>
							<xsl:apply-templates select="*[not(self::gloss)]"/>
						</tr>
					</table>
				</td>
			</tr>

</tbody>
<xsl:if test="$showGloss=1 and @level != 'embedded'">
<tfoot>
	<tr>
		<td class="gloss" colspan="count(*)"><xsl:apply-templates select="gloss"/></td>
	</tr>
</tfoot>
 </xsl:if>
		</table>
		</div>
	</xsl:template>
	<xsl:template match="cl:S|cl:P|cl:A|cl:C|pl:conj | cl:gap | cl:voc | cl:add | cl:F">
	
		<xsl:variable name="name">
			<xsl:choose>
				<xsl:when test="local-name()='conj'">cj</xsl:when>
				<xsl:when test="local-name()='gap'">&#160;</xsl:when>
				<xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table class="embedComp"><tbody>
					<tr>
					
					<td class="comptd">
						<table ><tbody>
							
					
							<tr>
								<th class="compheading">
									 
										<xsl:value-of select="$name"/>
										<xsl:if test="$showProcess=1 and (@process or @circum or @part)">
											<xsl:text> (</xsl:text><xsl:value-of select="@process | @circum | @part"/><xsl:text>)</xsl:text>
										</xsl:if>
									 
								</th>
							</tr>
							<tr>
								<td class="grk">
									<xsl:apply-templates select="text()|*[not(@connect)]"/>
								</td>
							</tr>	</tbody>
						</table>
					</td>	
					</tr>
				</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td class="comptd">
					<table >
						<tr>
							<th class="compheading">
								 
									<xsl:value-of select="$name"/>
																			<xsl:if test="$showProcess=1 and (@process or @circum or @part)">
											<xsl:text> (</xsl:text><xsl:value-of select="@process | @circum | @part"/><xsl:text>)</xsl:text>
										</xsl:if>
								 
							</th>
						</tr>
						<tr>
							<td class="grk">
								<xsl:apply-templates select="text()|*[not(@connect)]"/>
							</td>
						</tr>
					</table>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	


<xsl:template match="w">
<span>
	<xsl:if test="@kw='true'"><xsl:attribute name="style">font-weight: bold</xsl:attribute></xsl:if>
	<xsl:if test="$format='combined'">
		<xsl:attribute name="onmouseout">showPopupNote('hide', 'n-<xsl:value-of select="@id"/>'); showWordGroup('hide','<xsl:value-of select="@wg"/>','<xsl:value-of select="@wgcnt"/>','<xsl:value-of select="ancestor::cl:clause[1]/@level"/>')</xsl:attribute>
		<xsl:attribute name="onmouseover">showPopupNote('show', 'n-<xsl:value-of select="@id"/>'); showWordGroup('show','<xsl:value-of select="@wg"/>','<xsl:value-of select="@wgcnt"/>','<xsl:value-of select="ancestor::cl:clause[1]/@level"/>')</xsl:attribute>
		<xsl:attribute name="id"><xsl:value-of select="concat(@wg,'_',count(preceding::w[@wg=current()/@wg]))"/></xsl:attribute>
		<xsl:attribute name="role"><xsl:value-of select="@role"/></xsl:attribute>
	</xsl:if>
 

    <xsl:if test="$showIDs=1">
        <span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
    </xsl:if>
 
 
    <xsl:value-of select="wf"/>&#160;
 </span>
 <xsl:if test="$format='combined'">
 <div class="popupnote" id="{concat('n-',@id)}">
	 <div class="head"><span class="wid"><xsl:value-of select="@id"/></span> <span class="grk"><xsl:value-of select="wf"/></span></div>
	  <div class="pos">POS: <xsl:value-of select="local-name(*[1])"/>
		 <xsl:for-each select="*[1]/@*">-<xsl:value-of select="."/></xsl:for-each>
	</div>
	<div class="lex">Lex: <xsl:value-of select="wf/@betaLex"/></div>
	<div class="doms">
		<div class="label">Domains</div>
 <xsl:for-each select="sem/*">
		<div class="domOcc"> <xsl:value-of select="concat(@majorNum,':',//domains/domain[@num=current()/@majorNum])"/></div>
		  
	 </xsl:for-each>		
		
	</div>
	
	
 </div>
 </xsl:if>
</xsl:template>

<!-- LINE for KWIC listing -->
<xsl:template match="line">
	<xsl:variable name="offset">
		<xsl:choose>
			<xsl:when test="$start != 'NULL'"><xsl:value-of select="$start"/></xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="lineNum" select="count(preceding-sibling::line)  + $offset"/>
	<xsl:variable name="oddEven" select="$lineNum mod 2"/>
	<table class="line oe{$oddEven}">
		<tbody>
			<tr>
				<th class="lineRef"><xsl:value-of select="concat('(',$lineNum,')')"/>
					<div class="ref"><xsl:value-of select="@ref"/></div>
				</th>
				<td><xsl:apply-templates/></td>
			</tr>
		</tbody>
	</table>
</xsl:template>


<xsl:template match="domains"/>

<xsl:template name="indentLevel">
	<xsl:param name="cnt">0</xsl:param>
	<xsl:param name="indent">50</xsl:param>
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
							<xsl:otherwise><xsl:value-of select="number($indent+50)"/></xsl:otherwise>	
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

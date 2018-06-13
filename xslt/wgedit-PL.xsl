<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	exclude-result-prefixes="wg xlink xalan"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:wg="http://www.opentext.org/ns/word-group" 
	xmlns:cl="http://www.opentext.org/ns/clause"
	xmlns:xlink="http://www.w3.org/1999/xlink">
	
	
	<xsl:output method="xhtml" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	
	<xsl:param name="book"/>
	
	

	<xsl:param name="chap" select="//chapter/@num"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Word group annotation of <xsl:value-of select="//chapter/@book"/><xsl:text> </xsl:text> <xsl:value-of select="//chapter/@num"/></title>
				      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

				<style type="text/css">
					.word, .wordgroup { display: inline; 
						      background: #000000;
							margin-bottom: 4px;
							vertical-align: top;
							
						}
					
				 .wordgroup
				 	{
							
							border: double 4px #000000;
							
						}	
						
						
					.td { background-color: #FFFFFF;
					}
					
					.control {
						font-family: Arial;
						font-size: 14px;
						color: green;
						text-align: right;
					}
					
					.ccontrol {
						font-family: Arial;
						font-size: 14px;
						color: #ffffff;
						margin-left: 20px;
					}

					.grk { text-align: center;
							font-family: Georgia Greek, Palatino Linotype;
						} 

					.modifier { 	 background-color: #c0c0c0;
         vertical-align: top;
         font-family: Arial; font-size: 10px;
         color: blue;
         }

	.cn { border-right: solid black 2px; }

	.modifier-cn { 	 
         vertical-align: top;
         font-family: Arial; font-size: 10px;
         color: white; background-color: black;
         border-right: solid black 2px;
         }

#menu	{
		font-family: Verdana; font-size: 12px;
		left: 85%; 
		width: 95px; 
		border-top-style: outset; 
		border-right-style: outset; 
		border-left-style: outset; 
		position: absolute; 
		top: 10px; 
		background-color: #e0e0e0; 
		border-bottom-style: outset; 
		4px: 10px;
	}

#words { position: absolute;
         top: 10px;
	 left: 10px;
	 overflow: auto;
	 width: 82%;
	 height: 98%;
	 }
	 
	.wid { color: red; font-family: Arial;
		vertical-align: normal; font-size: 10px;
		padding-right: 4px; font-weight: bold;
	}
	
	.clause
	{
		margin-bottom: 20px;  border-top: solid 1px #707070;
	}
	
	.emclause
	{
		border: 2px #909090 solid; padding: 4px;
		background-color: #f0fff0;
	}
	
	.clid { color: #000000; background-color: #f0f0ff; padding: 2px; font-family: Arial; font-size: 10pt; font-weight: bold; margin-bottom:8px;}
	
	.clid2 { color: #ffffff; background-color: #000000; font-family: Arial; font-size: 9pt; }
	
				</style>


	<script>

  var col='/<xsl:value-of select="$book"/>/wordgroup';
 var book='<xsl:value-of select="$book"/>';
 var ch='';
   var filename='<xsl:value-of select="$book"/>-wg.xml';

	var bkprefix = '<xsl:value-of select="substring-before(//wg:word[1]/@id,'.')"/>';

	function viewClause(cid)
	{
		var url = "/opentext/papyrus/showClause/<xsl:value-of select="$book"/>?showIDs=1#"+cid;
		
		
	    clauseWin = window.open(url, '_clause','width=600,height=500,toolbar=no, location=no,status=yes,menubar=no,scrollbars=yes,  resizable=yes');

		clauseWin.focus();
	}

	</script>

      <script src="wordgroupEdit-PL.js" type="text/javascript">&#160;   </script>
   
			</head>
			<body>
			
			
		<span id="menu">
         <div class="button" style="font-weight: bold; text-align: center">Actions</div>
     <!--    <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="setId()" onmouseout="this.style.background='#c0c0c0'">Renumber</div> -->
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="Output()" onmouseout="this.style.background='#c0c0c0'">Output</div>
         <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="postXML()" onmouseout="this.style.background='#c0c0c0'">Submit</div>
     <div class="button" onmouseover="this.style.background='#9f9f9f'" onclick="unembed()" onmouseout="this.style.background='#c0c0c0'">Unembed</div>
 		 		

   </span>
      <div id="words">



<div>

</div>
			
				<xsl:apply-templates/>
			</div>
			
				</body>
		</html>
	</xsl:template>

	<xsl:template match="cl:clause[@level!='embedded']">
		<div class="clause">
			<div class="clid"><a href="javascript:viewClause('{@id}')"><xsl:value-of select="@id"/></a></div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="cl:clause[ancestor::wg:group]">
		<xsl:variable select="@id | @xlink:href" name="id"/>
		<table class="emclause" id="{$id}">
			<tbody>
				<tr>
					<th class="clid2" onclick="select(this.parentNode.nextSibling.firstChild.fristChild.firstChild.firstChild.firstChild)"><xsl:value-of select="$id"/> 
<span class="ccontrol" onclick="clauseModifierExpand(this)">+</span>					
					</th>
					 
				</tr>
			 
				<tr>
					<td class="td">
						<table>
							<tbody>
								<tr>
									<td onclick="select(this)"><xsl:apply-templates select="wg:group"/></td>
								</tr>
							</tbody>
						</table>
					</td>
					
				</tr>
				
				<!-- modifier slots -->
				<tr><td id="modifiers">
					<xsl:choose>
							<xsl:when test="wg:modifiers"><xsl:apply-templates select="wg:modifiers"/></xsl:when>
							<xsl:otherwise><xsl:call-template name="modifiers">
								<xsl:with-param name="show">no</xsl:with-param>
							</xsl:call-template></xsl:otherwise>
						</xsl:choose>
					 
				</td> 
				</tr>
			</tbody>
		 
			
		</table>
	</xsl:template>
	
	<xsl:template match="wg:word">
	<xsl:choose>
		<xsl:when test="@id">
		
		
		<table id="{@id}" class="word">
		
			<xsl:choose>
				<xsl:when test="parent::wg:head and count(ancestor::wg:group)&gt;1">
					<xsl:attribute name="style">border: double 4px #000000; display: block</xsl:attribute>
				</xsl:when>
				
			</xsl:choose>
			
		
			<tbody>
				<tr>
					<td class="td">
						<table width="100%">
							<tbody>
								<tr>
									<td onclick="select(this)"><span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span><span class="grk"><xsl:value-of select="@wf"/></span></td>
									<td class="control" onclick="modifierExpand(this)">+</td>
								</tr>
							</tbody>
						</table>
						<xsl:choose>
							<xsl:when test="wg:modifiers"><xsl:apply-templates/></xsl:when>
							<xsl:otherwise><xsl:call-template name="modifiers">
								<xsl:with-param name="show">no</xsl:with-param>
							</xsl:call-template></xsl:otherwise>
						</xsl:choose>
						
					</td>
				</tr>
			</tbody>
		</table>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="wg:modifiers" name="modifiers">
		<xsl:param name="show"/>
		<!-- modifiers -->
		<table width="100%">
			<xsl:if test="$show='no'"><xsl:attribute name="style">display: none</xsl:attribute></xsl:if>
			<tbody>
				<tr>
					<th class="modifier-cn" onclick="insert(this)">cn</th>
					<th class="modifier" onclick="insert(this)">sp</th>
					<th class="modifier" onclick="insert(this)">df</th>
					<th class="modifier" onclick="insert(this)">ql</th>
					<th class="modifier" onclick="insert(this)">rl</th>
					
				</tr>
				<tr>
				<td class="cn"><xsl:apply-templates select="wg:connector"/></td>
					<td><xsl:apply-templates select="wg:specifier"/></td>
					<td><xsl:apply-templates select="wg:definer"/></td>
					<td><xsl:apply-templates select="wg:qualifier"/></td>
					<td><xsl:apply-templates select="wg:relator"/></td>
					
				</tr>
			</tbody>
		</table>
	
	</xsl:template>
	
	<xsl:template match="meta"/>
</xsl:stylesheet>



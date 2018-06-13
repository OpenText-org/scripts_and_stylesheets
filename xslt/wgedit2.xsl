<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	exclude-result-prefixes="wg xlink xalan"
	xmlns:xalan="http://xml.apache.org/xalan"
	xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:xlink="http://www.w3.org/1999/xlink">
	
	
	<xsl:output method="xhtml" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	
	<xsl:param name="book"/>

	<xsl:param name="chap" select="//chapter/@num"/>




	
	<xsl:template match="/">
		<html>
			<head>
				<title>Word group annotation of <xsl:value-of select="//meta/book"/><xsl:text> </xsl:text> <xsl:value-of select="//meta/extent"/></title>
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

					.grk { text-align: center;
							font-family: Georgia Greek;
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
				</style>


	<script>
	
	<xsl:choose>
		<xsl:when test="//chapter/@col">
			var filename = '<xsl:value-of select="//chapter/@filename"/>';
			var col = '<xsl:value-of select="//chapter/@col"/>';
			var book = '<xsl:value-of select="//chapter/@book"/>';
			var ch = '';
		</xsl:when>
		<xsl:otherwise>
			var filename = '<xsl:value-of select="concat('mark-wg-ch',//chapter/@num)"/>';
			var ch = <xsl:value-of select="//chapter/@num"/>;
		</xsl:otherwise>
	</xsl:choose>

	</script>

      <script src="wordgroupEdit.js" type="text/javascript">&#160;   </script>
   
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



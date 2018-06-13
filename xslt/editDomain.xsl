<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 

xmlns:ot="http://www.opentext.org/ns/lookup" 
 
 xmlns:xalan="http://xml.apache.org/xalan"
                   exclude-result-prefixes="xalan"
>
 
 	<xsl:output method="xml" encoding="UTF-8" version="1.0"/>
 
	<xsl:param name="book">mark</xsl:param>	
	<xsl:param name="reload"/>
	
 

	 <xsl:variable name="showIDs">1</xsl:variable>
	 
	<ot:lookup>
	
		<system name="polarity">
			<value type="default">positive</value>
			<value>negative</value>
		</system>
		
		<system name="attitude" pos="VBF">
			<value mod="ind">assertive</value>
			<value mod="sub">projective -contin.</value>
			<value mod="opt">projective +contin.</value>
			<value mod="imp">directive</value>
		</system>
		
		<system name="aspect" pos="VBF VBN VBP">
			<value tf="aor">perfective</value>
			<value tf="pre">imperfective</value>
			<value tf="aor">perfective</value>
		</system>
	
	</ot:lookup>
	 

	 <xsl:template match="/">
		 <html>
				<head>
					<title>Domain editing- <xsl:value-of select="$book"/></title>
					      <meta content="-1" http-equiv="Expires"/>	
      <meta content="no-cache" http-equiv="Pragma"	/>
      <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>	
					<style type="text/css">
						select { font-size: 8pt; font-family: Arial; }
					
						.domnum { font-family: Arial; font-size: 9pt; vertical-align: top; color: green }
					
						.compAtt { font-family: Arial; font-size: 8pt; margin-left: 6pt; }
						
						#menu { position: relative; height: 60px; }
						#clauses { position: relative; height: 80%; width: 95%; overflow: auto; background-color: #f0f0f0;}
						
						.grk { font-family: Palatino Linotype; Georgia Greek; Athena; font-size: 11pt;}
						
						.cid { font-size: 9pt; font-family: Arial; }
						
						table { font-size: 11pt; }
						
						.embedcomp { }
					</style>
				</head>
				<body>
				<form method="post">
					<xsl:attribute name="action">
						<xsl:choose>
							<xsl:when test="contains($reload,'synopsis')">/opentext/synopsis/updateDomains</xsl:when>
							<xsl:otherwise>/opentext/updateDomains</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				<input type="hidden" name="chapter" value="{//chapter/@num}"/>
				<input type="hidden" name="book" value="{$book}"/>
				<input name="reload" type="hidden" value="{$reload}?ch={//chapter/@num}"/>
							
				<div id="menu">
					<input type="submit" value="Update domains"/>
				</div>
				<div id="clauses">
					<xsl:apply-templates/>
				</div>
				</form>
				</body>
				<head>
				      <meta content="-1" http-equiv="Expires"/>	
      <meta content="no-cache" http-equiv="Pragma"	/>
				</head>
			</html>
	 </xsl:template>
		 
		 <xsl:template match="domains"/>
	
		<xsl:template match="cl:clause">
		<xsl:variable name="id" select="@id"/>
		<table border="0">
 
			<tr>
				<td valign="center">
					<table border="1">
						<xsl:attribute name="bgcolor"><xsl:choose><xsl:when test="@level = 'primary'">white</xsl:when><xsl:otherwise>white</xsl:otherwise></xsl:choose></xsl:attribute>
						<tr>
							<th class="cid">
								<xsl:value-of select="@id"/>
								<xsl:if test="@connect">
								<div class="connect">
									
									<xsl:choose>
										<xsl:when test="preceding::cl:clause[@id = current()/@connect]">&#8598;</xsl:when>
										<xsl:otherwise>&#8601;</xsl:otherwise>
									</xsl:choose>
								
									<xsl:value-of select="substring-after(@connect,'.')"/>
								</div>
								</xsl:if>
							</th>
							<xsl:apply-templates/>
						</tr>
					</table>
				</td>
			</tr>

		</table>
	</xsl:template>
	<xsl:template match="cl:S|cl:P|cl:A|cl:C|cl:F|cl:add">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table border="1" class="embedcomp">
					<td class="grk" valign="top">
						<table border="0">
							<tr>
								<th style="font-family: arial; font-size: 10pt">
									
										<xsl:value-of select="local-name()"/>
									   <span class="compAtt">
									   <xsl:if test="@process | @circum | @role">
										   (<xsl:value-of select="@process | @circum | @role"/>)</xsl:if>
									   </span>
								</th>
							</tr>
							<tr>
								<td>
									<xsl:apply-templates select="text()|*[not(@connect)]"/>
								</td>
							</tr>
						</table>
					</td>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<td class="grk" valign="top">
					<table border="0">
						<tr>
							<th style="font-family: arial; font-size: 10pt">
							 
									<xsl:value-of select="local-name()"/>
								 
								  <span class="compAtt">   <xsl:if test="@process | @circum | @role">
										   (<xsl:value-of select="@process | @circum | @part"/>)</xsl:if>
									   </span>
							</th>
						</tr>
						<tr>
							<td>
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
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name()='A' or local-name()='C' or local-name()='P']">
				<span style="text-decoration: underline;" class="grk">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<td class="grk">
					<xsl:apply-templates/>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="cl:conj">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name()='A' or local-name()='C' or local-name()='P']">
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
				<td class="grk">
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
<xsl:template match="w">
    <xsl:if test="$showIDs=1">
        <span class="wid"><xsl:value-of select="substring-after(@xlink:href,'.')"/></span>
    </xsl:if>
 
 
    <xsl:value-of select="wf"/>
	
	<xsl:choose>
		<xsl:when test="child::*[1][self::VBF or self::VBP or self::VBN or self::NON or self::ADJ or self::ADV] and count(sem/domain)&gt;1">
			<select>
				 
					<xsl:choose>
						<xsl:when test="sem/domain/@select">
							<xsl:attribute name="onchange">if (this.name.indexOf('$')==-1) { this.name='$' +this.name; }</xsl:attribute>
							<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="onclick">if (this.name.indexOf('$')==-1) { this.name='$' +this.name; }</xsl:attribute>
							<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
						</xsl:otherwise>	
					</xsl:choose>
				 
				<xsl:for-each select="sem/domain">
					<xsl:variable name="dom" select="@majorNum"/>
					<xsl:variable name="domname" select="//domains/domain[@num=$dom]"/>			
					<option value="{$dom}">
						<xsl:if test="@select">
							<xsl:attribute name="selected">yes</xsl:attribute>	
							<xsl:attribute name="style">color: blue</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$dom"/>: <xsl:value-of select="substring($domname,1,30)"/>
						<xsl:if test="string-length($domname)&gt;30">...</xsl:if>
					
					</option>		
				</xsl:for-each>
			</select>
		</xsl:when>
		<xsl:when test="child::*[1][self::VBF or self::VBP or self::VBN or self::NON or self::ADJ or self::ADV] ">
		<span class="domnum"><xsl:value-of select="sem/domain/@majorNum"/></span>
		</xsl:when>	
	</xsl:choose>	
	
    &#160;
 
</xsl:template>
<xsl:template match="gloss"/>
</xsl:stylesheet>

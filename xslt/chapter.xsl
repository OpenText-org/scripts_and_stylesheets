<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sql="http://apache.org/cocoon/SQL/2.0">
	<xsl:param name="from"/>
	<xsl:param name="to"/>
	<xsl:param name="clause"/>
	<xsl:param name="chapter" select="//chapter/@num"/>
	<xsl:param name="book" select="//chapter/@book"/>
	<xsl:param name="version" select="//chapter/@ver"/>
	<xsl:template match="/">
		<html>
			<head>
				<style><![CDATA[
                        .grk {font-family: 'Georgia Greek', Athena, 'Arial Unicode'}
				.wid { vertical-align: middle; font-family: Arial; margin-right: 1pt; padding-right: 0pt; 
					font-size: 7pt; color: green; text-decoration: none;}
		
                        
                        .button2  { background-color: #f0f0f0;
                        		border: 4px red solid;
                        		font-family: Verdana; font-size: 10px;
                        		
                        		padding: 2px;
                        		font-weight: bold;
                        		}

                        
                        .button1 { background-color: #e0e0e0;
                        		border: 2px #f0f0f0 outset;
                        		font-family: Verdana; font-size: 10px;
                        		
                        		padding: 2px;
                        		font-weight: bold;
                        		}
                        		
                        	.button-text {color: black; text-decoration: none;}
                        	.button-text:hover { color: red;}
			]]></style>
			</head>
			<body>
				<hr/>
				<a href="http://www.opentext.org">
					<img src="http://www.opentext.org/images/small-logo.jpeg" border="0"/>
				</a>
				<h1><xsl:value-of select="$book"/><xsl:text>&#x20;</xsl:text> <xsl:value-of select="$chapter"/></h1>
				<h2>Version <xsl:value-of select="$version"/></h2>
				
				
					<br/>(N.B. This page uses Unicode encoding, suitable fonts include Georgia Greek, Athena)
                              <hr/>
				<xsl:apply-templates select=".//cl:clause[@level='primary']"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="cl:clause">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="comments">
			<xsl:value-of select="//comments//sql:row[sql:clause = $id]/sql:cnt"/>
		</xsl:variable>
		
		<a id="{$id}"/>
		<br/>
		
		<xsl:variable name="id" select="@id"/>
		<table border="0">
			<tr>
				<td width="100px">&#x20;</td>
				<td valign="center">
					<xsl:apply-templates select="//cl:clause[@level='secondary'][@connect=$id][ancestor::*[1]][following::cl:clause/@id=$id]"/>
				</td>
			</tr>

			<tr>
				<xsl:if test="not(ancestor::cl:clause)">
					<td>
						<xsl:choose>
							<xsl:when test="$comments > 0">
								<div class="button2">
									<a class="button-text" target="comment">
										<xsl:attribute name="href"><xsl:text>comment</xsl:text>
										<xsl:value-of select="$chapter"/>
										<xsl:text>?clause=</xsl:text><xsl:value-of select="$id"/></xsl:attribute>
										<xsl:text>See </xsl:text>
										<xsl:value-of select="$comments"/>
										<xsl:text> comment</xsl:text>
										<xsl:if test="$comments > 1">
											<xsl:text>s</xsl:text>
										</xsl:if>
									</a>
								</div>
							</xsl:when>
							<xsl:otherwise>
								<div class="button1">
									<a class="button-text" target="comment">
										<xsl:attribute name="href"><xsl:text>comment</xsl:text>
										<xsl:value-of select="$chapter"/>
										<xsl:text>?clause=</xsl:text><xsl:value-of select="$id"/></xsl:attribute>
					Add comment
				</a>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</xsl:if>
				<td valign="center" colspan="2">
					<table border="1">
						<xsl:attribute name="bgcolor"><xsl:choose><xsl:when test="@level = 'primary'">pink</xsl:when><xsl:otherwise>#e0e0e0</xsl:otherwise></xsl:choose></xsl:attribute>
						<tr>
							<th style="font-family: arial">
								<xsl:value-of select="@id"/>
							</th>
							<xsl:apply-templates/>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100px">&#x20;</td>
				<td valign="center">
					<xsl:apply-templates select="//cl:clause[@level='secondary'][@connect=$id][ancestor::*[1]][preceding::cl:clause/@id=$id]"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="cl:S|cl:P|cl:A|cl:C">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table border="1">
					<td class="grk" valign="top" nowrap="nowrap">
						<table border="0">
							<tr>
								<th style="font-family: arial; font-size: 10pt">
									<center>
										<xsl:value-of select="local-name()"/>
									</center>
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
				<td class="grk" valign="top" nowrap="nowrap">
					<table border="0">
						<tr>
							<th style="font-family: arial; font-size: 10pt">
								<center>
									<xsl:value-of select="local-name()"/>
								</center>
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
				<td style="text-decoration: underline;" class="grk">
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
		<span><span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
		<xsl:value-of select="translate(normalize-space(.),' ','')"/></span>
	</xsl:template>
</xsl:stylesheet>

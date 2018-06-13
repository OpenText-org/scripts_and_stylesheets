<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause" xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sql="http://apache.org/cocoon/SQL/2.0"
 xmlns:xalan="http://xml.apache.org/xalan"
>
	
	<xsl:include href="combinedChart.xsl"/>
	
	<xsl:param name="from"/>
	<xsl:param name="to"/>
	<xsl:param name="clause"/>
	<xsl:param name="chapter" select="//chapter/@num"/>
	<xsl:param name="book" select="//chapter/@book"/>
	<xsl:param name="version" select="//chapter/@ver"/>

	<xsl:param name="mode"/>

	<xsl:variable name="lc">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="uc">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

	


	<xsl:template match="/">
		<html>
			<head>
				<style><![CDATA[
                        .grk {font-family: 'Georgia Greek'}
                        
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

.grk { font-family: 'Georgia Greek'}
					.id { font-size: 7pt; font-family: Verdana; color: blue; margin-right: 0pt; vertical-align: middle; font-weight: normal;}
					
					 .ma { vertical-align: -12pt; position: relative; left: 0pt}
					  .mb { vertical-align: -12pt; position: relative; left: 0pt}
     					.m { vertical-align: -12pt; position: relative;}

					.h { font-weight: bold;}
					
					 .pt {font-weight: normal; font-size: 7pt; vertical-align: 5pt; background-color: #D9F3D9; font-family: Verdana; font-weight: bold; color: brown; left: -2pt;}

					.dom { font-family: Verdana; color: white; background-color: black; font-size: 7pt; position: relative; vertical-align: 5pt; font-weight: bold;}
					
					.clause-primary { margin-bottom: 20pt; background-color: pink;}
					.clause-secondary-after { margin-left: 50pt; background-color: #e0e0e0; margin-top: -20pt; margin-bottom: 20pt;}
					.clause-secondary-before { margin-left: 50pt; background-color: #e0e0e0; margin-top: 0pt; margin-bottom: 20pt;}

					.clause-embed { background-color: #e0e0e0; margin-bottom: 10pt; margin-top: 10pt;}
					
					.modifier { font-style: italic; font-size: 8pt;}
					.arrow-b {font-size: 12pt; left: 2pt}
					.arrow-a {font-size: 12pt; left: -2pt}

					.wgid { margin-left: 2pt; vertical-align: 10pt; font-family: Verdana; font-weight: bold; font-size: 7pt; color: black; padding-left: 2pt; border-top: 1pt solid black; border-left: 1pt solid black;}

					.wgend { border-right: 1pt solid black; border-bottom: 1pt solid black; margin-right: 2pt;}

					.cnum { font-weight: bold; font-size: 12pt;}
					
					.ref { font-size: 10pt; font-style: italic;}
					
					.connect { font-size: 11pt;}

					.front { background-color: red; color: white}
					.fore { background-color: green; color: white}
					.back { background-color: blue; color: white}

			]]></style>
			</head>
			<body>
				<hr/>
			<!--	<a href="http://www.opentext.org">
					<img src="http://www.opentext.org/images/small-logo.jpeg" border="0"/>
				</a> -->
				<h1><xsl:value-of select="$book"/><xsl:text>&#x20;</xsl:text> <xsl:value-of select="$chapter"/></h1>
			<!--	<h2>Version <xsl:value-of select="$version"/></h2>
				
				
					<br/>(N.B. This page uses Unicode encoding, suitable fonts include Georgia Greek, Athena) -->
                              <hr/>
				<xsl:apply-templates select=".//cl:clause[not(ancestor::cl:clause)]"/>
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


 
		<table border="1">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@level='primary'">clause-primary</xsl:when>
					<xsl:when test="@level='secondary' and @connect and preceding::cl:clause[@id=current()/@connect]">clause-secondary-after</xsl:when>
					<xsl:when test="@level='secondary' and @connect and following::cl:clause[@id=current()/@connect]">clause-secondary-before</xsl:when>

					<xsl:otherwise>clause-embed</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<tbody>
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
					<td valign="top">
						<table>
							<tbody>
								<tr>
									<th class="cnum"><xsl:value-of select="substring-after(@id,'.')"/></th>
								</tr>
								<tr>
									<td class="ref"><xsl:if test="parent::chapter">(<xsl:value-of select=".//w[1]/@ref"/>)</xsl:if></td>
								</tr>
								<tr>
									<td class="connect"><xsl:if test="@connect">&#8592;<xsl:value-of select="substring-after(@connect,'.')"/></xsl:if></td>
								</tr>
	
							</tbody>
						</table>
					
					</td>
					<xsl:apply-templates/>
				</tr>
			</tbody>
		</table>
 
	</xsl:template>


<!--
	<xsl:template match="cl:S|cl:P|cl:A|cl:C">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table border="1">
					<td class="grk" valign="top">
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
				<td class="grk" valign="top">
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
		<xsl:value-of select="."/>
	</xsl:template>
-->
</xsl:stylesheet>

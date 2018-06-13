<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:cl="http://www.opentext.org/ns/clause" 
xmlns:pl="http://www.opentext.org/ns/paragraph" 
xmlns:wg="http://www.opentext.org/ns/word-group" 
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:xalan="http://xml.apache.org/xalan"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="fullid">true</xsl:param>
	
	<wg:lookup>
		<role name="specifier">sp</role>
		<role name="definer">df</role>
		<role name="qualifier">ql</role>
		<role name="relator">rl</role>	
		<!--
		<color num="1">rgb(204,255,102)</color>
		<color num="2">rgb(255,255,153)</color>
		<color num="3">rgb(255,204,153)</color>
		<color num="4">rgb(153,204,255)</color>
		<color num="5">rgb(153,51,255)</color>
		<color num="6">rgb(102,255,255)</color>
		-->					
	</wg:lookup>
	
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Clause Diagram</title>
				<style type="text/css">
					.grk { font-family: 'Georgia Greek'}
					.id { font-size: 7pt; font-family: Verdana; color: blue; margin-right: 0pt; vertical-align: middle; font-weight: normal;}
					
					 .ma { vertical-align: -12pt; position: relative; left: 0pt}
					  .mb { vertical-align: -12pt; position: relative; left: 0pt}
     					.m { vertical-align: -12pt; position: relative;}

					.h { font-weight: bold;}
					
					 .pt {font-weight: normal; font-size: 7pt; vertical-align: 5pt; background-color: #D9F3D9; font-family: Verdana; font-weight: bold; color: brown; left: -2pt;}

					.dom { font-family: Verdana; color: white; background-color: black; font-size: 7pt; position: relative; left: -2pt; vertical-align: 5pt; font-weight: bold;}
					
					.clause-primary { margin-bottom: 20pt; background-color: pink;}
					.clause-secondary-after { margin-left: 50pt; background-color: #e0e0e0; margin-top: -20pt; margin-bottom: 20pt;}
					.clause-secondary-before { margin-left: 50pt; background-color: #e0e0e0; margin-top: 0pt; margin-bottom: 20pt;}

					.clause-embed { background-color: #e0e0e0;}
					
					.modifier { font-style: italic; font-size: 8pt;}
					.arrow-b {font-size: 12pt; left: 2pt}
					.arrow-a {font-size: 12pt; left: -2pt}

					.wgid { margin-left: 2pt; vertical-align: 10pt; font-family: Verdana; font-weight: bold; font-size: 7pt; color: black; padding-left: 2pt; border-top: 1pt solid black; border-left: 1pt solid black;}

					.wgend { border-right: 1pt solid black; border-bottom: 1pt solid black; margin-right: 2pt;}

					.cnum { font-weight: bold; font-size: 12pt;}
					
					.ref { font-size: 10pt; font-style: italic;}
					
					.connect { font-size: 11pt;}

				</style>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8;"/>

			</head>
			<body>
			
					<xsl:apply-templates/>
			
			</body>


		</html>
	</xsl:template>
	
	
	<xsl:template match="cl:clause">
	
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
					<td valign="top">
						<table>
							<tbody>
								<tr>
									<th class="cnum">									<xsl:choose>
											<xsl:when test="$fullid='false'"><xsl:value-of select="substring-after(@id,'.')"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@id"/></xsl:otherwise>
										</xsl:choose>
									</th>
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
	
	<xsl:template match="cl:S|cl:P|cl:C|cl:A|pl:conj">
		<xsl:choose>
			<xsl:when test="parent::cl:clause">
				<td valign="top">
					<table>
						<tbody>
							<tr>
								<th><xsl:value-of select="local-name()"/></th>
							</tr>
							<tr>
								<td>
									<xsl:variable name="content">
										<xsl:apply-templates/>
									</xsl:variable>
									<xsl:apply-templates select="xalan:nodeset($content)/*[1]" mode="content"/>
								</td>
							</tr>
						</tbody>
					</table>
				</td>		
		</xsl:when>
	
		<xsl:otherwise>
		<span style="display: inline">
		<table border="1" style="display: inline">
			<tbody>
				<tr>
					<th><xsl:value-of select="local-name()"/></th>
				</tr>
				<tr>
					<td>
						<xsl:variable name="content">
							<xsl:apply-templates/>
						</xsl:variable>
						<xsl:apply-templates select="xalan:nodeset($content)/*[1]" mode="content"/>
					</td>
				</tr>
			</tbody>
		</table>
</span>
		</xsl:otherwise>
	</xsl:choose>

	</xsl:template>
	

	
	

	<xsl:template match="w">
		<xsl:if test="not(preceding::w[@wg=current()/@wg])"><wgStart/><span class="wgid">wg<xsl:value-of select="substring-after(@wg,'_')"/></span></xsl:if>


		<span >
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="@role='head'">h</xsl:when>
					<xsl:when test="@modifies and preceding::w[@id=current()/@modifies]">ma</xsl:when>
					<xsl:when test="@modifies and following::w[@id=current()/@modifies]">mb</xsl:when>
					
				</xsl:choose>
			</xsl:attribute>
			<xsl:if test="@modifies">
				<xsl:variable name="depth">
				<xsl:call-template name="depth">
					<xsl:with-param name="depth">1</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select="@modifies"/></xsl:with-param>
				</xsl:call-template>
				</xsl:variable>
				<xsl:attribute name="style">vertical-align: -<xsl:value-of select="$depth*12"/>pt</xsl:attribute>
			</xsl:if>
			
			<xsl:if test="@modifies and preceding::w[@id=current()/@modifies] and not(@role='head')"><span class="modifier"><span class="arrow-b">&#8598;</span><xsl:value-of select="document('')//role[@name=current()/@role]"/></span></xsl:if>
			
			<span class="id"><xsl:value-of select="substring-after(@id,'.')"/></span>
			<span>
				<xsl:if test="@partRef"><xsl:attribute name="style">background-color: <xsl:value-of select="document('')//color[@num=current()/@partRef]"/></xsl:attribute></xsl:if>
			<xsl:apply-templates/></span>
			<xsl:if test="@partRef">
				<span class="pt"><xsl:value-of select="@partRef"/><xsl:value-of select="@partType"/></span>
			</xsl:if>
			<xsl:if test="child::*[1][starts-with(local-name(),'VB') or starts-with(local-name(),'AD') or self::NON]">
				<span class="dom">
					<xsl:choose>
						<xsl:when test="sem/dom[@primarydomain]">
								<xsl:value-of select="sem/dom[@primarydomain]/@majorNum"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="sem/dom[1]/@majorNum"/>
						</xsl:otherwise>
					</xsl:choose>
				</span>
			</xsl:if>
			<xsl:if test="@modifies and following::w[@id=current()/@modifies] and not(@role='head')"><span class="modifier"><xsl:value-of select="document('')//role[@name=current()/@role]"/><span class="arrow-a">&#8599;</span></span></xsl:if>
			
		</span>
 	

				<xsl:if test="not(following::w[@wg=current()/@wg])"><span class="wgend">&#160;</span><wgEnd/></xsl:if>

	</xsl:template>

	<xsl:template match="wf">
		<span class="grk"><xsl:apply-templates/></span>
	</xsl:template>
	
	
	<xsl:template name="depth">
		<xsl:param name="depth"/>
		<xsl:param name="id"/>
		<xsl:choose>
			<xsl:when test="//w[@id=$id][not(@role='head')]">
				<xsl:call-template name="depth">
					<xsl:with-param name="depth"><xsl:value-of select="$depth+1"/></xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select="//w[@id=$id]/@modifies"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$depth"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<!-- templates for processing word group milestones -->
	<xsl:template match="*" mode="content">
		<xsl:choose>
			<xsl:when test="self::wgStart">
				<table>
					<tbody>
						<tr>
							<td nowrap="nowrap">
							<!--	<xsl:variable name="starts" select="count(preceding-sibling::wgStart)+1"/> -->
								<xsl:variable name="ends" select="count(preceding-sibling::wgEnd)"/> 
 								<xsl:apply-templates select="following-sibling::*[count(preceding-sibling::wgEnd)=$ends]" mode="copy"/>  
							&#160;</td>
						</tr>
					</tbody>
				</table>
				<xsl:apply-templates select="following-sibling::wgEnd[1]/following-sibling::*[1]" mode="content"/>

			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates mode="copy"/>
				</xsl:copy>
				<xsl:apply-templates select="following-sibling::*[1]" mode="content"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!--	<xsl:template match="wgEnd" mode="copy"/> -->

	<xsl:template match="*" mode="copy">
			<xsl:copy>
				<xsl:copy-of select="@*"/>
				<xsl:apply-templates mode="copy"/>
			</xsl:copy>
	</xsl:template>	

	
</xsl:stylesheet>

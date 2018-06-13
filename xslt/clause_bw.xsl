<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xalan="http://xml.apache.org/xalan"
                   exclude-result-prefixes="xalan"
>
 
 	<xsl:output method="xml" encoding="UTF-8" version="1.0"/>
 
	<xsl:param name="book">mark</xsl:param>	
		
 

	 <xsl:variable name="showIDs">1</xsl:variable>

 
		 
	
		<xsl:template match="cl:clause">
		<xsl:variable name="id" select="@id"/>
		<table border="0">
 
			<tr>
				<td valign="center">
					<table border="1">
						<xsl:attribute name="bgcolor"><xsl:choose><xsl:when test="@level = 'primary'">white</xsl:when><xsl:otherwise>white</xsl:otherwise></xsl:choose></xsl:attribute>
						<tr>
							<th style="font-family: arial">
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
	<xsl:template match="cl:S|cl:P|cl:A|cl:C">
		<xsl:choose>
			<xsl:when test="ancestor::*[1][local-name() = 'S' or local-name() = 'C' or local-name() = 'A' or local-name() = 'P']">
				<table border="1">
					<td style="font-family: 'Georgia Greek'" valign="top">
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
				<td style="font-family: 'Georgia Greek'" valign="top">
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
				<span style="text-decoration: underline; font-family: 'Georgia Greek'">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<td style="text-decoration: underline; font-family: 'Georgia Greek'">
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
				<td style="font-family: 'Georgia Greek'">
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
 
 
    <xsl:value-of select="//w[@id=current()/@xlink:href]/wf"/>
 
</xsl:template>
</xsl:stylesheet>

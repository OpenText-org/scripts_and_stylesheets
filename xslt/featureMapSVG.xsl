<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:math="http://exslt.org/math"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:strip-space elements="*"/>
	
	<xsl:param name="feature">tf</xsl:param>
	
	<xsl:variable name="rowCount" select="count(//row)"/>
	
	<!-- height of column strips in # of clauses -->
	<xsl:param name="columnHeight"><xsl:value-of select="round(math:sqrt($rowCount))"/></xsl:param>
	
	<!-- width of column strips -->
	<xsl:param name="columnWidth">20</xsl:param>
	
	<xsl:template match="/">
	
		<!-- draw column borders -->
		<xsl:variable name="c1" select="round($rowCount div $columnHeight)"/>
		<xsl:variable name="columns" select="if ($c1 * $columnHeight &lt; $rowCount) then $c1 + 1 else $c1"/>
	
		<svg xmlns="http://www.w3.org/2000/svg" width="{$columns + 10}px" height="{$columnHeight + 10}px">
			<desc>Logogenesis feature plot for <xsl:value-of select="//book/@name"/></desc>
			 
			<g transform="translate(5,0)">


				<rect x="-1" y="0" height="{$columns + 2}" width="{$columnHeight + 2}" style="fill: #000000; stroke: black; "/>
				

				<!-- top 
				<line x1="" y1="" x2="" y2="" style="stroke: black; "/>
				-->
				<!-- right1 
				<line x1="" y1="" x2="" y2="" style="stroke: black; "/>
				-->
				<!-- bottom 
				<line x1="" y1="" x2="" y2="" style="stroke: black; "/>-->
				
				
				<xsl:for-each select="//row">
					<xsl:variable name="x" select="position() mod $columnHeight"/>
					<xsl:variable name="ytemp" select="round(position() div $columnHeight)" />
					<xsl:variable name="y" select="if ($ytemp * $columnHeight &lt; position()) then $ytemp + 1 else $ytemp"/>
					
					
				
					<xsl:variable name="color">
						<xsl:call-template name="getColor">
							<xsl:with-param name="feature" select="$feature"/>
						</xsl:call-template>
					</xsl:variable>
					
				
					<rect xmlns="http://www.w3.org/2000/svg" width="1" height="1" x="{$x}" y="{$y}" style="fill: {$color}; "/>
					
					
				</xsl:for-each>
				
						
				
			</g>
			
		</svg>

	</xsl:template>
	
	<xsl:template name="getColor">
		<xsl:param name="feature"/>
		<xsl:choose>
			<xsl:when test="$feature='tf'">
				<xsl:choose>
					<xsl:when test=".//@tf='aor'">rgb(251,189,183)</xsl:when>
					<xsl:when test=".//@tf='pre' or .//@tf='imp'">rgb(247,128,115)</xsl:when>
					<xsl:when test=".//@tf='per' or .//@tf='plu'">rgb(240,37,15)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>			
			</xsl:when>
			<xsl:when test="$feature='voc'">
				<xsl:choose>
					<xsl:when test=".//@voc='act'">rgb(206,145,221)</xsl:when>
					<xsl:when test=".//@voc='pas'">rgb(180,86,203)</xsl:when>
					<xsl:when test=".//@voc='mid'">rgb(164,58,190)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>			
			</xsl:when>
			<xsl:when test="$feature='mod'">
				<xsl:choose>
					<xsl:when test=".//@tf='fut'">rgb(0,128,0)</xsl:when>
					<xsl:when test=".//@mod='ind'">rgb(125,255,125)</xsl:when>
					<xsl:when test=".//@mod='sub' or .//@mod='opt'">rgb(45,255,45)</xsl:when>
					<xsl:when test=".//@mod='imp'">rgb(0,210,0)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>			
			</xsl:when>
			<xsl:when test="$feature='theme'">
				<xsl:choose>
					<xsl:when test="./theme='P'">rgb(146,224,250)</xsl:when>
					<xsl:when test="./theme='A'">rgb(99,210,248)</xsl:when>
					<xsl:when test="./theme='S'">rgb(54,198,245)</xsl:when>
					<xsl:when test="./theme='C'">rgb(12,181,237)</xsl:when>										
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>			
			</xsl:when>
			<xsl:when test="$feature='person'">
				<xsl:choose>
					<xsl:when test="./person/num='1st'">rgb(240,77,109)</xsl:when>
					<xsl:when test="./person/num='2nd'">rgb(243,122,147)</xsl:when>
					<xsl:when test="./person/num='3rd'">rgb(251,208,217)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>
			</xsl:when>																					
			<xsl:when test="$feature='level'">
				<xsl:choose>
					<xsl:when test="./level='primary'">rgb(166,166,244)</xsl:when>
					<xsl:when test="./level='secondary' or ./level='secondary2'">rgb(135,135,241)</xsl:when>
					<xsl:when test="./level='embedded'">rgb(101,101,237)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>
			</xsl:when>		
		</xsl:choose>

	</xsl:template>
	
</xsl:stylesheet>

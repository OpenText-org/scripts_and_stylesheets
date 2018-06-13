<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:math="http://exslt.org/math"
>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:strip-space elements="*"/>
	
	<xsl:param name="feature">voc</xsl:param>
	
	<xsl:variable name="rowCount" select="count(//row)"/>
	
	
	
	<xsl:template match="/">
	
	
		<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
			<desc>Logogenesis feature plot for <xsl:value-of select="//book/@name"/></desc>
			<g transform="scale(2) translate(10,10)">
				<xsl:apply-templates select="//rowGroup"/>
			</g>
		</svg>
	</xsl:template>
	
	<xsl:template match="rowGroup">
		<!-- average size of block in current map row (use this to set height of blocks in row ) -->
		<xsl:variable name="blockSize" select="round(avg(text/@clauses))"/>
 
		<!-- block height  -->
		<xsl:variable name="blockHeight" select="round(math:sqrt($blockSize))"/>
	
		<xsl:apply-templates>
			<xsl:with-param name="blockHeight" select="$blockHeight"/> 
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="text">	 
	
			<xsl:param name="blockHeight"/>
			
			<!-- calculate block width -->
			<xsl:variable name="bw" select="round(@clauses div $blockHeight)"/>
			<xsl:variable name="blockWidth" select="if ($bw * $bw &lt; @clauses) then $bw + 1 else $bw"/>
	
			<!-- calculate offsets -->
			<xsl:variable name="offsetX">
				<xsl:call-template name="precedingBlocks">
					<xsl:with-param name="blockHeight" select="$blockHeight"/>
				</xsl:call-template>
			</xsl:variable>
			
			<xsl:variable name="offsetY">
				<xsl:for-each select="parent::rowGroup">
					<xsl:call-template name="blockHeight"/>
				</xsl:for-each>
			</xsl:variable>
			
			<xsl:variable name="filename">../XML/featureData/<xsl:value-of select="@ref"/>.xml</xsl:variable>
	
			<g transform="translate({$offsetX},{$offsetY})"  xmlns="http://www.w3.org/2000/svg" bw="{$blockWidth}" bh="{$blockHeight}" >


				<!-- background -->
				<rect x="-1" y="0" height="{$blockHeight + 2}" width="{$blockWidth + 2}" style="fill: #a0a0a0; stroke: #a0a0a0; "/>
								
				<xsl:for-each select="document($filename)//row">
					<xsl:variable name="x" select="position() mod $blockWidth"/>
					<xsl:variable name="ytemp" select="round(position() div $blockWidth)" />
					<xsl:variable name="y" select="if ($ytemp * $blockWidth &lt; position()) then $ytemp + 1 else $ytemp"/>
					
					
				
					<xsl:variable name="color">
						<xsl:call-template name="getColor">
							<xsl:with-param name="feature" select="$feature"/>
						</xsl:call-template>
					</xsl:variable>
					
				
					<rect width="1" height="1" x="{$x}" y="{$y}" style="fill: {$color}; "/>
					
					
				</xsl:for-each>
				
						
				
			</g>

	</xsl:template>
	
	
	<!-- calculate width of preceding block to give X offset for current block -->
	<xsl:template name="precedingBlocks">
		<xsl:param name="offset">0</xsl:param>
		<xsl:param name="blockHeight"/>
		<xsl:choose>
			<xsl:when test="preceding-sibling::text">
				<xsl:for-each select="preceding-sibling::text[1]">
					<xsl:variable name="newOffset" select="$offset + round(@clauses div $blockHeight)"/>
					<xsl:call-template name="precedingBlocks">
						<xsl:with-param name="blockHeight" select="$blockHeight"/>
						<xsl:with-param name="offset" select="$newOffset"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$offset"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- calculate y offset from heights of preceding rows of blocks -->
	<xsl:template name="blockHeight">
		<xsl:param name="offset">0</xsl:param>
		<xsl:choose>
			<xsl:when test="preceding-sibling::rowGroup">
				<xsl:for-each select="preceding-sibling::rowGroup[1]">
					<!-- average size of block in current map row (use this to set height of blocks in row ) -->
					<xsl:variable name="blockSize" select="round(avg(text/@clauses))"/>
 
					<!-- block height  -->
					<xsl:variable name="blockHeight" select="round(math:sqrt($blockSize))"/>
	
					<xsl:call-template name="blockHeight">
						<xsl:with-param name="offset" select="$offset + $blockHeight + 2"/>
					</xsl:call-template>				
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$offset"/></xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>
	
	<!-- return color value for current clause for selected feature -->
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
					<xsl:when test=".//@voc='act'">rgb(225,183,251)</xsl:when>
					<xsl:when test=".//@voc='pas'">rgb(198,115,247)</xsl:when>
					<xsl:when test=".//@voc='mid'">rgb(156,15,240)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>			
			</xsl:when>
			<xsl:when test="$feature='mod'">
				<xsl:choose>
					<xsl:when test=".//@tf='fut'">rgb(6,117,159)</xsl:when>
					<xsl:when test=".//@mod='ind'">rgb(215,242,253)</xsl:when>
					<xsl:when test=".//@mod='sub' or .//@mod='opt'">rgb(126,216,250)</xsl:when>
					<xsl:when test=".//@mod='imp'">rgb(30,187,247)</xsl:when>
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
					<xsl:when test="./person/num='1st'">rgb(48,58,186)</xsl:when>
					<xsl:when test="./person/num='2nd'">rgb(95,103,214)</xsl:when>
					<xsl:when test="./person/num='3rd'">rgb(169,174,233)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$feature='level'">
				<xsl:choose>
					<xsl:when test="./level='primary'">rgb(255,255,255)</xsl:when>
					<xsl:when test="./level='secondary' or ./level='secondary2'">rgb(255,255,255)</xsl:when>
					<xsl:when test="./level='embedded'">rgb(255,255,255)</xsl:when>
					<xsl:otherwise>rgb(255,255,255)</xsl:otherwise>
				</xsl:choose>
			</xsl:when>														
		</xsl:choose>

	</xsl:template>
	
</xsl:stylesheet>
